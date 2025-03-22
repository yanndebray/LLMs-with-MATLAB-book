%% Extracting Content from a URL
addpath("utils");

url = "https://blogs.mathworks.com/matlab/2025/02/04/how-to-run-local-deepseek-models-and-use-them-with-matlab";
% This function extracts the title and content from a given URL.
[title, content] = extractContent(url);
% Format the content using a custom function
formatted_content = formatContent(title, content)

% Extract the last part of the URL as filename
urlParts = strsplit(url, '/');
filename = urlParts{end};
outputFile = filename + ".md";

% Write title and content to the file
fid = fopen(outputFile, 'w');
fprintf(fid, '%s', formatted_content);
fclose(fid);