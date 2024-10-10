#!/bin/bash

flutter clean
flutter pub get
dart run build_runner build --delete-conflicting-outputs
# dart pub outdated --no-dev-dependencies --up-to-date --no-dependency-overrides
dart format .
dart run dependency_validator

cd example/base

echo "******* GENERATING APPKIT BASE EXAMPLE *******"

flutter clean
flutter pub get
dart run build_runner build --delete-conflicting-outputs
# dart pub outdated --no-dev-dependencies --up-to-date --no-dependency-overrides
dart format .
dart run dependency_validator

cd ios

# rm Podfile.lock
# pod deintegrate
# pod cache clean -all
pod install

cd ..

cd ..
cd ..

cd example/modal

echo "******* GENERATING APPKIT MODAL EXAMPLE *******"

flutter clean
flutter pub get
dart run build_runner build --delete-conflicting-outputs
# dart pub outdated --no-dev-dependencies --up-to-date --no-dependency-overrides
dart format .
dart run dependency_validator

cd ios

# rm Podfile.lock
# pod deintegrate
# pod cache clean -all
pod install

cd ..

cd ..
cd ..