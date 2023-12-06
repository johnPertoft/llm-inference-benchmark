#!/usr/bin/env bash

curl -X POST -H "content-type: application/json" localhost:8000/generate -d '{
    "prompt": "[INST] How do I count to thirty in German? [/INST]",
    "stream": false,
    "ignore_eos": true,
    "max_tokens": 128
}' \
| jq .text
