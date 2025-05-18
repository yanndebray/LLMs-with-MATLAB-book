from openai import OpenAI

ngrok = '<your-tunnel>.ngrok-free.app'
client = OpenAI(api_key='ollama', base_url=f'http://{ngrok}/v1')
#openai.api_key = 'ollama'
#openai.api_base = 'http://127.0.0.1:11434/v1'

response = client.chat.completions.create(model = 'llama3.2',
                                messages = [
                                    {"role": "system", "content": "You are a helpful assistant."},
                                    {"role": "user", "content": "What is the capital of the United States?"},
    ]
)
print(response.choices[0])