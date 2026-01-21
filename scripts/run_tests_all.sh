#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 <PROJECT_ID>"
  echo "Example: $0 your_project_id_here"
  exit 1
fi

PROJECT_ID="$1"

cd packages/reown_core/

sh run_tests.sh "$PROJECT_ID"

cd ..
cd ..

#######

cd packages/reown_sign/

sh run_tests.sh "$PROJECT_ID"

cd ..
cd ..

#######

cd packages/reown_walletkit/

sh run_tests.sh "$PROJECT_ID"

cd ..
cd ..

#######

cd packages/reown_appkit/

sh run_tests.sh "$PROJECT_ID"

cd ..
cd ..

#######

cd packages/walletconnect_pay/

sh run_tests.sh "$PROJECT_ID"

cd ..
cd ..

# lcov --directory . --capture --output-file coverage.lcov
# genhtml --rc genhtml_hi_limit=75 --rc genhtml_med_limit=50 -o coverage/html coverage/lcov.info --no-function-coverage