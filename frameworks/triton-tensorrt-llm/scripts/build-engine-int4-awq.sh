#!/usr/bin/env bash
set -e

if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <HF_MODEL_PATH> <TRT_ENGINE_PATH>"
    exit 1
fi
HF_MODEL_PATH="$1"
TRT_ENGINE_PATH="$2"
shift 2

# TODO: Need to install ammo toolkit first.
# See https://github.com/NVIDIA/TensorRT-LLM/blob/release/0.5.0/examples/quantization/README.md#installation

quantized_path=$(mktemp -d)
python tensorrtllm_backend/tensorrt_llm/examples/llama/quantize.py \
    --model_dir ${HF_MODEL_PATH} \
    --dtype float16 \
    --qformat int4_awq \
    --export_path ${quantized_path} \
    --calib_size 32

python tensorrtllm_backend/tensorrt_llm/examples/llama/build.py \
    --model_dir ${HF_MODEL_PATH} \
    --quant_ckpt_path ${quantized_path} \
    --output_dir ${TRT_ENGINE_PATH} \
    --dtype float16 \
    --remove_input_padding \
    --use_gpt_attention_plugin float16 \
    --enable_context_fmha \
    --use_gemm_plugin float16 \
    --use_weight_only \
    --weight_only_precision int4_awq \
    --per_group
