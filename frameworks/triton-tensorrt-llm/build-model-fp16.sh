#!/usr/bin/env bash
set -e

cd "$(dirname $0)"

# Note: Paths relative to container.
HF_MODEL_PATH="/hf-models/llama-2-7b-chat-hf"
TRITON_OUTPUT_PATH="/models/llama-2-7b-chat/fp16/1-gpu"

# See https://github.com/NVIDIA/TensorRT-LLM/tree/release/0.5.0/examples/llama#usage
./build-model.sh "${HF_MODEL_PATH}" "${TRITON_OUTPUT_PATH}" \
    --dtype float16 \
    --remove_input_padding \
    --use_gpt_attention_plugin float16 \
    --enable_context_fmha \
    --use_gemm_plugin float16 \
    --paged_kv_cache \
    --use_inflight_batching

# TODO: Some more config settings to try:
# python3 tools/fill_template.py --in_place \
#       all_models/inflight_batcher_llm/tensorrt_llm/config.pbtxt \
#       decoupled_mode:true,engine_dir:/all_models/inflight_batcher_llm/tensorrt_llm/1,\
# max_tokens_in_paged_kv_cache:,batch_scheduler_policy:guaranteed_completion,kv_cache_free_gpu_mem_fraction:0.2,\
# max_num_sequences:4
