FROM nvcr.io/nvidia/pytorch:23.09-py3
RUN apt-get update && apt-get install git-lfs
RUN pip install fastapi pydantic uvicorn
RUN pip install git+https://github.com/NVIDIA/TensorRT-LLM.git \
    && mkdir /usr/local/lib/python3.10/dist-packages/tensorrt_llm/libs/
COPY --from=nvcr.io/nvidia/tritonserver:23.10-trtllm-python-py3 /opt/tritonserver/backends/tensorrtllm /usr/local/lib/python3.10/dist-packages/tensorrt_llm/libs
COPY main.py /workspace/main.py
CMD ["python", "main.py"]
#CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "3000", "--workers", "1"]

# FROM tensorrt_llm/release
# WORKDIR /app
# RUN pip install fastapi datasets rouge_score nltk sentencepiece
# COPY main.py /app/main.py
# COPY build/TensorRT-LLM/benchmarks/ /app/benchmarks/
# CMD [ "python", "main.py" ]
