from fastapi import FastAPI
from pydantic import BaseModel


class GenerationRequest(BaseModel):
    input: str


class GenerationResponse(BaseModel):
    output: str


# model_path = "/hf-models/llama-2-7b-chat-hf"
# engine_args = AsyncEngineArgs(model=model_path, tokenizer=model_path, dtype="float16")
# engine = AsyncLLMEngine.from_engine_args(engine_args)
# sampling_params = SamplingParams(temperature=0.0, top_p=1.0, max_tokens=256, ignore_eos=True)

app = FastAPI(title="tensorrt")

@app.post("/generate", response_model=GenerationResponse)
async def generate(request: GenerationRequest) -> GenerationResponse:
    # TODO: Update this
    #results_generator = engine.generate(request.input, sampling_params, random_uuid())

    return GenerationResponse(output=out_text)
