from transformers import AutoModelForCausalLM
from transformers import AutoTokenizer

p = "meta-llama/Llama-2-7b-chat-hf"
o = "models/llama-2-7b-chat-hf"

m = AutoModelForCausalLM.from_pretrained(p)
t = AutoTokenizer.from_pretrained(p)
m.save_pretrained(o)
t.save_pretrained(o)
