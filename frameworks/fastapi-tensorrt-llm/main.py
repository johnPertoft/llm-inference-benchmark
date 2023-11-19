from pathlib import Path

import tensorrt_llm
import torch
from fastapi import FastAPI
from pydantic import BaseModel
from tensorrt_llm.quantization import QuantMode
from tensorrt_llm.runtime import ModelConfig, SamplingConfig


# TODO: Get utility functions from docker image?
# TODO: Wrap the code to load the engine into a function.


class GenerationRequest(BaseModel):
    input: str


class GenerationResponse(BaseModel):
    output: str


tensorrt_llm.logger.set_level(log_level)
engine_dir = Path(engine_dir)
config_path = engine_dir / "config.json"
model_config, tp_size, pp_size, dtype = read_config(config_path)
world_size = tp_size * pp_size
runtime_rank = tensorrt_llm.mpi_rank()
runtime_mapping = tensorrt_llm.Mapping(
    world_size,
    runtime_rank,
    tp_size=tp_size,
    pp_size=pp_size,
)
torch.cuda.set_device(runtime_rank % runtime_mapping.gpus_per_node)

tokenizer = LlamaTokenizer.from_pretrained(tokenizer_dir, legacy=False)

# TODO: Get these from the tokenizer instead?
sampling_config = SamplingConfig(
    end_id=2,
    pad_id=2,
    num_beams=num_beams,
)

engine_name = get_engine_name(
    "llama",
    dtype,
    tp_size,
    pp_size,
    runtime_rank,
)
serialize_path = engine_dir / engine_name
with open(serialize_path, "rb") as f:
    engine_buffer = f.read()
decoder = tensorrt_llm.runtime.GenerationSession(
    model_config,
    engine_buffer,
    runtime_mapping,
    debug_mode=False,
    debug_tensors_to_save=None,
)

if runtime_rank == 0:
    print(f"Running the {dtype} engine ...")


app = FastAPI(title="tensorrt")

@app.post("/generate", response_model=GenerationResponse)
async def generate(request: GenerationRequest) -> GenerationResponse:
    # TODO: Update this
    #results_generator = engine.generate(request.input, sampling_params, random_uuid())

    return GenerationResponse(output=out_text)


def trt_generate(input: str) -> str:
    # TODO: Handle batch input here?

    # TODO: Simplify
    input_ids, input_lengths = parse_input(
        input_text,
        input_file,
        tokenizer,
        EOS_TOKEN,
        model_config.remove_input_padding,
    )

    max_input_length = torch.max(input_lengths).item()
    decoder.setup(
        input_lengths.size(0),
        max_input_length,
        max_output_len,
        num_beams,
    )

    output_gen_ids = decoder.decode(
        input_ids,
        input_lengths,
        sampling_config,
        streaming=streaming,
    )

    # TODO: Simplify
    torch.cuda.synchronize()
    if streaming:
        for output_ids in throttle_generator(output_gen_ids, streaming_interval):
            if runtime_rank == 0:
                print_output(output_ids, input_lengths, max_output_len,
                             tokenizer, output_csv, output_npy)
    else:
        output_ids = output_gen_ids
        if runtime_rank == 0:
            print_output(output_ids, input_lengths, max_output_len, tokenizer,
                         output_csv, output_npy)
