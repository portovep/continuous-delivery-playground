#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

target_url=${1:-http://localhost}

echo "Running smoke test against: [${target_url}]"
echo "Smoke test started"
curl ${target_url}
echo "Smoke test completed successfully!"