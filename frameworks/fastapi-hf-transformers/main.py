from pydantic import BaseModel
from transformers import AutoModelForCausalLM
from transformers import AutoTokenizer


class GenerationRequest(BaseModel):
    input: str


class GenerationResponse(BaseModel):
    output: str


model_path = "/hf-models/llama-2-7b-chat-hf"
model = AutoModelForCausalLM.from_pretrained(model_path)
tokenizer = AutoTokenizer.from_pretrained(model_path)

app = FastAPI(title="hf-transformers")

# TODO: At least need to fix some simple batching mechanic so it's more fair.


@app.post("/generate", response_model=GenerationResponse)
async def generate(request: GenerationRequest) -> GenerationResponse:
    return GenerationResponse(output="TODO")
