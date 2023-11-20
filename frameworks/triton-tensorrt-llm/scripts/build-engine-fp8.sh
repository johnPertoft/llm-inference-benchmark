#!/usr/bin/env bash
set -e

if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <HF_MODEL_PATH> <TRT_ENGINE_PATH>"
    exit 1
fi
HF_MODEL_PATH="$1"
TRT_ENGINE_PATH="$2"
shift 2

# TODO
