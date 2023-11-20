#!/usr/bin/env bash
set -e

# This script creates a Triton Inference Server model with a TensorRT-LLM engine.
# The actual logic for this is inside build-trt-model.sh which is intended to run
# inside the container.

# TODO:
# - Take arguments to pass in?
# - Remove docker run arguments that are not needed.
# - Rename build-trt-model.sh to build-triton-trt-model.sh?

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
    ./build-trt-model.sh \
    "/hf-models/llama-2-7b-chat-hf" \
    "/models/llama-2-7b-chat/1-gpu/fp16" \
    --dtype float16 \
    --remove_input_padding \
    --use_gpt_attention_plugin float16 \
    --enable_context_fmha \
    --use_gemm_plugin float16 \
    --paged_kv_cache \
    --use_inflight_batching
