#!/usr/bin/env bash

cd "$(dirname $0)"

docker run -it --rm \
    --gpus all \
    --ipc host \
    --ulimit memlock=-1 \
    --ulimit stack=67108864 \
    --network host \
    --volume ${PWD}/../../hf-models:/hf-models \
    vllm-server \
    --host 0.0.0.0 \
    --port 8000 \
    --model /hf-models/llama-2-7b-chat-hf \
    --dtype float16
