#!/usr/bin/env bash
set -e

# Make sure we're in the right directory.
cd "$(dirname $0)"

# TODO: Should copy the TritonPythonModel definitions from somewhere.
# Should not be kept in git.

# TODO: Maybe we can use this to fill the placeholder values
# TODO: Need to run this via docker too then?
#
# python3 tools/fill_template.py --in_place \
#       all_models/inflight_batcher_llm/tensorrt_llm/config.pbtxt \
#       decoupled_mode:true,engine_dir:/all_models/inflight_batcher_llm/tensorrt_llm/1,\
# max_tokens_in_paged_kv_cache:,batch_scheduler_policy:guaranteed_completion,kv_cache_free_gpu_mem_fraction:0.2,\
# max_num_sequences:4
# python tools/fill_template.py --in_place \
#     all_models/inflight_batcher_llm/preprocessing/config.pbtxt \
#     tokenizer_type:llama,tokenizer_dir:meta-llama/Llama-2-7b-chat-hf
# python tools/fill_template.py --in_place \
#     all_models/inflight_batcher_llm/postprocessing/config.pbtxt \
#     tokenizer_type:llama,tokenizer_dir:meta-llama/Llama-2-7b-chat-hf

docker run --rm -it \
    --ipc host \
    --gpus all \
    --user $(id -u):$(id -g) \
    --ulimit memlock=-1 \
    --ulimit stack=67108864 \
    --volume /home/john/llm-inference-benchmark/hf-models:/hf-models \
    --volume /home/john/llm-inference-benchmark/frameworks/triton-tensorrt-llm/models:/models \
    --hostname a6cdff0bfdd9-release \
    --name tensorrt_llm-release-vscode \
    --tmpfs /tmp:exec \
    triton_trt_llm:latest \
    python tensorrt_llm/examples/llama/build.py \
        --model_dir /hf-models/llama-2-7b-chat-hf/ \
        --dtype float16 \
        --remove_input_padding \
        --use_gpt_attention_plugin float16 \
        --enable_context_fmha \
        --use_gemm_plugin float16 \
        --paged_kv_cache \
        --use_inflight_batching \
        --output_dir /models/tensorrt_llm/1
