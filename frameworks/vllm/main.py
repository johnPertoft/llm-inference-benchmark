from vllm.engine.arg_utils import AsyncEngineArgs
from vllm.engine.async_llm_engine import AsyncLLMEngine
from vllm.sampling_params import SamplingParams
from vllm.utils import random_uuid

engine_args = AsyncEngineArgs(model=MODEL_PATH, tokenizer=MODEL_PATH, dtype=DTYPE)
engine = AsyncLLMEngine.from_engine_args(engine_args)
sampling_params = SamplingParams(temperature=0.0, top_p=1.0, max_tokens=96)
