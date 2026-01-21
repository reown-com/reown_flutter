#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 <PROJECT_ID>"
  echo "Example: $0 your_project_id_here"
  exit 1
fi

PROJECT_ID="$1"

flutter test --coverage --dart-define=RELAY_ENDPOINT=wss://relay.walletconnect.org --dart-define=PROJECT_ID="$PROJECT_ID"

## Filtered
lcov --remove coverage/lcov.info '*.g.dart' '*.freezed.dart' -o coverage/lcov.info
genhtml --rc genhtml_hi_limit=75 --rc genhtml_med_limit=50 -o coverage/html coverage/lcov.info --no-function-coverage

## Open
# open coverage/html/index.html