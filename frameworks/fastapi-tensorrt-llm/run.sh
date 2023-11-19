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
    python benchmarks/python/benchmark.py \
        -m llama_7b \
        --mode plugin \
        --batch_size "96" \
        --input_output_len "256,128"
    # python tensorrt_llm/examples/llama/run.py \
    #     --engine_dir /engines/fp16/1-gpu/ \
    #     --tokenizer_dir /models/llama-2-7b-chat-hf/ \
    #     --input_text "Write python code for merge sort and add some tests for it" \
    #     --max_output_len 2048
    # python tensorrt_llm/examples/llama/summarize.py \
    #     --test_trt_llm \
    #     --hf_model_location /models/llama-2-7b-chat-hf/ \
    #     --data_type fp16 \
    #     --engine_dir /engines/fp16/1-gpu/ \
    #     --test_hf
