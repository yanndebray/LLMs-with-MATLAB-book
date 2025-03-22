# How to Run Local DeepSeek Models and Use Them with MATLAB

Almost immediately after the DeepSeek-R1 AI models were released, users began inquiring about their integration with MATLAB. Recently, Vasileios Papanastasiou, a software test engineer at MathWorks, shared instructions on LinkedIn, which I decided to try on my own machine.

## Running DeepSeek-R1:1.5B on My Local Machine

I utilized the "Large Language Models (LLMS) with MATLAB" add-on along with Ollama to run one of the smaller DeepSeek models locally and interact with it in MATLAB. Following Vasileios's guidance, I first:

1. **Download and Install Ollama**: [Ollama Download](https://ollama.com/download) (I did this on Windows).
2. After installation, I opened a command line and executed the command:
   ```
   ollama run deepseek-r1:1.5b
   ```
   This command installs a 1.5 billion parameter model, which is relatively small, alleviating concerns about computational resource constraints. Larger models can be explored later.

Next, I turned to MATLAB. While Vasileios suggested obtaining the "Large Language Models (LLMS) with MATLAB" add-on from GitHub, I opted for a different method:

1. I clicked on **Add-ons** in the Environment tab of MATLAB R2024b.
2. In the Add-on Explorer, I searched for "Large Language Models" and clicked on "Add" to complete the download and installation.

## Interacting with the Model in MATLAB

With the installation complete, I was ready to experiment in MATLAB. I created an `ollamaChat` object:

```matlab
chat = ollamaChat("deepseek-r1:1.5b")
```

This returned the following properties:

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

Now, I could start interacting with the AI. For example, I asked:

```matlab
txt = generate(chat, "What is the speed of light?")
```

The response was:

```
<think>
</think>
The exact value of the speed of light in a vacuum is defined as \( 299,792,458 \) meters per second.
This precise definition ensures consistency and accuracy across all scientific measurements and calculations.
```

One interesting aspect of LLMs is their stochastic nature; asking the same question multiple times can yield different answers. For instance:

1. **First Response**:
   ```
   The speed of light in a vacuum is approximately 299,792 kilometers (186,282 statute miles) per second.
   Light is the fastest thing in the universe with its universal speed limit.
   ```

2. **Second Response** (more verbose):
   ```
   <think>
   Okay, so I'm trying to figure out what the speed of light is...
   ...
   In summary, the speed of light remains a constant, significantly impacting various areas of physics and our understanding of the universe.
   </think>
   ```

While the model can produce lengthy and sometimes convoluted responses, it consistently identifies the speed of light as **299,792,458 meters per second**, which is accurate according to reliable sources.

## Conclusion

Despite being a smaller version of the DeepSeek model, it still demonstrates useful capabilities and serves as an engaging way to explore the strengths and weaknesses of LLM-based AI technology. I encourage you to try it out and share your thoughts!