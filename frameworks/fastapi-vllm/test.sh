#!/usr/bin/env bash
set -e

curl -H "content-type: application/json" -X POST localhost:8000/generate -d \
'{"input": "[INST] How do I count to thirty in German? [/INST]"}' \
| jq .output
