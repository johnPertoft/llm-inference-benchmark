#!/usr/bin/env bash
set -e

# This script creates a Triton Inference Server model with a TensorRT-LLM engine.
# The actual logic for this is inside build-trt-model.sh which is intended to run
# inside the container.

if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <HF_MODEL_PATH> <TRITON_OUTPUT_PATH> [additional arguments passed along...]"
    exit 1
fi
HF_MODEL_PATH="$1"
TRITON_OUTPUT_PATH="$2"
shift 2

cd "$(dirname $0)"
mkdir -p models
docker run -it --rm \
    --ipc host \
    --gpus all \
    --shm-size=2g \
    --user $(id -u):$(id -g) \
    --ulimit memlock=-1 \
    --ulimit stack=67108864 \
    --volume ${PWD}/../../hf-models:/hf-models \
    --volume ${PWD}/models:/models \
    --volume ${PWD}/build-triton-trt-model.sh:/opt/tritonserver/build-triton-trt-model.sh \
    triton-tensorrt-llm-server \
    ./build-triton-trt-model.sh \
    "${HF_MODEL_PATH}" \
    "${TRITON_OUTPUT_PATH}" \
    "$@"
