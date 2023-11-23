#!/usr/bin/env bash
set -e

# Note that this path should be given relative to the container.
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <TRITON_MODEL_PATH>"
    exit 1
fi
TRITON_TRT_MODEL="$1"

# TODO: Build the engine if it doesn't exist.

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
        --model-repository=${TRITON_TRT_MODEL} \
        --disable-auto-complete-config \
        --backend-config=python,shm-region-prefix-name=prefix0_ \
        :

# NOTE: The above run command is adapted from what tensorrtllm_backend/scripts/launch_triton_server.py
# produces. We're not using that directly though because it launches in a subshell.
