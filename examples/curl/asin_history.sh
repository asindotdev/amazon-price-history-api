#!/usr/bin/env bash
# Price History of Any ASIN – cURL example
# Usage: ASIN_API_KEY=your-key bash asin_history.sh
set -euo pipefail

curl -sS --fail-with-body -G "https://www.asin.dev/api/v1/history" \
  -H "Authorization: Bearer ${ASIN_API_KEY}" \
  --data-urlencode asin=B09DFCB66S \
  --data-urlencode marketplace=com \
  --data-urlencode days=90
