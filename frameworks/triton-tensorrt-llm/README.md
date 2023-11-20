# Triton Inference Server with TensorRT-LLM backend

## 1. Build the docker image
```bash
./build-image.sh
```

## 2. Build a Triton Inference Server model with a TensorRT-LLM engine
Note that paths are inside the container.
```bash
./build-model.sh <HF_MODEL_PATH> <TRITON_OUTPUT_PATH> [additional arguments passed along...]
```

## 3. Run Triton Inference Server
Note that paths are inside the container.
```bash
./run.sh <TRITON_MODEL_PATH>
```
