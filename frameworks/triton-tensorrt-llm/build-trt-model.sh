#!/usr/bin/env bash
set -e

# NOTE: This should just be called inside the container.

# TODO:
# - Should be more general for any model.
# - Should take arguments for engine building and output directory

HF_MODEL_PATH="/hf-models/llama-2-7b-chat-hf"
ENGINE_OUTPUT_PATH="/models/tensorrt_llm/1"

# Start from the inflight batcher example.
cp -r tensorrtllm_backend/all_models/inflight_batcher_llm/* /models

# Substitute values with our own ones for TensorRT engine.
python tensorrtllm_backend/tools/fill_template.py --in_place /models/tensorrt_llm/config.pbtxt \
    decoupled_mode:true,engine_dir:${ENGINE_OUTPUT_PATH}

# Substitute values with our own ones for preprocessing.
python tensorrtllm_backend/tools/fill_template.py --in_place /models/preprocessing/config.pbtxt \
    tokenizer_type:llama,tokenizer_dir:${HF_MODEL_PATH}

# Substitute values with our own ones for postprocessing.
python tensorrtllm_backend/tools/fill_template.py --in_place /models/postprocessing/config.pbtxt \
    tokenizer_type:llama,tokenizer_dir:${HF_MODEL_PATH}

# TODO: Some more config settings to try:
# python3 tools/fill_template.py --in_place \
#       all_models/inflight_batcher_llm/tensorrt_llm/config.pbtxt \
#       decoupled_mode:true,engine_dir:/all_models/inflight_batcher_llm/tensorrt_llm/1,\
# max_tokens_in_paged_kv_cache:,batch_scheduler_policy:guaranteed_completion,kv_cache_free_gpu_mem_fraction:0.2,\
# max_num_sequences:4

# TODO: Sometimes this is used too but doesn't seem needed?
# Convert weights from HF Tranformers to FT format
#python3 hf_gpt_convert.py -p 8 -i gpt2 -o ./c-model/gpt2 --tensor-parallelism 4 --storage-type float16

# Build TensorRT engine.
python tensorrtllm_backend/tensorrt_llm/examples/llama/build.py \
    --model_dir ${HF_MODEL_PATH} \
    --dtype float16 \
    --remove_input_padding \
    --use_gpt_attention_plugin float16 \
    --enable_context_fmha \
    --use_gemm_plugin float16 \
    --paged_kv_cache \
    --use_inflight_batching \
    --output_dir ${ENGINE_OUTPUT_PATH}
