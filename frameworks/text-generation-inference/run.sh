#!/usr/bin/env bash
set -e

cd "$(dirname $0)"
docker run -it --rm \
    --gpus all \
    --shm-size 2g \
    --network host \
    --volume ${PWD}/../../hf-models:/hf-models \
    --volume ${PWD}/data \
    ghcr.io/huggingface/text-generation-inference:1.1.1 \
    --port 8000 \
    --model-id "/hf-models/llama-2-7b-chat-hf"
