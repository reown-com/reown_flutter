#!/bin/bash
# Runs the Maestro WalletKit connect E2E suite (tag `connect`, WX SLO 2): the
# Flutter sample wallet (packages/reown_walletkit/example) against the Flutter
# AppKit sample dApp (packages/reown_appkit/example/base), both internal
# flavor and already installed on the running emulator/simulator. No secrets
# needed.
#
# Usage: ./scripts/run-maestro-connect-tests.sh [maestro-args...]
# Examples:
#   ./scripts/run-maestro-connect-tests.sh
#   ./scripts/run-maestro-connect-tests.sh .maestro/connect_reject.yaml
#   ./scripts/run-maestro-connect-tests.sh --device <udid> .maestro/sign_reject.yaml

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
MAESTRO_DIR="$ROOT_DIR/.maestro"
MAESTRO_BIN="${MAESTRO_BIN:-$(command -v maestro || echo "$HOME/.maestro/bin/maestro")}"

APP_ID="${APP_ID:-com.walletconnect.flutterwallet.internal}"
DAPP_APP_ID="${DAPP_APP_ID:-com.walletconnect.flutterdapp.internal}"
# Regex for the dApp's metadata name, shown in the wallet's session rows.
DEFAULT_DAPP_NAME="Reown's AppKit"
DAPP_NAME="${DAPP_NAME:-$DEFAULT_DAPP_NAME}"

if [ $# -eq 0 ]; then
  set -- --include-tags connect "$MAESTRO_DIR"
fi

echo "Running Maestro connect E2E tests..."
echo "  Wallet: $APP_ID"
echo "  dApp:   $DAPP_APP_ID ($DAPP_NAME)"
echo "  Args:   $*"

cd "$ROOT_DIR"
"$MAESTRO_BIN" test \
  --env "APP_ID=$APP_ID" \
  --env "DAPP_APP_ID=$DAPP_APP_ID" \
  --env "DAPP_NAME=$DAPP_NAME" \
  "$@"
