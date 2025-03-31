#!/bin/bash

echo "******* CLEAN ROOT *******"

flutter clean

echo "******* CLEAN CORE *******"

cd packages/reown_core/

flutter clean

cd ..
cd ..

echo "******* CLEAN SIGN *******"

cd packages/reown_sign/

flutter clean

cd ..
cd ..

echo "******* CLEAN YTTRIUM *******"

cd packages/reown_yttrium/

flutter clean

cd ..
cd ..

echo "******* CLEAN WALLETKIT *******"

cd packages/reown_walletkit/

flutter clean

cd ..
cd ..

echo "******* CLEAN APPKIT *******"

cd packages/reown_appkit/

flutter clean