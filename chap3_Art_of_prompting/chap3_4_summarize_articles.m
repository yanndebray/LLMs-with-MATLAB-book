%% Summarizing Articles

content = readlines("how-to-run-local-deepseek-models-and-use-them-with-matlab.md");
content = strjoin(content, newline);
summary = summarize_article(content)


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