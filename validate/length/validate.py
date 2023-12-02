import requests

from transformers import AutoTokenizer

# TODO:
# - Validate that we get the expected number of tokens from a server.
#   This is required to make the throughput comparison fair.
# - Might not always be exactly expected num tokens because of different tokenization behavior?
# - They might also do differently on total tokens vs new generated tokens.
# - Need to know which tokenizer to use here.

tokenizer = AutoTokenizer.from_pretrained("hf-models/llama-2-7b-chat-hf")


def check_tgi():
    data = {
        "inputs": "[INST] How do I count to thirty in German? [/INST]",
        "parameters": {
            "max_new_tokens": 128,
        },
    }
    resp = requests.post(
        "http://localhost:8000",
        json=data,
    )
    assert resp.status_code == 200
    resp = resp.json()[0]
    text = resp["generated_text"]

    tokens = tokenizer(text).input_ids
    assert 128 <= len(tokens) <= 129

    breakpoint()


def check_triton_trt():
    pass


def check_triton_vllm():
    pass


check_tgi()
