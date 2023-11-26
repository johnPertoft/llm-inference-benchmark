#!/usr/bin/env bash
set -e

curl -X POST http://localhost:8000/v2/models/vllm_model/generate -d \
'{
    "text_input": "How do I count to thirty in German?",
    "parameters": {
        "max_tokens": 100,
        "stream": false,
        "temperature": 0
    }
}' | jq .text_output
