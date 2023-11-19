#!/usr/bin/env bash

# TODO: Run with triton inference server?
# TODO: See https://github.com/triton-inference-server/tutorials/blob/main/Quick_Deploy/vLLM/README.md#deploying-a-vllm-model-in-triton

docker run -it --rm \
    --gpus all \
    --network host \
    --shm-size=2g \
    --volume /home/john/llm-inference-benchmark/hf-models:/hf-models \
    vllm-server:latest
