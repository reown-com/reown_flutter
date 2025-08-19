#!/bin/bash

echo "******* CLEAN ROOT *******"

flutter clean

echo "******* CLEAN CORE *******"

cd packages/reown_core/

flutter clean
rm -Rf .dart_tool

cd ..
cd ..

echo "******* CLEAN SIGN *******"

cd packages/reown_sign/

flutter clean
rm -Rf .dart_tool

cd ..
cd ..

echo "******* CLEAN YTTRIUM *******"

cd packages/reown_yttrium/

flutter clean
rm -Rf .dart_tool

cd ..
cd ..

echo "******* CLEAN WALLETKIT *******"

cd packages/reown_walletkit/

flutter clean
rm -Rf .dart_tool
rm -Rf example/.dart_tool
rm -Rf example/build
cd example/ios
rm Podfile.lock
pod deintegrate
pod cache clean --all
cd ..

cd ..
cd ..

echo "******* CLEAN APPKIT *******"

cd packages/reown_appkit/

flutter clean

rm -Rf .dart_tool
rm -Rf /example/base/.dart_tool
rm -Rf example/base/build
rm -Rf example/modal/.dart_tool
rm -Rf example/modal/build