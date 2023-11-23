#!/usr/bin/env bash
set -e

# This script creates a Triton Inference Server model with a TensorRT-LLM engine.

if [ "$#" -lt 3 ]; then
    echo "Usage: $0 <HF_MODEL_PATH> <TRITON_OUTPUT_PATH> <TRT_ENGINE_SCRIPT_PATH>"
    exit 1
fi
HF_MODEL_PATH="$1"
TRITON_OUTPUT_PATH="$2"
TRT_ENGINE_SCRIPT_PATH="$3"
shift 3

# TODO: Maybe mount a hf cache directory.

cd "$(dirname $0)"
mkdir -p models
docker run -it --rm \
    --ipc host \
    --gpus all \
    --shm-size=20g \
    --user $(id -u):$(id -g) \
    --ulimit memlock=-1 \
    --ulimit stack=67108864 \
    --volume ${PWD}/../../hf-models:/hf-models \
    --volume ${PWD}/models:/models \
    --volume ${PWD}/scripts:/scripts \
    triton-tensorrt-llm-server \
    /scripts/build-triton-model.sh \
    ${HF_MODEL_PATH} \
    ${TRITON_OUTPUT_PATH} \
    ${TRT_ENGINE_SCRIPT_PATH}
