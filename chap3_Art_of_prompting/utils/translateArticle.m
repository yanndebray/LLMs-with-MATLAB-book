function translation = translateArticle(content, language)
    % This function translates the given content into the specified language.
    % Default to English if no language specified
    if nargin < 2
        language = "English";
    end
    prompt = [
        "Translate the following article to " + language ;
        content ;
        "Translation:"];
    prompt = strjoin(prompt, newline);
    translation = bot(prompt);
end