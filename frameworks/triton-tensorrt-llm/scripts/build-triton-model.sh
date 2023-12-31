#!/usr/bin/env bash
set -e

if [ "$#" -lt 3 ]; then
    echo "Usage: $0 <HF_MODEL_PATH> <TRITON_OUTPUT_PATH> <TRT_ENGINE_SCRIPT_PATH>"
    exit 1
fi
HF_MODEL_PATH="$1"
TRITON_OUTPUT_PATH="$2"
TRT_ENGINE_SCRIPT_PATH="$3"
shift 3

TRT_MODEL_PATH="${TRITON_OUTPUT_PATH}/tensorrt_llm"
TRT_ENGINE_PATH="${TRT_MODEL_PATH}/1"
PREPROCESSING_MODEL_PATH="${TRITON_OUTPUT_PATH}/preprocessing"
POSTPROCESSING_MODEL_PATH="${TRITON_OUTPUT_PATH}/postprocessing"

# TODO: Copy the tokenizer maybe so we can rely on mounting only the TRITON_OUTPUT_PATH

# Start from the inflight batcher example.
mkdir -p ${TRITON_OUTPUT_PATH}
cp -r tensorrtllm_backend/all_models/inflight_batcher_llm/* ${TRITON_OUTPUT_PATH}

# Substitute values with our own ones for TensorRT engine.
python tensorrtllm_backend/tools/fill_template.py --in_place ${TRT_MODEL_PATH}/config.pbtxt \
    decoupled_mode:true,engine_dir:${TRT_ENGINE_PATH}

# Substitute values with our own ones for preprocessing.
python tensorrtllm_backend/tools/fill_template.py --in_place ${PREPROCESSING_MODEL_PATH}/config.pbtxt \
    tokenizer_type:llama,tokenizer_dir:${HF_MODEL_PATH}

# Substitute values with our own ones for postprocessing.
python tensorrtllm_backend/tools/fill_template.py --in_place ${POSTPROCESSING_MODEL_PATH}/config.pbtxt \
    tokenizer_type:llama,tokenizer_dir:${HF_MODEL_PATH}

# TODO: Some more config settings to try:
# python3 tools/fill_template.py --in_place \
#       all_models/inflight_batcher_llm/tensorrt_llm/config.pbtxt \
#       decoupled_mode:true,engine_dir:/all_models/inflight_batcher_llm/tensorrt_llm/1,\
# max_tokens_in_paged_kv_cache:,batch_scheduler_policy:guaranteed_completion,kv_cache_free_gpu_mem_fraction:0.2,\
# max_num_sequences:4

# Build TensorRT engine with the passed in script path.
bash ${TRT_ENGINE_SCRIPT_PATH} ${HF_MODEL_PATH} ${TRT_ENGINE_PATH}
