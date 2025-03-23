# Chapter 3: The Art of Prompting, Chaining, and Summarization

In this chapter, you’ll see how to use web scraping, string handling, and an OpenAI chat wrapper to implement content extraction, formatting, translation, classification, summarization, and even two chaining approaches (MapReduce and refine).

---

## 1. The Art of Prompting in MATLAB

Effective prompting in MATLAB follows the same principles as in Python:
- **Clarity:** Clearly state the task.
- **Context:** Provide background information.
- **Specificity:** Define the expected output.

For example, instead of a vague prompt like:
```matlab
prompt = "Quantum mechanics.";
```
use a more specific one:
```matlab
prompt = "In simple terms, explain the basic principles of quantum mechanics to a high school student.";
```

You can also use role assignment, formatting instructions, or style guidelines. In MATLAB you’d build a prompt string and send it via the OpenAI chat interface.

---

## 2. Using MATLAB to Interact with an LLM

Below is a simplified helper function `bot` that uses MATLAB’s chat interface (assumed to be built on top of functions like `openAIChat` and `messageHistory` from the llms-with-MATLAB repository).

```matlab
function [text, response] = bot(prompt, temperature)
    % Set defaults if not provided
    if nargin < 3, temperature = 0; end
    
    % Load environment settings (if needed)
    loadenv("../.env");
    
    % Define the model name (as in our chap1 example)
    modelName = "gpt-4o-mini";
    chat = openAIChat("You are a MATLAB expert.", ...
            "ModelName", modelName, ...
            "Temperature", temperature, ...
            "TimeOut", 30 ...    
    );
    
    % Initialize message history and add the user prompt
    messages = messageHistory;
    messages = addUserMessage(messages, prompt);
    
    % Generate the response
    [text, response] = generate(chat, messages);
end
```

---

## 3. Extracting and Formatting Web Content

### 3.1 Extracting Content from a URL

MATLAB built-in functions such as `webread` and `htmlTree` let you fetch and parse webpages. 

**/!\\** htmlTree requires Text Analytics Toolbox.

```matlab
function [title, content] = extract_content(url)
    try
        % Make a web call with a custom timeout of 30 seconds
        options = weboptions('Timeout', 30);
        html = webread(url,options);
        tree = htmlTree(html);
        
        % Get the title element text
        t = findElement(tree, 'title');
        if ~isempty(t)
            title = extractHTMLText(t.Children);
        else
            title = "No Title Found";
        end
        % Extract body from the HTML tree
        body = findElement(tree, 'body');
        if ~isempty(body)
            content = extractHTMLText(body);
        else
            error("No body found in the HTML.");
        end
        
    catch ME
        fprintf("Error fetching %s: %s\n", url, ME.message);
        title = "";
        content = "";
    end
end
```

### 3.2 Formatting the Extracted Content

Once the raw text is extracted, you might want to clean and format it. The function below sends a prompt to the LLM for formatting:

```matlab
function formatted_content = format_content(title, content)
        prompt = [...
        "You are an expert text formatter and summarizer." ...
        "Here is an article:" ...
        "Title: " + title ...
        "Content:" ...
        content ...
        "Please format this scraped text into a clean, readable content."];
        prompt = strjoin(prompt, newline);
    % Call the bot function with the constructed prompt
    formatted_content = bot(prompt);
end
```

### 3.3 Generic Bot performing text processing

For any of the operations requiring AI in this chapter, let's implement a generic function using the OpenAI API:

```matlab
function [text, response] = bot(prompt, temperature)
    % Set defaults if not provided
    if nargin < 3, temperature = 0; end
    
    % Load environment settings (if needed)
    loadenv("../.env");
    
    % Define the model name (as in our chap1 example)
    modelName = "gpt-4o-mini";
    chat = openAIChat("You are a MATLAB expert.", ...
            "ModelName", modelName, ...
            "Temperature", temperature, ...
            "TimeOut", 30 ...    
    );
    
    % Initialize message history and add the user prompt
    messages = messageHistory;
    messages = addUserMessage(messages, prompt);
    
    % Generate the response
    [text, response] = generate(chat, messages);
end
```

