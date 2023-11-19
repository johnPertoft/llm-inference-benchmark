#!/usr/bin/env bash
set -e

# TODO:
# - Take argument for this model to run.

cd "$(dirname $0)"
docker run --rm -it \
    --gpus all \
    --shm-size=2g \
    --network host \
    --name triton-tensorrt-llm-server \
    --ulimit memlock=-1 \
    --ulimit stack=67108864 \
    --volume ${PWD}/../../hf-models:/hf-models \
    --volume ${PWD}/models:/models \
    triton-tensorrt-llm-server \
    mpirun --allow-run-as-root -n 1 /opt/tritonserver/bin/tritonserver \
        --model-repository=/models \
        --disable-auto-complete-config \
        --backend-config=python,shm-region-prefix-name=prefix0_ \
        :

# NOTE: Run command is adapted from what tensorrtllm_backend/scripts/launch_triton_server.py
# produces.
