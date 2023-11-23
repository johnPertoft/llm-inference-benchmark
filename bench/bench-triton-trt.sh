#!/usr/bin/env bash
set -e

locust_file="$(dirname $0)/locust-triton-trt.py"
locust --headless \
    --locustfile "${locust_file}" \
    --host http://localhost:8000/v2/models/ensemble \
    --users 10 \
    --spawn-rate 10 \
    --run-time 3m
