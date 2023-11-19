#!/usr/bin/env bash

# TODO: Make sure we're running it from this directory.
# TODO: Take argument for gpu architecture to build for.
# TODO: Tag with cuda arch maybe?
# TODO: Use tensorrt-llm release tag

# Make sure we're in the right directory.
cd "$(dirname $0)"

rm -rf build/TensorRT-LLM

# Docker image build instructions from
# https://github.com/NVIDIA/TensorRT-LLM/blob/release/0.5.0/docs/source/installation.md
git clone https://github.com/NVIDIA/TensorRT-LLM.git build/TensorRT-LLM
pushd build/TensorRT-LLM
git submodule update --init --recursive
git lfs install
git lfs pull
make -C docker release_build CUDA_ARCHS="80-real"

popd
docker build -t tensorrt-llm-server .
