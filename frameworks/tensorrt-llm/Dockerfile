FROM tensorrt_llm/release
WORKDIR /app
RUN pip install fastapi datasets rouge_score nltk sentencepiece
COPY main.py /app/main.py
CMD [ "python", "main.py" ]
