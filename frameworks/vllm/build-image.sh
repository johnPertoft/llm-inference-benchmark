#!/usr/bin/env bash

# Make sure we're in the right directory.
cd "$(dirname $0)"

docker build -t vllm-server .
