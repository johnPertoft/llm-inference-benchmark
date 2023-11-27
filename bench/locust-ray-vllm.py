from locust import HttpUser, task


class LLMUser(HttpUser):
    @task
    def generate(self):
        data = {
            "model": "/hf-models/llama-2-7b-chat-hf",
            "messages": [
                {"role": "user", "content": "How do I count to thirty in German?"}
            ],
            "temperature": 0.0,
            "max_tokens": 128,
        }
        self.client.post("/chat/completions", json=data)
