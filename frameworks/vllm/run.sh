#!/usr/bin/env bash

if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <HF_MODEL_PATH> [additional arg to pass along]"
    exit 1
fi
HF_MODEL_PATH="$1"
shift 1

cd "$(dirname $0)"
docker run -it --rm \
    --gpus all \
    --ipc host \
    --ulimit memlock=-1 \
    --ulimit stack=67108864 \
    --network host \
    --volume ${PWD}/../../hf-models:/hf-models \
    vllm-server \
    --host 0.0.0.0 \
    --port 8000 \
    --model "${HF_MODEL_PATH}" \
    "$@"
