from dotenv import load_dotenv
import openai
load_dotenv()
messages = [{"role": "developer", "content": "You are a Python expert."},
            {"role": "user", "content": "create code for a linear regression"},
            ]
response = openai.chat.completions.create(
    model="gpt-4o-mini",
    messages=messages,
)
print(response.choices[0].message.content)
