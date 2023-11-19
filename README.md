# LLM Inference Benchmark
Comparing inference frameworks for LLMs

## Delimitations
TODO: single gpu only setups?

## Usage
TODO

## TODO

### Misc
- [ ] Proper instructions
- [ ] Remove devcontainer config, not needed and just adds complexity
- [ ] Do both http and grpc calls?
- [ ] Validate outputs too, run over some datasets and compute metrics?
- [ ] All services should accept batches?
- [ ] Use proper prompting format for models
- [ ] Code from tensorrt-llm wants to load llamatokenizer in legacy mode. Consequences?
- [ ] Pin all versions
- [ ] Where does FasterTransformers position itself here really?
- [ ] Need to make sure we generate the same number of tokens for proper comparison

### Fastapi + TensorrtLLM
- [ ] TODO
- [ ] Quantization options?

### Fastapi + vllm
- [ ] Support batch inputs?
- [ ] Quantization options?

### Triton + TensorrtLLM
- [ ] Try with and without inflight batching?
- [ ] Try different quantization configs
- [ ] Improve build model/engine script to be more automatic. Write the config.pbtxt files too.
- [ ] Compare prebuilt image vs building our own (at least by building our own we can reduce build time)
- [ ] Change the tokenizer to not include special tokens maybe? (Need to change the tokenizer triton model)

### Triton + vllm
- [ ] Try with and without inflight batching?
- [ ] Is quantization supported?

### Text Generation Inference
- [x] Don't even have to build the image ourselves :sunglasses:
- [ ] Try quantization options
- [ ] Continuous/in-flight batching
