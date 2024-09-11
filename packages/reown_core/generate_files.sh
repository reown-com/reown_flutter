#!/bin/bash

flutter clean
flutter pub get
dart run build_runner build --delete-conflicting-outputs
# dart pub outdated --no-dev-dependencies --up-to-date --no-dependency-overrides
dart format .

dart run dependency_validator