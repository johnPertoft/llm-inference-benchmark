from locust import HttpUser, task


class LLMUser(HttpUser):
    @task
    def generate(self):
        data = {
            "text_input": "[INST] How do I count to thirty in German? [/INST]",
            "parameters": {"max_tokens": 128, "stream": False, "temperature": 0},
        }
        self.client.post("/generate", json=data)
