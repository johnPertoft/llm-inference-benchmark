#!/usr/bin/env bash
set -e

# NOTE: This is intended to be called inside the container.

if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <HF_MODEL_PATH> <TRITON_OUTPUT_PATH> [additional arguments passed along...]"
    exit 1
fi
HF_MODEL_PATH="$1"
TRITON_OUTPUT_PATH="$2"
shift 2

TRT_MODEL_PATH="${TRITON_OUTPUT_PATH}/tensorrt_llm"
TRT_ENGINE_PATH="${TRT_MODEL_PATH}/1"
PREPROCESSING_MODEL_PATH="${TRITON_OUTPUT_PATH}/preprocessing"
POSTPROCESSING_MODEL_PATH="${TRITON_OUTPUT_PATH}/postprocessing"

# TODO: Copy the tokenizer maybe so we can rely on only the TRITON_OUTPUT_PATH

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

# Build TensorRT engine with the passed along arguments.
python tensorrtllm_backend/tensorrt_llm/examples/llama/build.py \
    --model_dir ${HF_MODEL_PATH} \
    --output_dir ${TRT_ENGINE_PATH} \
    "$@"
