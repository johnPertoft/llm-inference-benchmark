#!/usr/bin/env bash
set -e

# Make sure we're in the right directory.
cd "$(dirname $0)"

mkdir -p engines

docker run --rm -it \
    --ipc host \
    --gpus all \
    --user $(id -u):$(id -g) \
    --ulimit memlock=-1 \
    --ulimit stack=67108864 \
    --volume /home/john/llm-inference-benchmark/models:/models \
    --volume /home/john/llm-inference-benchmark/frameworks/triton-tensorrt-llm/engines:/engines \
    --hostname a6cdff0bfdd9-release \
    --name tensorrt_llm-release-vscode \
    --tmpfs /tmp:exec \
    triton_trt_llm:latest \
    python tensorrt_llm/examples/llama/build.py \
        --model_dir /models/llama-2-7b-chat-hf/ \
        --dtype float16 \
        --remove_input_padding \
        --use_gpt_attention_plugin float16 \
        --enable_context_fmha \
        --use_gemm_plugin float16 \
        --output_dir /engines/fp16/1-gpu/
