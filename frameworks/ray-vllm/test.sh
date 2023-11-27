#!/usr/bin/env bash
set -e

curl http://localhost:8000/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "/hf-models/llama-2-7b-chat-hf",
    "messages": [{"role": "user", "content": "How do I count to thirty in German?"}],
    "temperature": 0.0,
    "max_tokens": 128
  }'
