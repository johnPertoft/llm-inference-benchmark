#!/usr/bin/env bash

# TODO: Take argument for which model engine to serve
# TODO: Switch the entrypoint to run the server.
# TODO: Maybe add a non root user to the docker image.

docker run -it --rm \
    --gpus all \
    --ipc host \
    --volume /home/john/llm-inference-benchmark/models:/models \
    --volume /home/john/llm-inference-benchmark/frameworks/tensorrt-llm/engines:/engines \
    tensorrt-llm-server \
    python tensorrt_llm/examples/llama/summarize.py \
        --test_trt_llm \
        --hf_model_location /models/llama-2-7b-chat-hf/ \
        --data_type fp16 \
        --engine_dir /engines/fp16/1-gpu/ \
        --test_hf
