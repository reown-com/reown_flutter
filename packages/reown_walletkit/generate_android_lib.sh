cd rust/

rustup target add armv7-linux-androideabi aarch64-linux-android x86_64-linux-android i686-linux-android
# rustup target add armv7-linux-androideabi aarch64-linux-android

cargo ndk -t armeabi-v7a -t arm64-v8a -t x86_64 -t x86 build --release
# cargo ndk -t armeabi-v7a -t arm64-v8a build --release

cd ..

mkdir -p android/src/main/jniLibs/armeabi-v7a
mkdir -p android/src/main/jniLibs/arm64-v8a
mkdir -p android/src/main/jniLibs/x86
mkdir -p android/src/main/jniLibs/x86_64

cp rust/target/armv7-linux-androideabi/release/libyttrium_dart.so android/src/main/jniLibs/armeabi-v7a/libyttrium_dart.so
cp rust/target/aarch64-linux-android/release/libyttrium_dart.so android/src/main/jniLibs/arm64-v8a/libyttrium_dart.so
cp rust/target/i686-linux-android/release/libyttrium_dart.so android/src/main/jniLibs/x86/libyttrium_dart.so
cp rust/target/x86_64-linux-android/release/libyttrium_dart.so android/src/main/jniLibs/x86_64/libyttrium_dart.so
