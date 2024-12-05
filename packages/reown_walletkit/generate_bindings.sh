#!/bin/bash

# run this script from inside /crates/yttrium_dart/
TARGET="aarch64-apple-ios"
TYPE="dylib"

if [ $# -eq 0 ];
then
  echo "✅ $0: No arguments passed, building for $TARGET"
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
    echo "✅ $0: Building for $TARGET"
  fi
fi

# rm ios/libyttrium_dart_universal.dylib

flutter_rust_bridge_codegen generate --config-file flutter_rust_bridge.yaml

cd rust/

rustup target add x86_64-apple-ios $TARGET

cargo build --manifest-path Cargo.toml --target x86_64-apple-ios --release
cargo build --manifest-path Cargo.toml --target $TARGET --release

mkdir -p target/universal/release

# lipo -create target/$TARGET/release/libyttrium_dart.a target/x86_64-apple-ios/release/libyttrium_dart.a -output target/universal/release/libyttrium_dart_universal.a
lipo -create target/$TARGET/release/libyttrium_dart.$TYPE target/x86_64-apple-ios/release/libyttrium_dart.$TYPE -output target/universal/release/libyttrium_dart_universal.$TYPE

# lipo -info target/universal/release/libyttrium_dart_universal.a
lipo -info target/universal/release/libyttrium_dart_universal.$TYPE

cd ..

# cp rust/target/universal/release/libyttrium_dart_universal.a ios/libyttrium_dart_universal.a
cp rust/target/universal/release/libyttrium_dart_universal.$TYPE ios/libyttrium_dart_universal.$TYPE

# otool -L ios/libyttrium_dart_universal.a
otool -L ios/libyttrium_dart_universal.$TYPE

# install_name_tool -id @rpath/libyttrium_dart_universal.a ios/libyttrium_dart_universal.a
install_name_tool -id @rpath/libyttrium_dart_universal.$TYPE ios/libyttrium_dart_universal.$TYPE

# codesign --force --sign - ios/libyttrium_dart_universal.a
codesign --force --sign - ios/libyttrium_dart_universal.$TYPE

# otool -L ios/libyttrium_dart_universal.a
otool -L ios/libyttrium_dart_universal.$TYPE

cd example
flutter clean
flutter pub get -v

cd ios
pod deintegrate && rm Podfile.lock && pod cache clean -all && pod install