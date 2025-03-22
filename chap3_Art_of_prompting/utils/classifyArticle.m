function category = classifyArticle(content)
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