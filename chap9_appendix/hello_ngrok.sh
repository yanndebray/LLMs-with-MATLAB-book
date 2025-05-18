curl https://<your-tunnel>.app/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "llama3.2",
    "messages": [{ "role": "user", "content": "Hello through the tunnel!" }]
  }'
