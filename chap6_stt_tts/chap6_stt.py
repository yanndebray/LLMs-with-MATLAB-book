# chap6_stt.py

import openai
from pathlib import Path
fileName = "enYann-tale_of_two_cities.mp3"
file_path = Path(fileName)
transcription = openai.audio.transcriptions.create(model="whisper-1", file=file_path)
print(transcription.text)