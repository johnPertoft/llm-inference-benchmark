#!/usr/bin/env bash
set -e

if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <HF_MODEL_PATH> <TRT_ENGINE_PATH>"
    exit 1
fi
HF_MODEL_PATH="$1"
TRT_ENGINE_PATH="$2"
shift 2

# TODO: First need to run this
# python3 hf_llama_convert.py -i /llama-models/llama-7b-hf -o /llama/smooth_llama_7B/int8_kv_cache/ --calibrate-kv-cache -t fp16

# TODO: Need to install datasets in the container
# TODO: Probably should use a relevant dataset too for this? It's using cnn-dailymail atm

# TODO: Then this
# TODO: Note that we're now passing --ft_model_dir instead instead of --model_dir
# python build.py --ft_model_dir=/llama/smooth_llama_7B/int8_kv_cache/1-gpu/ \
#                 --dtype float16 \
#                 --use_gpt_attention_plugin float16 \
#                 --use_gemm_plugin float16 \
#                 --output_dir ./tmp/llama/7B/trt_engines/int8_kv_cache_weight_only/1-gpu \
#                 --int8_kv_cache \
#                 --use_weight_only

# python tensorrtllm_backend/tensorrt_llm/examples/llama/hf_llama_convert.py -i /hf-models/llama-2-7b-chat-hf/ -o /tmp/smooth-llama/int8-kv-cache --calibrate-kv-cache -t fp16

#python tensorrtllm_backend/tensorrt_llm/examples/llama/quantize.py --model_dir ./tmp/llama/70B --dtype float16 --qformat fp8 --export_path /tmp/llama-quantized-fp8 --calib_size 512