%% Translate Articles

content = readlines("how-to-run-local-deepseek-models-and-use-them-with-matlab.md");
content = strjoin(content, newline);
translation = translate_article(content, "French")
fid = fopen('traduction.md', 'w'); 
fprintf(fid, '%s', translation); 
fclose(fid);

function translation = translate_article(content, language)
    % This function translates the given content into the specified language.
    % Default to English if no language specified
    if nargin < 2
        language = "English";
    end
    prompt = [...
        "Translate the following article to " + language ...
        content ...
        "Translation:"];
    prompt = strjoin(prompt, newline);
    translation = bot(prompt);
end