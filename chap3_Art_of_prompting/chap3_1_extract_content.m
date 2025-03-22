%% Extracting Content from a URL

url = "https://blogs.mathworks.com/matlab/2025/02/04/how-to-run-local-deepseek-models-and-use-them-with-matlab";
% This function extracts the title and content from a given URL.
[title, content] = extract_content(url)

% Extract the last part of the URL as filename
urlParts = strsplit(url, '/');
filename = urlParts{end};
outputFile = filename + ".txt";

% Write title and content to the file
fid = fopen(outputFile, 'w');
fprintf(fid, "Title: %s\n\n", title);
fprintf(fid, "Content:\n%s", formatted_content);
fclose(fid);


function [title, content] = extract_content(url)
    try
        % Make a web call with a custom timeout of 30 seconds
        options = weboptions('Timeout', 30);
        html = webread(url,options);
        tree = htmlTree(html);
        
        % Get the title element text
        t = findElement(tree, 'title');
        if ~isempty(t)
            title = extractHTMLText(t.Children);
        else
            title = "No Title Found";
        end
        % Extract body from the HTML tree
        body = findElement(tree, 'body');
        if ~isempty(body)
            content = extractHTMLText(body);
        else
            error("No body found in the HTML.");
        end
        
    catch ME
        fprintf("Error fetching %s: %s\n", url, ME.message);
        title = "";
        content = "";
    end
end
