#!/usr/bin/env bash
set -e

cd "$(dirname $0)"
docker run -it --rm \
    --gpus all \
    --network host \
    --shm-size 2g \
    --ulimit memlock=-1 \
    --ulimit stack=67108864 \
    --volume ${PWD}/../../hf-models:/hf-models \
    triton-vllm-server \
    tritonserver --model-store /models
