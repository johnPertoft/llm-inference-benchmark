#!/usr/bin/env bash
set -e

# This script creates a Triton Inference Server model.
# The actual logic for this is inside build-trt-model.sh which
# runs inside the container.

# TODO:
# - Take arguments to pass in?
# - Remove docker run arguments that are not needed.
# - Share the docker run arguments between the stuff we need to do here.
# - Maybe break out the commands to actually make the model to separate script

cd "$(dirname $0)"
mkdir -p models
docker run -it --rm \
    --ipc host \
    --gpus all \
    --user $(id -u):$(id -g) \
    --ulimit memlock=-1 \
    --ulimit stack=67108864 \
    --volume ${PWD}/../../hf-models:/hf-models \
    --volume ${PWD}/models:/models \
    --volume ${PWD}/build-trt-model.sh:/opt/tritonserver/build-trt-model.sh \
    triton-tensorrt-llm-server \
    ./build-trt-model.sh
