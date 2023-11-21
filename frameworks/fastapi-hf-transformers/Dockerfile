FROM nvcr.io/nvidia/pytorch:23.09-py3
RUN pip install fastapi pydantic transformers uvicorn
COPY main.py /workspace/main.py
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "3000", "--workers", "1"]
