from locust import HttpUser, task

# TODO: Can we have a single locust file for all frameworks?
# TODO: They differ slightly in what input parameters they expose I guess
# TODO: Should also make sure to control how many tokens are generated for proper comparison.
# TODO: Define different workloads, with some variation? or deterministically go over a dataset?
# - short input, short output
# - long input, short output  <- this is kind of what we have
# - short input, long output
# - long input, long output
# - Also should have a workload that triggers continuous batching more if we can


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
