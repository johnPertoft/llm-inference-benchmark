#!/usr/bin/env bash
set -e

cd "$(dirname $0)"
docker run --rm -it \
    --gpus all \
    --shm-size=2g \
    --network host \
    --ulimit memlock=-1 \
    --ulimit stack=67108864 \
    --volume ${PWD}/../../hf-models:/hf-models \
    --volume ${PWD}/models:/models \
    triton-tensorrt-llm-server \
    bash
    # python3 scripts/launch_triton_server.py \
    #     --world_size=1 \
    #     --model_repo=/models

# TODO: How to make it not run detached?
#tensorrtllm_backend/scripts/launch_triton_server.py
