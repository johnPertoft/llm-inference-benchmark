from vllm.engine.arg_utils import AsyncEngineArgs
from vllm.engine.async_llm_engine import AsyncLLMEngine
from vllm.sampling_params import SamplingParams
from vllm.utils import random_uuid
from pydantic import BaseModel
from fastapi import FastAPI


class GenerationRequest(BaseModel):
    input: str


class GenerationResponse(BaseModel):
    output: str


model_path = "/hf-models/llama-2-7b-chat-hf"
engine_args = AsyncEngineArgs(model=model_path, tokenizer=model_path, dtype="float16")
engine = AsyncLLMEngine.from_engine_args(engine_args)
sampling_params = SamplingParams(temperature=0.0, top_p=1.0, max_tokens=256, ignore_eos=False)

app = FastAPI(title="vllm")

@app.post("/generate", response_model=GenerationResponse)
async def generate(request: GenerationRequest) -> GenerationResponse:
    results_generator = engine.generate(request.input, sampling_params, random_uuid())

    final_output = None
    async for request_output in results_generator:
        final_output = request_output

    if final_output is None:
        raise HTTPException(status_code=404, detail="no response from model")

    out_text = final_output.outputs[0].text

    return GenerationResponse(output=out_text)
