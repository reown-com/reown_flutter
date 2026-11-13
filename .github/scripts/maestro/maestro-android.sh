#!/bin/bash
# Android leg of a tagged Maestro suite (Pay, Connect), run from
# android-emulator-runner's `script` once the emulator is up: installs the
# wallet APK (and the dApp APK for Connect), smoke-checks their launch,
# captures logcat around maestro-suite.sh and exits with its code.
# (android-emulator-runner runs each `script` line in its own `sh -c`, so the
# whole leg lives here instead of inline in the workflow.)
#
# Env: APP_ID, APK_PATH (wallet), ARTIFACTS_DIR (default: debug-artifacts),
# optional DAPP_APP_ID + DAPP_APK_PATH (Connect), plus what maestro-suite.sh
# reads.

SCRIPTS_DIR="$(cd "$(dirname "$0")" && pwd)"
ARTIFACTS_DIR="${ARTIFACTS_DIR:-debug-artifacts}"
export ARTIFACTS_DIR
: "${APP_ID:?APP_ID is required}"
: "${APK_PATH:?APK_PATH is required}"

mkdir -p "$ARTIFACTS_DIR"

echo "Waiting for boot completion..."
adb wait-for-device
# shellcheck disable=SC2016 # expands on the device, not here
adb shell 'while [ "$(getprop sys.boot_completed)" != "1" ]; do sleep 2; done'
adb devices

if [ ! -f "$APK_PATH" ]; then
  echo "ERROR: APK not found at $APK_PATH"
  exit 1
fi
echo "Installing wallet APK: $APK_PATH"
adb install -r "$APK_PATH" || exit 1
if ! adb shell pm list packages | grep -qx "package:$APP_ID"; then
  echo "ERROR: $APP_ID not installed"
  exit 1
fi

# Every app the suite drives: the wallet, plus the dApp when DAPP_APP_ID is set.
SMOKE_APP_IDS=("$APP_ID")
if [ -n "${DAPP_APP_ID:-}" ]; then
  if [ ! -f "${DAPP_APK_PATH:-}" ]; then
    echo "ERROR: dApp APK not found at ${DAPP_APK_PATH:-<unset>}"
    exit 1
  fi
  echo "Installing dApp APK: $DAPP_APK_PATH"
  adb install -r "$DAPP_APK_PATH" || exit 1
  if ! adb shell pm list packages | grep -qx "package:$DAPP_APP_ID"; then
    echo "ERROR: $DAPP_APP_ID not installed"
    exit 1
  fi
  SMOKE_APP_IDS+=("$DAPP_APP_ID")
fi

# Let the system settle after the install.
sleep 10

# Launch smoke check: fail fast if an APK is broken. Without this, a bad build
# surfaces as every Maestro flow failing, which is hard to diagnose.
CRASH_PATTERN="FATAL EXCEPTION|ClassNotFoundException|Unable to instantiate application"
for smoke_app_id in "${SMOKE_APP_IDS[@]}"; do
  echo "Smoke-checking app launch: $smoke_app_id"
  adb logcat -c
  adb shell monkey -p "$smoke_app_id" -c android.intent.category.LAUNCHER 1 || true
  sleep 8
  if adb logcat -d | grep -qE "$CRASH_PATTERN"; then
    echo "ERROR: $smoke_app_id crashed on launch - APK is broken, not running Maestro."
    adb logcat -d | grep -E "$CRASH_PATTERN|AndroidRuntime" | head -40
    exit 1
  fi
  echo "$smoke_app_id launched cleanly."
  adb shell am force-stop "$smoke_app_id"
done
sleep 5

# Clear every buffer so the captures below only cover the suite.
adb logcat -b all -c || true
# Full logcat (uploaded only when the job fails).
adb logcat > "$ARTIFACTS_DIR/full-logcat.txt" 2>&1 &
FULL_PID=$!
# Small always-uploaded capture: crashes, the app's Dart output (`flutter` tag)
# and launch diagnostics (info-level ActivityManager/ActivityTaskManager) for
# the flake where a launch never reaches the app.
adb logcat AndroidRuntime:E ActivityManager:I ActivityTaskManager:I \
  flutter:V '*:F' \
  > "$ARTIFACTS_DIR/android-logcat.log" 2>&1 &
FILTERED_PID=$!
# Events buffer: process start/death and resumed activity.
adb logcat -b events > "$ARTIFACTS_DIR/android-logcat-events.log" 2>&1 &
EVENTS_PID=$!

echo "Running Maestro E2E tests (tags: ${MAESTRO_TAGS:-pay}):"
bash "$SCRIPTS_DIR/maestro-suite.sh" Android
maestro_exit_code=$?

kill "$FULL_PID" "$FILTERED_PID" "$EVENTS_PID" 2>/dev/null || true
wait "$FULL_PID" "$FILTERED_PID" "$EVENTS_PID" 2>/dev/null || true
adb logcat -d -b crash > "$ARTIFACTS_DIR/android-logcat-crash.log" 2>&1 || true
exit "$maestro_exit_code"
