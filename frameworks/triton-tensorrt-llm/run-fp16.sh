#!/usr/bin/env bash
set -e

cd "$(dirname $0)"
./run.sh /models/llama-2-7b-chat/1-gpu/fp16
