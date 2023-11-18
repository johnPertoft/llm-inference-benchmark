FROM nvcr.io/nvidia/tritonserver:23.10-trtllm-python-py3
RUN pip install sentencepiece protobuf
ADD https://raw.githubusercontent.com/triton-inference-server/tensorrtllm_backend/release/0.5.0/scripts/launch_triton_server.py launch_triton_server.py
# TODO: Get the launcher script in here
