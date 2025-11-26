#!/bin/bash

rm -Rf pubspec.lock
rm -Rf .dart_tool

fvm flutter clean
rm pubspec.lock
fvm flutter pub get
dart run build_runner build --delete-conflicting-outputs
# dart pub outdated --no-dev-dependencies --up-to-date --no-dependency-overrides
dart format .
# dart run dependency_validator
