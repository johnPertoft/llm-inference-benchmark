#!/usr/bin/env bash
set -e

# Make sure we're in the right directory.
cd "$(dirname $0)"

rm -rf build/tensorrt_llm_backend
git clone https://github.com/triton-inference-server/tensorrtllm_backend.git build/tensorrt_llm_backend
pushd build/tensorrt_llm_backend
git lfs install
git submodule update --init --recursive
DOCKER_BUILDKIT=1 docker build -t triton_trt_llm -f dockerfile/Dockerfile.trt_llm_backend .

# TODO: Build our image based on this
