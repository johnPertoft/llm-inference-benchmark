from transformers import AutoModelForCausalLM
from transformers import LlamaTokenizer

p = "meta-llama/Llama-2-7b-chat-hf"
o = "hf-models/llama-2-7b-chat-hf"
AutoModelForCausalLM.from_pretrained(p).save_pretrained(o)
LlamaTokenizer.from_pretrained(p, legacy=True).save_pretrained(o)
# TODO: Using legacy=True is a seems to be necessary for the tensorrt test scripts to work.
# Shouldn't be needed if we just load the tokenizer with AutoTokenizer like normally.
