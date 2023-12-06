# LLM Inference Benchmark
Comparing inference frameworks for LLMs for my usecase at work.

## Delimitations
Initially focusing on comparing performance for a 7B Llama2 model on a single a100 40gb.

## Usage
TODO

## TODO

### Misc
- [ ] Proper instructions
- [ ] Remove devcontainer config, not needed and just adds complexity
- [ ] Compare with paid solutions?
- [ ] Do both http and grpc calls?
- [ ] Validate outputs too, run over some datasets and compute metrics?
- [ ] All services should accept batches?
- [ ] Use proper prompting format for models
- [ ] Code from tensorrt-llm wants to load llamatokenizer in legacy mode. Consequences?
- [ ] Pin all versions
- [ ] Where does FasterTransformers position itself here really?
- [ ] Need to make sure we generate the same number of tokens for proper comparison
- [ ] Check options for available metrics etc
- [ ] Compare with llama.cpp etc too
- [ ] Enable input params to control generation for all setups
- [ ] Can we get some metrics for how full the batches are?
- [ ] And to what extent / whether continuous batching is used
- [ ] Do we need to configure this somewhere?
- [ ] How to increase gpu utilization? Even with a lot of concurrent users it doesn't go to 100%
      Bad configuration?
- [ ] Any other serving frontends available? Use something faster than fastapi or no point?
- [ ] Change all run scripts to also build image + model if necessary?
- [ ] TODO: Check https://github.com/mistralai/mistral-src/blob/main/deploy/Dockerfile

### Frontends
- [ ] TorchServe https://hamel.dev/notes/serving/torchserve/hf.html
- [ ] RayServe
- [ ] FastApi maybe doesn't make so much sense unless the batching is implemented in the backend solution
  - For fastapi + vllm, is it better to just run the vllm server entrypoint?

### Fastapi + TensorrtLLM
- [ ] TODO
- [ ] Quantization options?
- [ ] Share build scripts for TensorrtLLM with triton setup

### Fastapi + vllm
- [ ] Support batch inputs?
- [ ] Quantization options?
- [ ] Start the vllm server separately and send requests to it instead of using AsyncEngine? Any difference?

### Triton + TensorrtLLM
- [ ] Try with and without inflight batching?
- [ ] Try different quantization configs
- [ ] Improve build model/engine script to be more automatic. Write the config.pbtxt files too.
- [ ] Compare prebuilt image vs building our own (at least by building our own we can reduce build time)
- [ ] Change the tokenizer to not include special tokens maybe? (Need to change the tokenizer triton model)
- [ ] There's some warnings when running the build model script about skipping stuff. Fix.
- [ ] Are we / can we use CudaGraph?
- [ ] All scripts so far are for llama(2). There's some extra considerations to take for codellama for example
      because of different vocab size. See documentation.

### Triton + vllm
- [ ] Try with and without inflight batching?
- [ ] Is quantization supported?

### Text Generation Inference
- [x] Don't even have to build the image ourselves :sunglasses:
- [ ] Try quantization options
- [ ] Continuous/in-flight batching
