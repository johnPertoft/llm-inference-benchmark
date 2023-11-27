#!/usr/bin/env bash
set -e

# TODO: Add serve-config.yaml from github?
# applications:
# - name: ray-llm
#   route_prefix: /
#   import_path: rayllm.backend:router_application
#   args:
#     models:
#       - "./models/continuous_batching/meta-llama--Llama-2-7b-chat-hf.yaml"

# TODO: Make changes to model config for gpu type
# TODO: What about the value after the accelerator type, i.e. accelerator_type_a10: 0.01

# TODO: Need to change the model path probably

# TODO: Need to change the generation prompt format? What actually goes into the model?
# TODO: Maybe configure the stopping sequence too

cd "$(dirname $0)"
docker run -it --rm \
    --gpus all \
    --network host \
    --shm-size 10g \
    --volume ${PWD}/serve-config.yaml:/serve-config.yaml \
    --volume ${PWD}/model-config.yaml:/model-config.yaml \
    --volume ${PWD}/../../hf-models:/hf-models \
    anyscale/ray-llm \
    serve run /serve-config.yaml
