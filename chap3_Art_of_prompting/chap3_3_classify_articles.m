%% Classifying Articles
addpath("utils");
options = weboptions('Timeout', 30);
html = webread("https://blogs.mathworks.com/matlab/2024/10/02/4-ways-of-using-matlab-with-large-language-models-llms-such-as-chatgpt-and-ollama", options);
tree = htmlTree(html);
body = findElement(tree, 'body');
content = extractHTMLText(body);
category = classifyArticle(content)

% content = readlines("how-to-run-local-deepseek-models-and-use-them-with-matlab.md");
% content = strjoin(content, newline);
% category = classifyArticle(content)