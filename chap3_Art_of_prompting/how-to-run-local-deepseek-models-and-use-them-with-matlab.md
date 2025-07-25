# How to Run Local DeepSeek Models and Use Them with MATLAB

**Posted by Mike Croucher, February 4, 2025**

**Views:** 1079 (last 30 days) | **Likes:** 0 | **Comments:** 15

---

After the release of the DeepSeek-R1 AI models, many users have inquired about how to utilize them in MATLAB. Recently, Vasileios Papanastasiou, a software test engineer at MathWorks, shared a guide on LinkedIn, which I followed to run the model on my local machine.

## Running deepseek-r1:1.5b on My Local Machine

To get started, I used the "Large Language Models (LLMS) with MATLAB" add-on along with Ollama to run one of the smaller DeepSeek models. Here’s how I did it:

1. **Download and Install Ollama**: 
   - Visit [Ollama's download page](https://ollama.com/download) and install it on your Windows machine.

2. **Run the Model**: 
   - After installation, open the command line and execute the command:
     ```
     ollama run deepseek-r1:1.5b
     ```
   - This command installs a 1.5 billion parameter model, which is manageable in terms of computational resources.

3. **Set Up MATLAB**: 
   - Instead of following Vasileios's GitHub route, I opted to use MATLAB R2024b. I clicked on **Add-ons** in the Environment tab, searched for 'Large Language Models', and clicked on 'Add' to install it.

### Interacting with the Model in MATLAB

Now that the installation is complete, I created an `ollamaChat` object in MATLAB:

```matlab
chat = ollamaChat("deepseek-r1:1.5b")
```

This command initializes the chat object with the following properties:

- **ModelName**: "deepseek-r1:1.5b"
- **Endpoint**: "127.0.0.1:11434"
- **TopK**: Inf
- **MinP**: 0
- **TailFreeSamplingZ**: 1
- **Temperature**: 1
- **TopP**: 1
- **StopSequences**: [0×0 string]
- **TimeOut**: 120
- **SystemPrompt**: []
- **ResponseFormat**: "text"

### Generating Responses

I tested the model by asking it a question:

```matlab
txt = generate(chat, "What is the speed of light?")
```

The response was:

```
<think>
</think>
The exact value of the speed of light in a vacuum is defined as \( 299,792,458 \) meters per second.
```

I found it interesting that the model's responses varied with each query. For example:

1. **First Query**:
   ```
   The speed of light in a vacuum is approximately 299,792 kilometers (186,282 statute miles) per second.
   ```

2. **Second Query**:
   ```
   <think>
   Okay, so I'm trying to figure out what the speed of light is...
   ...
   The speed of light is approximately three times 10^8 meters per second but precisely calculated to around 299,792,458 m/s.
   </think>
   ```

The model provided a detailed explanation, showcasing its ability to generate varied and complex responses.

### Conclusion

While this is a smaller version of the DeepSeek model, it still demonstrates useful capabilities and serves as an engaging way to explore the strengths and weaknesses of LLM-based AI technology. I encourage you to try it out and share your thoughts!

---

You are now following this blog post and will receive updates in your activity feed. You may also receive emails based on your notification preferences.

**Category**: Artificial Intelligence (AI)