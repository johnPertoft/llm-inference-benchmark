#!/usr/bin/env bash
set -e

curl 127.0.0.1:8000/generate \
    -X POST \
    -d '{"inputs":"[INST] How do I count to thirty in German? [/INST]","parameters":{"max_new_tokens": 256}}' \
    -H 'Content-Type: application/json'
