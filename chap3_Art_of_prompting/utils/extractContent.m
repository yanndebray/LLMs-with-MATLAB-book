function [title, content] = extractContent(url)
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