#!/usr/bin/env bash
set -e

if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <HF_MODEL_PATH> <TRT_ENGINE_PATH>"
    exit 1
fi
HF_MODEL_PATH="$1"
TRT_ENGINE_PATH="$2"
shift 2

# python3 hf_llama_convert.py -i /llama-models/llama-7b-hf -o /llama/smooth_llama_7B/sq0.8/ -sq 0.8 --tensor-parallelism 1 --storage-type fp16
# # Build model for SmoothQuant in the _per_tensor_ mode.
# python3 build.py --ft_model_dir=/llama/smooth_llama_7B/sq0.8/1-gpu/ \
#                  --use_smooth_quant

# # Build model for SmoothQuant in the _per_token_ + _per_channel_ mode
# python3 build.py --ft_model_dir=/llama/smooth_llama_7B/sq0.8/1-gpu/ \
#                  --use_smooth_quant \
#                  --per_token \
#                  --per_channel
