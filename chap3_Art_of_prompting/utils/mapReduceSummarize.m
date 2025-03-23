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