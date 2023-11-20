FROM nvcr.io/nvidia/tritonserver:23.10-trtllm-python-py3
RUN apt-get update && apt-get install git-lfs
RUN git clone https://github.com/triton-inference-server/tensorrtllm_backend.git \
    && git lfs install \
    && cd tensorrtllm_backend \
    && sed -i "s/git@github.com:NVIDIA\/TensorRT-LLM.git/https:\/\/github.com\/NVIDIA\/TensorRT-LLM.git/g" .gitmodules \
    && git submodule update --init --recursive
RUN pip install sentencepiece protobuf datasets
RUN pip install git+https://github.com/NVIDIA/TensorRT-LLM.git \
    && mkdir /usr/local/lib/python3.10/dist-packages/tensorrt_llm/libs/ \
    && cp /opt/tritonserver/backends/tensorrtllm/* /usr/local/lib/python3.10/dist-packages/tensorrt_llm/libs/
ARG USERNAME=user
ARG USER_UID=1000
ARG USER_GID=$USER_UID
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME
RUN groupmod --gid $USER_GID $USERNAME \
    && usermod --uid $USER_UID --gid $USER_GID $USERNAME \
    && chown -R $USER_UID:$USER_GID /home/$USERNAME
