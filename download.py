from transformers import AutoModelForCausalLM
from transformers import AutoTokenizer

p = "meta-llama/Llama-2-7b-chat-hf"
o = "models/llama-2-7b-chat-hf"
AutoModelForCausalLM.from_pretrained(p).save_pretrained(o)
AutoTokenizer.from_pretrained(p).save_pretrained(o)
