#!/usr/bin/env bash
set -e

cd "$(dirname $0)"
./bench.sh http://localhost:8000/v2/models/vllm_model TritonVllmUser
