#!/usr/bin/env bash

# TODO: Take argument for which model engine to serve

docker run -it --rm \
    --gpus all \
    --ipc host \
    --user $(id -u):$(id -g) \
    --volume /home/john/llm-inference-benchmark/models:/models \
    --volume /home/john/llm-inference-benchmark/frameworks/tensorrt-llm/engines:/engines \
    --entrypoint bash \
    tensorrt-llm-server

#python examples/llama/summarize.py --test_trt_llm --hf_model_location /models/llama-2-7b-chat-hf/ --data_type fp16 --engine_dir ./tmp/llama/7B/trt_engines/fp16/1-gpu/ --test_hf
