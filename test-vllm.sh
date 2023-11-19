#!/usr/bin/env bash
set -e

curl -i -H "content-type: application/json" localhost:3000/generate -d '{"input": "Write python code for topological sort. Write some tests too."}'
