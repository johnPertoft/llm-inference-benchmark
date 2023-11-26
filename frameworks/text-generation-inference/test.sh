#!/usr/bin/env bash
set -e

curl -X POST -H 'Content-Type: application/json' http://localhost:8000/generate  -d \
'{
    "inputs": "[INST] How do I count to thirty in German? [/INST]",
    "parameters": {
        "max_new_tokens": 128
    }
}' | jq .generated_text
