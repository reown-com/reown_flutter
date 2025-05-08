#!/bin/bash
# .github/scripts/wait_for_package.sh

# Script to wait for a package version to be available on pub.dev
# Arguments:
#   $1: Package name (e.g., reown_core)
#   $2: Package version (e.g., 1.0.0)

set -e # Exit immediately if a command exits with a non-zero status.

PACKAGE_NAME=$1
PACKAGE_VERSION=$2
MAX_ATTEMPTS=${3:-30} # Maximum number of attempts (default 30, approx 5 minutes if sleep is 10s)
SLEEP_DURATION=${4:-10} # Sleep duration in seconds between attempts (default 10s)

if [ -z "$PACKAGE_NAME" ] || [ -z "$PACKAGE_VERSION" ]; then
  echo "Usage: $0 <package_name> <package_version> [max_attempts] [sleep_duration]"
  exit 1
fi

echo "Waiting for package '$PACKAGE_NAME' version '$PACKAGE_VERSION' to become available on pub.dev..."
echo "Max attempts: $MAX_ATTEMPTS, Sleep duration: $SLEEP_DURATION seconds."

for (( i=1; i<=$MAX_ATTEMPTS; i++ )); do
  # Query the pub.dev API for the specific package version.
  # The API endpoint is https://pub.dev/api/packages/<package_name>/versions/<version>
  # A 200 OK status means the version is available.
  HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" "https://pub.dev/api/packages/$PACKAGE_NAME/versions/$PACKAGE_VERSION")

  if [ "$HTTP_STATUS" -eq 200 ]; then
    echo "Successfully found '$PACKAGE_NAME' version '$PACKAGE_VERSION' on pub.dev (HTTP status: $HTTP_STATUS)."
    exit 0 # Success
  else
    echo "Attempt $i/$MAX_ATTEMPTS: '$PACKAGE_NAME' version '$PACKAGE_VERSION' not yet available (HTTP status: $HTTP_STATUS). Retrying in $SLEEP_DURATION seconds..."
    sleep "$SLEEP_DURATION"
  fi
done

echo "Error: Timed out waiting for '$PACKAGE_NAME' version '$PACKAGE_VERSION' to become available on pub.dev after $MAX_ATTEMPTS attempts."
exit 1 # Failure 
