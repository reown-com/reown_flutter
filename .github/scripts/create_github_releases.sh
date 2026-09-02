#!/usr/bin/env bash
#
# create_github_releases.sh
#
# Creates one GitHub Release per published package version, named
# "<package_name>-v<version>" (e.g. reown_core-v1.4.0), targeting a specific
# commit SHA. Creating a release also creates its lightweight tag when absent.
#
# Two modes (env MODE):
#   manifest  - read the committed release manifest (the normal, automated path
#               driven by the merged release PR). Every listed version MUST be on
#               pub.dev or the run fails.
#   manual    - scan the fixed package list's CURRENT pubspec versions
#               (workflow_dispatch recovery/backfill). Versions not yet on
#               pub.dev are skipped, not failed.
#
# Required env:
#   MODE           manifest | manual
#   TARGET_SHA     commit the releases point at
#   GH_TOKEN       token for the gh CLI (contents: write)
# Manifest mode:
#   MANIFEST_PATH  path to publish_workflow_<n>.json
# Optional env:
#   DRY_RUN        "true" prints intended actions, creates nothing (default false)
#   SUMMARY_FILE   file to append created tag names to (one per line), for Slack
#   PUBDEV_MAX_ATTEMPTS  transient-retry attempts (default 10)
#   PUBDEV_SLEEP         seconds between attempts (default 6)
#
set -euo pipefail

# The eight packages that have a publish job in publish-packages.yml
# (dir == package name for all of them). This list MUST mirror those jobs:
# a manifest can only ever contain packages that were actually published there.
# reown_yttrium_utils is intentionally excluded — it has no publish job, so it
# never appears in a manifest. Add it here only if/when a publish job is added.
ALLOWLIST=(
  reown_core
  reown_sign
  reown_appkit
  reown_walletkit
  reown_yttrium
  reown_cli
  pos_client
  walletconnect_pay
)

MODE="${MODE:?MODE is required (manifest|manual)}"
TARGET_SHA="${TARGET_SHA:?TARGET_SHA is required}"
DRY_RUN="${DRY_RUN:-false}"
SUMMARY_FILE="${SUMMARY_FILE:-}"
PUBDEV_MAX_ATTEMPTS="${PUBDEV_MAX_ATTEMPTS:-10}"
PUBDEV_SLEEP="${PUBDEV_SLEEP:-6}"

log()  { echo "[create-releases] $*"; }
die()  { echo "[create-releases][FATAL] $*" >&2; exit 1; }

if [[ -n "$SUMMARY_FILE" ]]; then
  : > "$SUMMARY_FILE"
fi

in_allowlist() {
  local needle="$1" p
  for p in "${ALLOWLIST[@]}"; do
    [[ "$p" == "$needle" ]] && return 0
  done
  return 1
}

# Echo the HTTP status for a pub.dev version, "000" on curl failure.
pubdev_status() {
  local name="$1" version="$2"
  curl -s -o /dev/null -w "%{http_code}" --max-time 15 \
    "https://pub.dev/api/packages/${name}/versions/${version}" 2>/dev/null || echo "000"
}

# 0 = published (200), 1 = definitively absent (404),
# 2 = transient/unknown after retries.
verify_pubdev() {
  local name="$1" version="$2" attempt status
  for (( attempt=1; attempt<=PUBDEV_MAX_ATTEMPTS; attempt++ )); do
    status="$(pubdev_status "$name" "$version")"
    case "$status" in
      200) return 0 ;;
      404) return 1 ;;
      *)
        log "pub.dev ${name} ${version}: attempt ${attempt}/${PUBDEV_MAX_ATTEMPTS} -> HTTP ${status}; retrying in ${PUBDEV_SLEEP}s"
        sleep "$PUBDEV_SLEEP"
        ;;
    esac
  done
  return 2
}

# Highest same-package tag strictly below $version, reachable from TARGET_SHA.
# Echoes the full tag (e.g. "reown_core-v1.3.9") or nothing.
previous_tag() {
  local name="$1" version="$2" vers prev_ver
  vers="$(git tag --list "${name}-v*" --merged "$TARGET_SHA" 2>/dev/null \
            | sed -n "s/^${name}-v//p" \
            | grep -E '^[0-9]+\.' || true)"
  [[ -z "$vers" ]] && return 0
  # Append the target version, sort, and take the element immediately before it.
  prev_ver="$(printf '%s\n%s\n' "$vers" "$version" \
                | grep -v '^$' \
                | sort -V \
                | awk -v v="$version" '$0==v{print last; exit} {last=$0}')"
  [[ -n "$prev_ver" && "$prev_ver" != "$version" ]] && echo "${name}-v${prev_ver}"
  return 0
}

