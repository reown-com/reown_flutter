#!/bin/bash

# Check if both PROJECT_IDs are provided
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Error: Both WALLET_PROJECT_ID and DAPP_PROJECT_ID are required"
    echo "Usage: $0 <WALLET_PROJECT_ID> <DAPP_PROJECT_ID>"
    exit 1
fi

WALLET_PROJECT_ID=$1
DAPP_PROJECT_ID=$2

# Get the first available iPhone simulator
SIMULATOR_UDID=$(xcrun simctl list devices available | grep "iPhone" | grep -Ev "Pro|Plus|Max|SE" | sort -rV | head -n 1 | awk -F '[()]' '{print $2}')
echo "Selected simulator UDID: $SIMULATOR_UDID"

if xcrun simctl list devices | grep "$SIMULATOR_UDID" | grep -q "(Booted)"; then
    echo "$SIMULATOR_UDID is booted."
else
    echo "$SIMULATOR_UDID is not booted. Booting..."
    xcrun simctl boot "$SIMULATOR_UDID"
    echo "$SIMULATOR_UDID booted"
fi

# # Output the simulator UDID for the next step
# echo "SIMULATOR_UDID=$SIMULATOR_UDID" >> $GITHUB_ENV

cd packages/reown_walletkit/example

flutter build ios --flavor internal --build-name 3.0.0-internal --dart-define="PROJECT_ID=$WALLET_PROJECT_ID" --simulator --debug
xcrun simctl install "$SIMULATOR_UDID" build/ios/iphonesimulator/Runner.app

cd ..
cd ..
cd ..

cd packages/reown_appkit/example/base

flutter build ios --flavor internal --build-name 3.0.0-internal --dart-define="PROJECT_ID=$DAPP_PROJECT_ID" --simulator --debug
xcrun simctl install "$SIMULATOR_UDID" build/ios/iphonesimulator/Runner.app

cd ..
cd ..
cd ..
cd ..

# maestro test .maestro/native/launch_dapp.yaml
# maestro test .maestro/native/launch_wallet.yaml
maestro test .maestro/native/connect_reject_session_flow.yaml
# maestro test .maestro/native/connect_approve_session_sign_message_disconnect_LM_flow.yaml
maestro test .maestro/native/connect_approve_session_sign_message_disconnect_RELAY_flow.yaml

