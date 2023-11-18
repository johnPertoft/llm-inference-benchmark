FROM nvcr.io/nvidia/pytorch:23.09-py3
RUN pip install vllm
COPY main.py /main.py
ENTRYPOINT ["python", "main.py"]
