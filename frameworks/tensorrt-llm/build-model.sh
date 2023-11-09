#!/usr/bin/env bash

# TODO: Generate paths with Makefile?
# TODO: Need all these docker run settings?
# TODO: Mount in the input model directory
# TODO: Mount in the output model directory
# TODO: How to get the corresponding path on the host from within the dev container?
# TODO: Make sure the output trt engines are output to a mounted volume
# TODO: Run as non-root user, and use correct user id and group id

docker run --rm -it \
    --ipc=host \
    --gpus=all \
    --ulimit memlock=-1 \
    --ulimit stack=67108864 \
    --volume /home/john/llm-inference-benchmark/frameworks/tensorrt-llm/build/TensorRT-LLM:/code/tensorrt_llm \
    --volume /home/john/llm-inference-benchmark/models:/models \
    --workdir /code/tensorrt_llm \
    --hostname a6cdff0bfdd9-release \
    --name tensorrt_llm-release-vscode \
    --tmpfs /tmp:exec \
    tensorrt_llm/release:latest


#python examples/llama/build.py --model_dir /models/llama-2-7b-chat-hf/ --dtype float16 --remove_input_padding --use_gpt_attention_plugin float16 --enable_context_fmha --use_gemm_plugin float16 --output_dir ./tmp/llama/7B/trt_engines/fp16/1-gpu/
