from locust import HttpUser, task

# TODO: Delete this specific file?

class LLMUser(HttpUser):
    @task
    def generate(self):
        data = {
            "text_input": "[INST] How do I count to thirty in German? [/INST]",
            "parameters": {
                "max_tokens": 128,
                "bad_words": [""],
                "stop_words": [""],  # TODO: Can we set "</s>" here or something?
            },
        }
        self.client.post("/v2/models/ensemble/generate", json=data)
