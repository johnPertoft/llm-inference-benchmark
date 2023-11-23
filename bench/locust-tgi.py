from locust import HttpUser, task


class LLMUser(HttpUser):
    @task
    def generate(self):
        data = {
            "inputs": "[INST] How do I count to thirty in German? [/INST]",
            "parameters": {
                "max_new_tokens": 128,
            },
        }
        self.client.post("/generate", json=data)
