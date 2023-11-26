#!/usr/bin/env bash
set -e

locust_file="$(dirname $0)/locust-triton-vllm.py"
locust --headless \
    --locustfile "${locust_file}" \
    --host http://localhost:8000/v2/models/vllm_model \
    --users 10 \
    --spawn-rate 10 \
    --run-time 3m
