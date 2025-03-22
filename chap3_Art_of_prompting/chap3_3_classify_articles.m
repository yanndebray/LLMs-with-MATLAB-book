%% Classifying Articles

options = weboptions('Timeout', 30);
html = webread("https://blogs.mathworks.com/matlab/2024/10/02/4-ways-of-using-matlab-with-large-language-models-llms-such-as-chatgpt-and-ollama/", options);
tree = htmlTree(html);
body = findElement(tree, 'body');
content = extractHTMLText(body);
category = classify_article(content)

% content = readlines("how-to-run-local-deepseek-models-and-use-them-with-matlab.md");
% content = strjoin(content, newline);
% category = classify_article(content)

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