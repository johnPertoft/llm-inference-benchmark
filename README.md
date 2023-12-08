# LLM Inference Benchmark
Comparing inference frameworks for LLMs for my usecase at work. Currently just a big mess:)

## Delimitations
Initially just focusing on comparing performance for a 7B Llama2 model on a single a100 40gb.

## Usage

### Setup
TODO

### Run LLM inference framework
Every framework folder has at least one run script without arguments that will run a container with
that framework with different model dtype settings.

## TODO

### Misc
- [ ] Run benchmark code etc in another container?
- [ ] Compare with paid solutions?
- [ ] Validate outputs too, run over some datasets and compute metrics?
- [ ] Better benchmark with varying input/output lengths
- [ ] Code from tensorrt-llm wants to load llamatokenizer in legacy mode. Consequences for other frameworks?
      See if it's still a problem
- [ ] Pin all versions
- [ ] Where does FasterTransformers position itself here really?
- [ ] Need to make sure we generate the same number of tokens for proper comparison
- [ ] Compare with llama.cpp etc too
- [ ] Enable input params to control generation for all setups
- [ ] Can we get some metrics for how full the batches are?
- [ ] And to what extent / whether continuous batching is used
- [ ] How to increase gpu utilization? Even with a lot of concurrent users it doesn't go to 100%
      Bad configuration?
- [ ] Any other serving frontends available? Use something faster than fastapi or no point?
- [ ] TODO: Check https://github.com/mistralai/mistral-src/blob/main/deploy/Dockerfile
- [ ] TorchServe https://hamel.dev/notes/serving/torchserve/hf.html

### Frontends
- [ ] RayServe
- [ ] FastApi maybe doesn't make so much sense unless the batching is implemented in the backend solution
  - For fastapi + vllm, is it better to just run the vllm server entrypoint? Just delete the fastapi+vllm one.

### Triton + TensorrtLLM
- [ ] Initial results with this setup are worse than others, user error?
- [ ] Try with and without inflight/continuous batching?
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
- [x] Continuous/in-flight batching. On by default I think?
