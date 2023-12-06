FROM nvcr.io/nvidia/pytorch:23.09-py3
RUN pip install vllm==0.2.3
ENTRYPOINT ["python", "-m", "vllm.entrypoints.api_server"]
