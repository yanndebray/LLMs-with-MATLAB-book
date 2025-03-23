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
