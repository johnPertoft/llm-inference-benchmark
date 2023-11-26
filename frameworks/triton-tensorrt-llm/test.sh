#!/usr/bin/env bash
set -e

curl -X POST http://localhost:8000/v2/models/ensemble/generate -d \
'{
    "text_input": "[INST] How do I count to thirty in German? [/INST]",
    "parameters": {
        "max_tokens": 128,
        "bad_words": [""],
        "stop_words": [""]
    }
}' | jq .text_output
