#!/bin/bash
# run this script from inside /packages/reown_walletkit/

TARGET="aarch64-apple-ios"
TYPE="dylib"

if [ $# -eq 0 ];
then
  echo "✅ $0: No arguments passed, building for target: $TARGET"
  # exit 1
elif [ $# -gt 1 ];
then
  echo "❌ $0: Too many arguments, only one accepted. Arguments passed: $@"
  exit 1
else
  if [ $1 != "-sim" ];
  then
    echo "❌ $0: Wrong argument $1 passed. Only valid argument is '-sim'"
    exit 1
  else
    TARGET="aarch64-apple-ios$1"
    # echo "✅ $0: Building for $TARGET"
  fi
fi

flutter_rust_bridge_codegen generate --config-file flutter_rust_bridge.yaml

sh generate_ios_lib.sh $TARGET $TYPE
sh generate_android_lib.sh