#!/bin/bash

flutter_rust_bridge_codegen generate --config-file flutter_rust_bridge.yaml

# rustup target add aarch64-apple-ios x86_64-apple-ios

cd rust/
cargo clean
cargo build --release
# cargo build --manifest-path rust/Cargo.toml --target aarch64-apple-ios --release
# cargo build --manifest-path rust/Cargo.toml --target x86_64-apple-ios --release

# cd ..
# cd ..

# mkdir -p target/universal/release

# lipo -create target/aarch64-apple-ios/release/libyttrium_dart.a target/x86_64-apple-ios/release/libyttrium_dart.a -output target/universal/release/libyttrium_dart_universal.a
# lipo -create target/aarch64-apple-ios/release/libyttrium_dart.dylib target/x86_64-apple-ios/release/libyttrium_dart.dylib -output target/universal/release/libyttrium_dart_universal.dylib

# lipo -info target/universal/release/libyttrium_dart_universal.a
# lipo -info target/universal/release/libyttrium_dart_universal.dylib

# cp target/universal/release/libyttrium_dart_universal.a crates/dart-ffi/assets/libyttrium_dart_universal.a
cp target/release/libyttrium_dart.dylib ../assets/libyttrium_dart.dylib