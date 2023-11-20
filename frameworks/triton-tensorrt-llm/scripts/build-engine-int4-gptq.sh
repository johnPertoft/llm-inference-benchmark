#!/usr/bin/env bash
set -e

if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <HF_MODEL_PATH> <TRT_ENGINE_PATH>"
    exit 1
fi
HF_MODEL_PATH="$1"
TRT_ENGINE_PATH="$2"
shift 2

# TODO: Needs an additional dependency. Add to image?

# git clone https://github.com/qwopqwop200/GPTQ-for-LLaMa.git
# cd GPTQ-for-LLaMa
# pip install -r requirements.txt

# # Quantize weights into INT4 and save as safetensors
# # Quantized weight with parameter "--act-order" is not supported in TRT-LLM
# python llama.py ./tmp/llama/7B/ c4 --wbits 4 --true-sequential --groupsize 128 --save_safetensors ./llama-7b-4bit-gs128.safetensors

# # Build the LLaMA 7B model using 2-way tensor parallelism and apply INT4 GPTQ quantization.
# # Compressed checkpoint safetensors are generated seperately from GPTQ.
# python build.py --model_dir ./tmp/llama/7B/ \
#                 --quant_ckpt_path ./llama-7b-4bit-gs128.safetensors \
#                 --dtype float16 \
#                 --remove_input_padding \
#                 --use_gpt_attention_plugin float16 \
#                 --enable_context_fmha \
#                 --use_gemm_plugin float16 \
#                 --use_weight_only \
#                 --weight_only_precision int4_gptq \
#                 --per_group \
#                 --world_size 2 \
#                 --tp_size 2 \
#                 --output_dir ./tmp/llama/7B/trt_engines/int4_GPTQ/2-gpu/
