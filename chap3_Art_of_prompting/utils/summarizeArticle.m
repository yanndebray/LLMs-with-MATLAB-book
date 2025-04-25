function summary = summarizeArticle(content)
    keyPointsPrompt = [
        "You are an AI assistant that summarizes technical articles.";
        "Read the article below and think through the main points step by step " ;
        "before writing the final summary.";
        "Article:";
        content;
        "First, outline the key points and main ideas of the article.";
        "Then, write a concise summary incorporating these points."];
    keyPointsPrompt = strjoin(keyPointsPrompt, newline);
    keyPoints = bot(keyPointsPrompt)
    
    summaryPrompt = [
        "Extract the summary only.";
        "Key Points + Summary:";
        keyPoints;
        "Summary:"];
    summaryPrompt = strjoin(summaryPrompt, newline);
    summary = bot(summaryPrompt);
end