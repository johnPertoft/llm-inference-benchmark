FROM nvcr.io/nvidia/tritonserver:23.10-trtllm-python-py3
RUN apt-get update && apt-get install git-lfs
RUN git clone https://github.com/triton-inference-server/tensorrtllm_backend.git \
    && git lfs install \
    && cd tensorrtllm_backend \
    && sed -i "s/git@github.com:NVIDIA\/TensorRT-LLM.git/https:\/\/github.com\/NVIDIA\/TensorRT-LLM.git/g" .gitmodules \
    && git submodule update --init --recursive
RUN pip install sentencepiece protobuf
RUN pip install git+https://github.com/NVIDIA/TensorRT-LLM.git \
    && mkdir /usr/local/lib/python3.10/dist-packages/tensorrt_llm/libs/ \
    && cp /opt/tritonserver/backends/tensorrtllm/* /usr/local/lib/python3.10/dist-packages/tensorrt_llm/libs/

# TODO: Probably need this too.
# TensorRT-LLM is required for generating engines. You can skip this step if
# you already have the package installed. If you are generating engines within
# the Triton container, you have to install the TRT-LLM package.
# pip install git+https://github.com/NVIDIA/TensorRT-LLM.git
# mkdir /usr/local/lib/python3.10/dist-packages/tensorrt_llm/libs/
# cp /opt/tritonserver/backends/tensorrtllm/* /usr/local/lib/python3.10/dist-packages/tensorrt_llm/libs/

#RUN git clone
# TODO: Add the stuff needed to build models, maybe as a multistage or something
# TODO: Is there like a dev image for this?
#ADD https://raw.githubusercontent.com/triton-inference-server/tensorrtllm_backend/release/0.5.0/scripts/launch_triton_server.py launch_triton_server.py
#ADD https://raw.githubusercontent.com/triton-inference-server/tensorrtllm_backend/release/0.5.0/tools/fill_template.py fill_template.py

# TODO: Add entrypoint to start everything? Or add in in run.sh? Since we need to use it to build too.
