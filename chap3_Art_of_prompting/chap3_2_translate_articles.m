%% Translate Articles
addpath("utils");
content = readlines("how-to-run-local-deepseek-models-and-use-them-with-matlab.md");
content = strjoin(content, newline);
translation = translateArticle(content, "French")
fid = fopen('traduction.md', 'w'); 
fprintf(fid, '%s', translation); 
fclose(fid);