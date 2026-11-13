#!/bin/bash
# Creates IOS_SIMULATORS fresh iPhone simulators (newest iPhone device type),
# slims them with simslim (profile: simslim-ci.json next to this script) and
# boots them; falls back to one existing iPhone simulator. Appends
# DEVICE_IDS=<comma-separated udids> to $GITHUB_ENV. Shared by the iOS legs of
# ci_e2e_pay_tests.yml and ci_e2e_connect_tests.yml; simslim must be on PATH.
#
# Env: IOS_SIMULATORS (1-9), SIMSLIM_BOOT_TIMEOUT (optional, read by simslim)
set -euo pipefail
if ! [[ "$IOS_SIMULATORS" =~ ^[1-9]$ ]]; then
  echo "::error::IOS_SIMULATORS must be 1-9, got '$IOS_SIMULATORS'"
  exit 1
fi
# Don't hardcode a model: Xcode/runner image bumps drop old devices.
# Create fresh devices from the newest iPhone device type, falling back
# to one already-available iPhone simulator. `simctl list devicetypes`
# is newest-first, so take the first match. Filter by name too: the
# iPod touch also has productFamily "iPhone" (current runtimes can't
# create it).
DEVICE_TYPE=$(xcrun simctl list devicetypes -j | \
  jq -r 'first(.devicetypes[] | select(.productFamily == "iPhone" and (.name | startswith("iPhone"))) | .identifier) // empty')
DEVICE_IDS=()
FRESH=true
: > "$RUNNER_TEMP/simctl-create.err"
for i in $(seq 1 "$IOS_SIMULATORS"); do
  if [ -n "$DEVICE_TYPE" ] && ID=$(xcrun simctl create "E2E-iPhone-$i" "$DEVICE_TYPE" 2>"$RUNNER_TEMP/simctl-create.err"); then
    DEVICE_IDS+=("$ID")
  else
    break
  fi
done
if [ "${#DEVICE_IDS[@]}" -eq 0 ]; then
  echo "::warning::Could not create a simulator from '${DEVICE_TYPE:-<none>}' ($(cat "$RUNNER_TEMP/simctl-create.err" 2>/dev/null)); falling back to an existing iPhone simulator"
  DEVICE_TYPE=""
  FRESH=false
  ID=$(xcrun simctl list devices available -j | \
    jq -r '.devices | to_entries[] | select(.key | contains("iOS")) | .value[] | select(.name | startswith("iPhone")) | .udid' | head -1)
  [ -n "$ID" ] && DEVICE_IDS=("$ID")
fi
if [ "${#DEVICE_IDS[@]}" -eq 0 ]; then
  echo "ERROR: no available iPhone simulator found"
  xcrun simctl list devices available
  exit 1
fi
if [ "${#DEVICE_IDS[@]}" -lt "$IOS_SIMULATORS" ]; then
  echo "::warning::Only ${#DEVICE_IDS[@]} of $IOS_SIMULATORS simulators available; running on ${#DEVICE_IDS[@]}"
fi
echo "Using simulator device type: ${DEVICE_TYPE:-<fallback>}, ids: ${DEVICE_IDS[*]}"
SIMSLIM_PROFILE="$(cd "$(dirname "$0")" && pwd)/simslim-ci.json"
# Slim and boot all devices in parallel. simslim writes its overrides
# while the device is still off, so it only applies to freshly created
# devices; the existing-simulator fallback boots stock.
PIDS=()
for ID in "${DEVICE_IDS[@]}"; do
  if [ "$FRESH" = "true" ]; then
    # Fails on drift rather than silently testing on a stock
    # simulator.
    ( simslim on "$ID" --profile "$SIMSLIM_PROFILE" &&
        simslim verify "$ID" --profile "$SIMSLIM_PROFILE" ) &
  else
    ( xcrun simctl boot "$ID" || true ) &
  fi
  PIDS+=($!)
done
for PID in "${PIDS[@]}"; do wait "$PID" || exit 1; done
for ID in "${DEVICE_IDS[@]}"; do
  # Wait for full boot so the steps below don't race a not-ready
  # simulator.
  xcrun simctl bootstatus "$ID" -b
  # Disable UIKit animations to reduce Maestro timing flakiness.
  xcrun simctl spawn "$ID" defaults write com.apple.UIKit UIAnimationDragCoefficient -float 0 || true
done
echo "DEVICE_IDS=$(IFS=,; echo "${DEVICE_IDS[*]}")" >> "$GITHUB_ENV"
