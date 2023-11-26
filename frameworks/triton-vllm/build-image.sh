#!/usr/bin/env bash
set -e

cd "$(dirname $0)"
docker build \
    --build-arg="USER_UID=$(id -u)" \
    --build-arg="USER_GID=$(id -g)" \
    -t triton-vllm-server \
    .
