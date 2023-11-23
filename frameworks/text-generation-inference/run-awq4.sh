#!/usr/bin/env bash
set -e

cd "$(dirname $0)"
./run.sh "/hf-models/llama-2-7b-chat-awq" --quantize awq
