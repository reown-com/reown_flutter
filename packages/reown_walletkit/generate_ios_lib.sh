
TARGET=$1
TYPE=$2

cd rust/

echo "✅ $0: building for x86_64-apple-ios $TARGET. Type: $TYPE"

rustup target add x86_64-apple-ios $TARGET

cargo build --manifest-path Cargo.toml --target x86_64-apple-ios --release
cargo build --manifest-path Cargo.toml --target $TARGET --release

mkdir -p target/universal/ios/release

lipo -create target/$TARGET/release/libyttrium_dart.$TYPE target/x86_64-apple-ios/release/libyttrium_dart.$TYPE -output target/universal/ios/release/libyttrium_dart_universal.$TYPE

lipo -info target/universal/ios/release/libyttrium_dart_universal.$TYPE

cd ..

cp rust/target/universal/ios/release/libyttrium_dart_universal.$TYPE ios/libyttrium_dart_universal.$TYPE

otool -L ios/libyttrium_dart_universal.$TYPE

install_name_tool -id @rpath/libyttrium_dart_universal.$TYPE ios/libyttrium_dart_universal.$TYPE

codesign --force --sign - ios/libyttrium_dart_universal.$TYPE

otool -L ios/libyttrium_dart_universal.$TYPE

cd example
flutter clean
flutter pub get

cd ios
pod deintegrate && rm Podfile.lock && pod cache clean -all && pod install