#!/usr/bin/env bash
set -e

curl -X POST localhost:8000/v2/models/ensemble/generate -d \
'{
"text_input": "How do I count to nine in French?",
"parameters": {
"max_tokens": 100,
"bad_words":[""],
"stop_words":[""]
}
}'
