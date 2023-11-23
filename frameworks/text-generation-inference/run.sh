#!/usr/bin/env bash
set -e

if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <HF_MODEL_PATH> [additional arg to pass along]"
    exit 1
fi
HF_MODEL_PATH="$1"
shift 1

cd "$(dirname $0)"
docker run -it --rm \
    --gpus all \
    --shm-size 2g \
    --network host \
    --volume ${PWD}/../../hf-models:/hf-models \
    --volume ${PWD}/data \
    ghcr.io/huggingface/text-generation-inference:1.1.1 \
    --port 8000 \
    --model-id "${HF_MODEL_PATH}" \
    "$@"
