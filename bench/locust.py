from locust import HttpUser
from locust import task

# TODO:
# - Common (forced) output length
# - Use a dataset with varying input/output lengths.
#   - Order should be fixed
#   - How to share it between the processes?


class BaseUser(HttpUser):
    @task
    def generate(self) -> None:
        ...


class TritonTrtUser(BaseUser):
    @task
    def generate(self) -> None:
        data = {
            "text_input": "[INST] How do I count to thirty in German? [/INST]",
            "parameters": {
                "max_tokens": 128,
                "stream": False,
                "temperature": 0,
                "bad_words": [""],
                "stop_words": [""],
            },
        }
        self.client.post("/generate", json=data)


class TritonVllmUser(BaseUser):
    @task
    def generate(self) -> None:
        data = {
            "text_input": "[INST] How do I count to thirty in German? [/INST]",
            "parameters": {
                "max_tokens": 128,
                "stream": False,
                "temperature": 0,
            },
        }
        self.client.post("/generate", json=data)


class TgiUser(BaseUser):
    @task
    def generate(self) -> None:
        data = {
            "inputs": "[INST] How do I count to thirty in German? [/INST]",
            "parameters": {
                "max_new_tokens": 128,
            },
        }
        self.client.post("/generate", json=data)


class RayUser(BaseUser):
    @task
    def generate(self):
        # TODO: This one seems to want to do tokenization templating etc, e.g. adding the [INST]
        # stuff for llama
        # TODO: Try to avoid using that feature if possible.
        data = {
            "model": "/hf-models/llama-2-7b-chat-hf",
            "messages": [
                {"role": "user", "content": "How do I count to thirty in German?"}
            ],
            "temperature": 0.0,
            "max_tokens": 128,
        }
        self.client.post("/chat/completions", json=data)


class FastApiVllmUser(BaseUser):
    @task
    def generate(self) -> None:
        # TODO: Add params for num tokens to generate etc.
        data = {
            "input": "[INST] How do I count to thirty in German? [/INST]",
            "num_tokens": 128,
            "ignore_eos": True,
        }
        self.client.post("/generate", json=data)
