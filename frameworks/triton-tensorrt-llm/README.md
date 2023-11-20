# Triton Inference Server with TensorRT-LLM backend

## 1. Build the docker image
```bash
./build-image.sh
```

## 2. Build a Triton Inference Server model with a TensorRT-LLM engine
Note that paths are inside the container.

### fp16
```bash
./build-model.sh /hf-models/llama-2-7b-chat-hf /models/llama-2-7b-chat/1-gpu/fp16 /scripts/build-engine-fp16.sh
```

### int8
```bash
./build-model.sh /hf-models/llama-2-7b-chat-hf /models/llama-2-7b-chat/1-gpu/int8 /scripts/build-engine-int8.sh
```

### int8 w/ int8 kv cache
```bash
./build-model.sh /hf-models/llama-2-7b-chat-hf /models/llama-2-7b-chat/1-gpu/int8-int8-kv /scripts/build-engine-int8-int8-kv.sh
```

### int4 gptq
```bash
./build-model.sh /hf-models/llama-2-7b-chat-hf /models/llama-2-7b-chat/1-gpu/int4-gptq /scripts/build-engine-int4-gptq.sh
```

### int4 awq
```bash
./build-model.sh /hf-models/llama-2-7b-chat-hf /models/llama-2-7b-chat/1-gpu/int4-awq /scripts/build-engine-int4-awq.sh
```

## 3. Run Triton Inference Server
Note that paths are inside the container.
```bash
./run.sh <TRITON_MODEL_PATH>
```
