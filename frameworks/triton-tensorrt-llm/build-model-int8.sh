#!/usr/bin/env bash
set -e

cd "$(dirname $0)"

# Note: Paths relative to container.
HF_MODEL_PATH="/hf-models/llama-2-7b-chat-hf"
TRITON_OUTPUT_PATH="/models/llama-2-7b-chat/int8/1-gpu"

# TODO: Need to support this in the build script too.
# INT8 weight only + INT8 KV cache
# TODO: Relevant? python3 hf_llama_convert.py -i /llama-models/llama-7b-hf -o /llama/smooth_llama_7B/int8_kv_cache/ --calibrate-kv-cache -t fp16
# + --int8_kv_cache flag

# See https://github.com/NVIDIA/TensorRT-LLM/tree/release/0.5.0/examples/llama#usage
./build-model.sh "${HF_MODEL_PATH}" "${TRITON_OUTPUT_PATH}" \
    --dtype float16 \
    --remove_input_padding \
    --use_gpt_attention_plugin float16 \
    --enable_context_fmha \
    --use_gemm_plugin float16 \
    --paged_kv_cache \
    --use_inflight_batching \
    --use_weight_only
