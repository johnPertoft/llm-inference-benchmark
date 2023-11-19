# LLM Inference Benchmark
Comparing inference frameworks for LLMs

## Delimitations
TODO: single gpu only setups?

## TODO

### Misc
- [] Proper instructions
- [] Remove devcontainer config, not needed and just adds complexity

### Triton + TensorrtLLM
- [] Try with and without inflight batching?
- [] Try different quantization configs
- [] Improve build model/engine script to be more automatic. Write the config.pbtxt files too.
- [] Compare prebuilt image vs building our own (at least by building our own we can reduce build time)

### Triton + Vllm
- [] Try with and without inflight batching?
- [] Is quantization supported?

### Vllm
- [] Just plain fastapi + Vllm

### Text Generation Inference
- [] TODO
