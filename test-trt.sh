#!/usr/bin/env bash
set -e

curl -X POST http://localhost:8000/v2/models/ensemble/generate -d \
'{
"text_input": "How do I count to nine in German?",
"parameters": {
"max_tokens": 100,
"bad_words":[""],
"stop_words":[""]
}
}' | jq .text_output
