#!/usr/bin/env bash

set -e

echo "======================================"
echo " Docker API test pipeline"
echo "======================================"

# Start with a clean environment
docker compose down --remove-orphans >/dev/null 2>&1 || true

# Clear previous test results
mkdir -p logs
: > logs/api_test.log

echo "Building and starting containers..."
docker compose up --build -d

echo "Waiting for tests to finish..."

while true; do
    AUTH_STATUS=$(docker inspect -f '{{.State.Status}}' authentication-test 2>/dev/null || echo "missing")
    AUTHZ_STATUS=$(docker inspect -f '{{.State.Status}}' authorization-test 2>/dev/null || echo "missing")
    CONTENT_STATUS=$(docker inspect -f '{{.State.Status}}' content-test 2>/dev/null || echo "missing")

    if [ "$AUTH_STATUS" = "exited" ] &&
       [ "$AUTHZ_STATUS" = "exited" ] &&
       [ "$CONTENT_STATUS" = "exited" ]; then
        break
    fi

    sleep 1
done

AUTH_EXIT=$(docker inspect -f '{{.State.ExitCode}}' authentication-test)
AUTHZ_EXIT=$(docker inspect -f '{{.State.ExitCode}}' authorization-test)
CONTENT_EXIT=$(docker inspect -f '{{.State.ExitCode}}' content-test)

echo
echo "Authentication test exit code: $AUTH_EXIT"
echo "Authorization test exit code:  $AUTHZ_EXIT"
echo "Content test exit code:        $CONTENT_EXIT"

echo
echo "======================================"
echo " Test report"
echo "======================================"
cat logs/api_test.log
cp logs/api_test.log api_test.log

docker compose down

if [ "$AUTH_EXIT" -eq 0 ] &&
   [ "$AUTHZ_EXIT" -eq 0 ] &&
   [ "$CONTENT_EXIT" -eq 0 ]; then
    echo
    echo "ALL TESTS PASSED"
    exit 0
else
    echo
    echo "ONE OR MORE TESTS FAILED"
    exit 1
fi
