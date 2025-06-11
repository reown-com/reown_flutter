#!/bin/bash

# Check if both PROJECT_IDs are provided
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Error: Both WALLET_PROJECT_ID and DAPP_PROJECT_ID are required"
    echo "Usage: $0 <WALLET_PROJECT_ID> <DAPP_PROJECT_ID>"
    exit 1
fi

WALLET_PROJECT_ID=$1
DAPP_PROJECT_ID=$2

cd packages/reown_walletkit/example

flutter build apk --flavor internal --build-name 3.0.0-internal --dart-define="PROJECT_ID=$WALLET_PROJECT_ID" --release --target-platform android-x64 --split-per-abi -PyttriumCiVersion=0.0.19-ci

mv build/app/outputs/flutter-apk/app-x86_64-internal-release.apk /Users/alfreedom/Development/Reown/reown_flutter/wallet-release.apk

cd ..
cd ..
cd ..

cd packages/reown_appkit/example/base

flutter build apk --flavor internal --build-name 3.0.0-internal --dart-define="PROJECT_ID=$DAPP_PROJECT_ID" --release --target-platform android-x64 --split-per-abi

mv build/app/outputs/flutter-apk/app-x86_64-internal-release.apk /Users/alfreedom/Development/Reown/reown_flutter/dapp-release.apk

cd ..
cd ..
cd ..
cd ..

# Verify emulator is running
adb devices

echo "Installing APKs:"
find . -name "*.apk" -exec adb install -r {} \;

echo "Installed apps:"
adb shell pm list packages

maestro test .maestro/native/launch_dapp.yaml
maestro test .maestro/native/launch_wallet.yaml
maestro test .maestro/native/connect_reject_session_flow.yaml
maestro test .maestro/native/connect_approve_session_sign_message_disconnect_LM_flow.yaml
maestro test .maestro/native/connect_approve_session_sign_message_disconnect_RELAY_flow.yaml

