from locust import HttpUser
from locust import task
from transformers import AutoTokenizer

# TODO:
# - Common (forced) output length
# - Use a dataset with varying input/output lengths.
#   - Order should be fixed
#   - How to share it between the processes?


class BaseUser(HttpUser):
    tokenizer = AutoTokenizer.from_pretrained("../hf-models/llama-2-7b-chat-hf")
    raw_prompt = "How do I count to thirty in German?"
    messages = [{"role": "user", "content": raw_prompt}]
    prompt = tokenizer.apply_chat_template(messages, tokenize=False)
    num_prompt_tokens = len(tokenizer.apply_chat_template(messages, tokenize=True))
    max_tokens = 128
    temperature = 0.0

    @task
    def generate(self) -> None:
        ...


class TritonTrtUser(BaseUser):
    @task
    def generate(self) -> None:
        data = {
            "text_input": self.prompt,
            "parameters": {
                "max_tokens": self.max_tokens,
                "stream": False,
                "temperature": self.temperature,
                "bad_words": [""],
                "stop_words": [""],
            },
        }
        self.client.post("/generate", json=data)


class TritonVllmUser(BaseUser):
    @task
    def generate(self) -> None:
        data = {
            "text_input": self.prompt,
            "parameters": {
                "max_tokens": self.max_tokens,
                "stream": False,
                "temperature": 0,  # TODO: Can't set a float 0.0 here?
            },
        }
        self.client.post("/generate", json=data)


class TgiUser(BaseUser):
    @task
    def generate(self) -> None:
        data = {
            "inputs": self.prompt,
            "parameters": {
                "max_new_tokens": self.max_tokens - self.num_prompt_tokens,
                # "temperature": 0,
                "do_sample": False,
            },
        }
        self.client.post("/generate", json=data)


class RayUser(BaseUser):
    @task
    def generate(self):
        # Note: Ray seems to want to do the templating for the prompt itself, e.g. adding the [INST]
        # stuff for llama.
        # TODO: Can we avoid using this feature to be sure that we're doing the same thing?
        data = {
            "model": "/hf-models/llama-2-7b-chat-hf",
            "messages": self.messages,
            "temperature": self.temperature,
            "max_tokens": self.max_tokens,
        }
        self.client.post("/chat/completions", json=data)


# TODO: Delete this.
class FastApiVllmUser(BaseUser):
    @task
    def generate(self) -> None:
        data = {
            "input": self.prompt,
            "num_tokens": self.max_tokens,
            "ignore_eos": True,
        }
        self.client.post("/generate", json=data)


class VllmUser(BaseUser):
    @task
    def generate(self) -> None:
        data = {
            "prompt": self.prompt,
            "stream": False,
            "ignore_eos": True,
            "max_tokens": self.max_tokens,
            "temperature": self.temperature,
        }
        self.client.post("/generate", json=data)
