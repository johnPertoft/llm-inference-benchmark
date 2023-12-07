#!/usr/bin/env bash
set -e

if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <HOST> <LOCUST_USER_CLASS>"
    exit 1
fi
HOST="$1"
LOCUST_USER_CLASS="$2"
shift 2

locust --headless \
    --locustfile "$(dirname $0)/locust.py" \
    --users 20 \
    --spawn-rate 20 \
    --run-time 3m \
    --stop-timeout 10 \
    --host "${HOST}" \
    "${LOCUST_USER_CLASS}"
