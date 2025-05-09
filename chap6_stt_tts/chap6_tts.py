# chap6_tts.py

import openai
speech_file_path = "speech.mp3"
response = openai.audio.speech.create(
  model="tts-1", voice="alloy",
  input="The quick brown fox jumped over the lazy dog.")
response.stream_to_file(speech_file_path)