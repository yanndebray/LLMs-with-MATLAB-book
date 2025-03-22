%% Summarizing Articles
addpath("utils");
content = readlines("how-to-run-local-deepseek-models-and-use-them-with-matlab.md");
content = strjoin(content, newline);
summary = summarizeArticle(content)