from datasets import load_dataset
from transformers import AutoTokenizer

# ds = load_dataset("trivia_qa", "rc", split="validation")
ds = load_dataset("cnn_dailymail", "3.0.0", split="validation")

tokenizer = AutoTokenizer.from_pretrained("hf-models/llama-2-7b-chat-hf")

ds = ds.select(range(100))
ds = ds.map(
    lambda x: {
        "article": tokenizer.apply_chat_template(
            [{"role": "user", "content": f"Summarize: {x['article']}"}], tokenize=False
        )
    }
)
ds = ds.remove_columns(["highlights", "id"])

breakpoint()
