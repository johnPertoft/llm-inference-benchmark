#!/usr/bin/env bash

# TODO:
# - Run with triton inference server?
# - See https://github.com/triton-inference-server/tutorials/blob/main/Quick_Deploy/vLLM/README.md#deploying-a-vllm-model-in-triton
# - Set it up to use multiple workers
# - Or just delete this in favor of using the plain vllm server which is basically the same thing.

cd "$(dirname $0)"
./build-image.sh
docker run -it --rm \
    --gpus all \
    --network host \
    --shm-size=2g \
    --volume ${PWD}/../../hf-models:/hf-models \
    fastapi-vllm-server:latest
