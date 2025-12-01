#!/bin/bash

echo "******* GENERATING ROOT *******"

flutter clean
flutter pub get

echo "******* GENERATING YTTRIUM *******"

cd packages/reown_yttrium/
sh generate_files.sh

cd ..
cd ..

echo "******* GENERATING CORE *******"

cd packages/reown_core/
sh generate_files.sh

cd ..
cd ..

echo "******* GENERATING SIGN *******"

cd packages/reown_sign/
sh generate_files.sh

cd ..
cd ..

echo "******* GENERATING WALLETKIT *******"

cd packages/reown_walletkit/
sh generate_files.sh

cd ..
cd ..

echo "******* GENERATING APPKIT *******"

cd packages/reown_appkit/
sh generate_files.sh

cd ..
cd ..

echo "******* GENERATING POS CLIENT *******"

cd packages/pos_client/
sh generate_files.sh

cd ..
cd ..

echo "******* GENERATING CLI *******"

cd packages/reown_cli/
sh generate_files.sh

cd ..
cd ..

echo "******* GENERATING YTTRIUM UTILS *******"

cd packages/reown_yttrium_utils/
sh generate_files.sh

cd ..
cd ..