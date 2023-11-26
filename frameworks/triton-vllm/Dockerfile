FROM nvcr.io/nvidia/tritonserver:23.10-vllm-python-py3

# TODO: Keep this config outside the image instead and mount it instead?
RUN mkdir -p /models \
    && wget -P /models/vllm_model/1 https://raw.githubusercontent.com/triton-inference-server/vllm_backend/r23.10/samples/model_repository/vllm_model/1/model.json \
    && wget -P /models/vllm_model/ https://raw.githubusercontent.com/triton-inference-server/vllm_backend/r23.10/samples/model_repository/vllm_model/config.pbtxt
RUN cat /models/vllm_model/1/model.json \
    | jq '.model = "/hf-models/llama-2-7b-chat-hf"' > /tmp/model.json \
    && mv /tmp/model.json /models/vllm_model/1/model.json