---

## 4. Specialized Processing Functions

### 4.1 Translation

A zero‐shot translation function that asks the LLM to translate any given text into English:

```matlab
function translation = translate_article(content, language)
    % This function translates the given content into the specified language.
    % Default to English if no language specified
    if nargin < 2
        language = "English";
    end
    prompt = [...
        "Translate the following article to " + language ...
        content ...
        "Translation:"];
    prompt = strjoin(prompt, newline);
    translation = bot(prompt);
end
```

### 4.2 Classification (Few-Shot Prompting)

Using a few examples within the prompt to classify technical articles into predefined categories:

```matlab
function category = classify_article(content)
    prompt = ["You are an AI assistant that classifies technical articles into categories." ;
        "The categories are: " ;
        "- artificial intelligence (AI)" ;
        "- Data Science" ;
        "- High Performance Computing" ;
        "- Python" ;
        "- Quantum Computing" ;
        "- MATLAB Online" ;
        "- New Releases"
        "- Open Source" ;
        "- Others" ;
        "For example:" ;
        "Article: How to run local DeepSeek models and use them with MATLAB" ;
        "Category: artificial intelligence (AI)" ;
        "Article: We’ve been listening: MATLAB R2025a Prerelease update 5 now available" ;
        "Category: New Releases" ;
        "Now classify this new content" ;
        content;
        "Category: "];
    prompt = strjoin(prompt, newline);
    category = bot(prompt);
end
```

### 4.3 Summarization with Chain-of-Thought Prompting

This function first asks the LLM to list key points and then to generate a final summary:

```matlab
function summary = summarize_article(content)
    keyPointsPrompt = [
        "You are an AI assistant that summarizes technical articles. Read the article below and think through " ;
        "the main points step by step before writing the final summary.";
        "Article:";
        content;
        "First, outline the key points and main ideas of the article.";
        "Then, write a concise summary incorporating these points.";
        "Key Points:"];
    keyPointsPrompt = strjoin(keyPointsPrompt, newline);
    keyPoints = bot(keyPointsPrompt);
    
    summaryPrompt = [
        "Using the key points below, write a concise summary of the article.";
        "Key Points:";
        keyPoints;
        "Summary:"];
    summaryPrompt = strjoin(summaryPrompt, newline);
    summary = bot(summaryPrompt);
end
```

---

## 5. Processing a Batch of Bookmarks

Imagine you have a MATLAB array called `bookmarks`containing URLs. The following script loops over each bookmark to extract content, format it, classify it, and summarize it:

```matlab

bookmarks = ["https://blogs.mathworks.com/matlab/2025/03/20/weve-been-listening-matlab-r2025a-prerelease-update-5-now-available";
        "https://blogs.mathworks.com/matlab/2025/02/04/how-to-run-local-deepseek-models-and-use-them-with-matlab";
        "https://blogs.mathworks.com/matlab/2024/10/02/4-ways-of-using-matlab-with-large-language-models-llms-such-as-chatgpt-and-ollama";
        "https://blogs.mathworks.com/matlab/2024/09/26/matlab-now-has-over-1000-functions-that-just-work-on-nvidia-gpus"];

processedArticles = struct('title', {}, 'category', {}, 'summary', {});
for i = 1:numel(bookmarks)
    % Extract current bookmark info
    bookmark = bookmarks(i);
    
    % Replace these "extract", "format", etc. with real implementations
    [title, content] = extractContent(bookmark);
    formattedContent = formatContent(title, content);
    category         = classifyArticle(formattedContent);
    summary          = summarizeArticle(formattedContent);

    % Populate a struct with the processed results
    articleData.title    = title
    articleData.category = category
    articleData.summary  = summary

    % Append to the results array
    processedArticles(end+1) = articleData;
end
```

---

## 6. Working Around Context Length

### 6.1 A Simple Token Approximation

For splitting long texts into chunks, we can define a simple token counter. (Here we assume roughly 1 token ≈ 4 characters.)

