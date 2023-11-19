from locust import HttpUser, task

# TODO:
# - Include inputs and expected outputs of varying lengths
# - Maybe just run over some dataset to get a good variety of inputs

class LLMUser(HttpUser):
    @task
    def generate(self):
        data = {
            "inputs": "[INST] How do I count to thirty in German? [/INST]",
            "parameters": {
                "max_new_tokens": 256,
            },
        }
        self.client.post("/generate", json=data)
