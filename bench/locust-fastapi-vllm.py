from locust import HttpUser, task


class LLMUser(HttpUser):
    @task
    def generate(self):
        data = {
            "input": "[INST] How do I count to thirty in German? [/INST]",
        }
        self.client.post("/generate", json=data)
