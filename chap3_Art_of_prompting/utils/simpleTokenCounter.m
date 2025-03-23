function n= simpleTokenCounter(str)
    % Approximate token count: 1 token per 4 characters
    n = ceil(length(char(str)) / 4);
end