# Create (or safely skip) the release for one {name, version}.
# require_pubdev=true => a 404 is fatal (manifest asserted it published).
process() {
  local name="$1" version="$2" require_pubdev="$3"
  local tag="${name}-v${version}"
  log "Processing ${tag} (target ${TARGET_SHA})"

  set +e
  verify_pubdev "$name" "$version"
  local rc=$?
  set -e
  case "$rc" in
    0) : ;;
    1)
      if [[ "$require_pubdev" == "true" ]]; then
        die "${tag} not found on pub.dev (HTTP 404) but the manifest asserts it was published"
      fi
      log "SKIP ${tag}: not on pub.dev (manual backfill of an unpublished version)"
      return 0
      ;;
    *)
      die "${tag}: pub.dev verification failed after ${PUBDEV_MAX_ATTEMPTS} attempts (transient/5xx)"
      ;;
  esac

  local release_exists=false tag_exists=false tag_sha=""
  gh release view "$tag" >/dev/null 2>&1 && release_exists=true
  if git rev-parse -q --verify "refs/tags/${tag}" >/dev/null 2>&1; then
    tag_exists=true
    tag_sha="$(git rev-list -n1 "refs/tags/${tag}")"
  fi

  # Both exist -> verify target (manifest mode) and skip.
  if [[ "$release_exists" == true && "$tag_exists" == true ]]; then
    if [[ "$MODE" == "manifest" && "$tag_sha" != "$TARGET_SHA" ]]; then
      die "${tag} already exists at ${tag_sha}, expected ${TARGET_SHA}"
    fi
    log "SKIP ${tag}: release and tag already exist"
    return 0
  fi

  # Release without its tag -> broken state.
  if [[ "$release_exists" == true && "$tag_exists" == false ]]; then
    die "${tag}: a release exists but its tag ref is missing — broken repository state"
  fi

  local -a args
  args=(release create "$tag" --title "$tag" --latest=false)

  local prev
  prev="$(previous_tag "$name" "$version")"
  if [[ -n "$prev" ]]; then
    args+=(--generate-notes --notes-start-tag "$prev")
    log "${tag}: notes generated since ${prev}"
  else
    args+=(--notes "Initial automated release for ${name} ${version}.")
    log "${tag}: no prior same-package tag; using an explicit initial-release note"
  fi

  # Tag exists without a release -> attach to the existing (verified) tag.
  if [[ "$tag_exists" == true ]]; then
    if [[ "$MODE" == "manifest" && "$tag_sha" != "$TARGET_SHA" ]]; then
      die "${tag}: existing tag at ${tag_sha} != target ${TARGET_SHA}"
    fi
    args+=(--verify-tag)
  else
    args+=(--target "$TARGET_SHA")
  fi

  if [[ "$DRY_RUN" == "true" ]]; then
    log "DRY_RUN: would run: gh ${args[*]}"
    return 0
  fi

  gh "${args[@]}"
  log "Created release ${tag}"
  [[ -n "$SUMMARY_FILE" ]] && echo "$tag" >> "$SUMMARY_FILE"
  return 0
}

process_manifest() {
  local mf="${MANIFEST_PATH:?MANIFEST_PATH is required in manifest mode}"
  [[ -f "$mf" ]] || die "manifest not found: ${mf}"

  local schema count dups
  schema="$(jq -r '.schema_version' "$mf")"
  [[ "$schema" == "1" ]] || die "unsupported schema_version: ${schema}"

  count="$(jq '.packages | length' "$mf")"
  [[ "$count" -ge 1 ]] || die "manifest has no packages"

  dups="$(jq -r '.packages[].name' "$mf" | sort | uniq -d)"
  [[ -z "$dups" ]] || die "duplicate package names in manifest: ${dups}"

  local i name version
  for (( i=0; i<count; i++ )); do
    name="$(jq -r ".packages[$i].name" "$mf")"
    version="$(jq -r ".packages[$i].version" "$mf")"
    [[ -n "$name" && "$name" != "null" ]] || die "empty package name at index ${i}"
    [[ -n "$version" && "$version" != "null" ]] || die "empty version at index ${i}"
    in_allowlist "$name" || die "package not in allowlist: ${name}"
    process "$name" "$version" "true"
  done
}

process_manual() {
  local name ps version pubname
  for name in "${ALLOWLIST[@]}"; do
    ps="packages/${name}/pubspec.yaml"
    if [[ ! -f "$ps" ]]; then
      log "SKIP ${name}: no pubspec at ${ps}"
      continue
    fi
    # Use Ruby's stdlib YAML (preinstalled on GitHub runners) — avoids an
    # unpinned yq download in the release workflow.
    pubname="$(ruby -ryaml -e 'puts (YAML.safe_load(File.read(ARGV[0]), permitted_classes: [], permitted_symbols: [], aliases: false)["name"]).to_s' "$ps")"
    version="$(ruby -ryaml -e 'puts (YAML.safe_load(File.read(ARGV[0]), permitted_classes: [], permitted_symbols: [], aliases: false)["version"]).to_s' "$ps")"
    [[ "$pubname" == "$name" ]] || die "pubspec name '${pubname}' != expected '${name}' in ${ps}"
    [[ -n "$version" ]] || die "no version found in ${ps}"
    process "$name" "$version" "false"
  done
}

case "$MODE" in
  manifest) process_manifest ;;
  manual)   process_manual ;;
  *)        die "unknown MODE: ${MODE} (expected manifest|manual)" ;;
esac

log "Done."
