#!/usr/bin/env bash
set -e

if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <HF_MODEL_PATH> <TRT_ENGINE_PATH>"
    exit 1
fi
HF_MODEL_PATH="$1"
TRT_ENGINE_PATH="$2"
shift 2

# TODO: This uses cnn/dailymail for calibrating. Should probably be relevant to model (use).
# TODO: Doesn't seem configurable at the moment. Maybe fix.
ft_dir=$(mktemp -d)
python tensorrtllm_backend/tensorrt_llm/examples/llama/hf_llama_convert.py \
    --in-file ${HF_MODEL_PATH} \
    --out-dir ${ft_dir} \
    --calibrate-kv-cache \
    --storage-type fp16

python tensorrtllm_backend/tensorrt_llm/examples/llama/build.py \
    --ft_model_dir=${ft_dir} \
    --output_dir ${TRT_ENGINE_PATH} \
    --dtype float16 \
    --remove_input_padding \
    --use_gpt_attention_plugin float16 \
    --enable_context_fmha \
    --use_gemm_plugin float16 \
    --paged_kv_cache \
    --use_inflight_batching \
    --use_weight_only \
    --int8_kv_cache
