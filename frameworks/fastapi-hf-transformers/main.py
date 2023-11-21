from pydantic import BaseModel


class GenerationRequest(BaseModel):
    input: str


class GenerationResponse(BaseModel):
    output: str


app = FastAPI(title="hf-transformers")


@app.post("/generate", response_model=GenerationResponse)
async def generate(request: GenerationRequest) -> GenerationResponse:
    pass
