#!/usr/bin/env bash
set -e

# Make sure we're in the right directory.
cd "$(dirname $0)"

# TODO: Can we just use the prebuilt triton inference server image?
# TODO: If so, delete the build-image script. The example seems to do so.
# docker run -it --rm --gpus all --network host --shm-size=1g \
# -v $(pwd)/all_models:/all_models \
# -v $(pwd)/scripts:/opt/scripts \
# nvcr.io/nvidia/tritonserver:23.10-trtllm-python-py3

# our image: triton_trt_llm

docker run --rm -it \
    --gpus all \
    --shm-size=2g \
    --network host \
    --ulimit memlock=-1 \
    --ulimit stack=67108864 \
    --volume /home/john/llm-inference-benchmark/hf-models:/hf-models \
    --volume /home/john/llm-inference-benchmark/frameworks/triton-tensorrt-llm/models:/models \
    foo \
    bash
    # python3 scripts/launch_triton_server.py \
    #     --world_size=1 \
    #     --model_repo=/models

# mpirun --allow-run-as-root  -n 1 /opt/tritonserver/bin/tritonserver --model-repository=/models --disable-auto-complete-config --backend-config=python,shm-region-prefix-name=prefix0_ : &
