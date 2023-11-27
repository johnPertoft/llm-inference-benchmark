#!/usr/bin/env bash
set -e

locust_file="$(dirname $0)/locust-ray-vllm.py"
locust --headless \
    --locustfile "${locust_file}" \
    --host http://localhost:8000/v1 \
    --users 10 \
    --spawn-rate 10 \
    --run-time 3m