```matlab
function n= simpleTokenCounter(str)
    % Approximate token count: 1 token per 4 characters
    n = ceil(length(char(str)) / 4);
end
```

For more precision, use the `tiktoken` Python package that can be called from MATLAB.
```python
import tiktoken
def num_tokens(string: str) -> int:
    """Returns the number of tokens in a text string."""
    encoding_name = 'o200k_base' # encoder for gpt-4o and 4o-mini
    encoding = tiktoken.get_encoding(encoding_name)
    num_tokens = len(encoding.encode(string))
    return num_tokens
```

### 6.2 Map-Reduce Summarization

This approach splits a long document into smaller chunks, summarizes each chunk, and then combines the summaries:

```matlab
function [finalSummary, chunkSummaries] = mapReduceSummarize(text, chunkSize)
    if nargin < 2, chunkSize = 1000; end
    
    % Split text into words and group them into chunks based on token count.
    words = split(string(text));
    currentChunk = "";
    chunks = strings(0,1);  % Initialize as an empty string array
    
    for i = 1:length(words)
        numTokens = py.utils.tokenization.num_tokens(currentChunk + " " + words(i));
        % Estimate tokens when appending the next word.
        if double(numTokens) < chunkSize
            currentChunk = currentChunk + " " + words(i);
        else
            chunks(end+1) = strtrim(currentChunk);  % Append to string array
            currentChunk = words(i);
        end
    end
    if currentChunk ~= ""
        chunks(end+1) = strtrim(currentChunk);
    end
    
    % Summarize each chunk using a string array for summaries.
    chunkSummaries = strings(size(chunks));  % Preallocate as a string array
    for i = 1:length(chunks)
        prompt = ["Summarize the following text:", ...
                  chunks(i), ...
                  "Summary:"];
        prompt = strjoin(prompt, newline);
        [chunkSummaries(i), ~] = bot(prompt); 
        % Display each step of the Mapping process
        disp(chunkSummaries(i))
    end
    
    % Combine the chunk summaries into a final summary.
    combinedText = strjoin(chunkSummaries, newline);
    finalPrompt = ["Combine the following summaries into a coherent final summary:", ...
                  combinedText, ...
                  "Final Summary:"];
    finalPrompt = strjoin(finalPrompt, newline);
    [finalSummary, ~] = bot(finalPrompt);
end
```

### 6.3 Sequential Refinement

The refine method sequentially updates a summary based on each new text chunk:

```matlab
function refinedSummary = refineSummarize(text, chunkSize) 
    if nargin < 2, chunkSize = 1000; end
    
    % Split the text into chunks (using a simple word-based splitter)
    words = split(text);
    currentChunk = "";
    chunks = strings(0,1);  % Initialize as an empty string array
    for i = 1:length(words)
        numTokens = py.utils.tokenization.num_tokens(currentChunk + " " + words(i));
        if double(numTokens) < chunkSize
            currentChunk = currentChunk + " " + words(i);
        else
            chunks(end+1) = strtrim(currentChunk);
            currentChunk = words(i);
        end
    end
    if currentChunk ~= ""
        chunks(end+1) = strtrim(currentChunk);
    end
    
    % Start with a summary of the first chunk
    prompt = ["Summarize the following text:";
               chunks(1);
              "Summary:"];
    prompt = strjoin(prompt, newline);
    [refinedSummary, ~] = bot(prompt);
    
    % Refine the summary with each subsequent chunk
    for i = 2:length(chunks)
        refinedPrompt = ["Refine the following summary with this additional context:";
            "Context:";
            chunks(i);
            "Existing Summary:";
            refinedSummary;
            "Refined Summary:"];
        refinedPrompt = strjoin(refinedPrompt, newline);
        [refinedSummary, ~] = bot(refinedPrompt);
    end
end
```

---

## Conclusion

You can now use web scraping, string manipulation, and the provided LLM interface in MATLAB to build robust applications for:
- Content extraction and formatting,
- Translation and classification,
- Summarization (using chaining methods),
- And processing large batches of documents.

This approach leverages state-of-the-art LLM techniques in your applications for natural language processing.