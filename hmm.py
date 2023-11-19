import time

import torch
from transformers import AutoTokenizer, AutoModelForCausalLM


model_id = "hf-models/llama-2-7b-chat-hf"
model = AutoModelForCausalLM.from_pretrained(model_id, torch_dtype=torch.float16, device_map="auto")
tokenizer = AutoTokenizer.from_pretrained(model_id)
tokenizer.use_default_system_prompt = False

conversation = [
    {"role": "user", "content": "How do I count to thirty in German?"}
]
input_ids = tokenizer.apply_chat_template(conversation, return_tensors="pt")
input_ids = input_ids.to(model.device)

"""
streamer = TextIteratorStreamer(tokenizer, timeout=10.0, skip_prompt=True, skip_special_tokens=True)
generate_kwargs = dict(
    {"input_ids": input_ids},
    streamer=streamer,
    max_new_tokens=max_new_tokens,
    do_sample=True,
    top_p=top_p,
    top_k=top_k,
    temperature=temperature,
    num_beams=1,
    repetition_penalty=repetition_penalty,
)
t = Thread(target=model.generate, kwargs=generate_kwargs)
t.start()
"""

t1 = time.time()
outputs = model.generate(input_ids, max_new_tokens=256, do_sample=True)
outputs = tokenizer.batch_decode(outputs)
t2 = time.time()
print(outputs)
print("Latency", t2 - t1)
