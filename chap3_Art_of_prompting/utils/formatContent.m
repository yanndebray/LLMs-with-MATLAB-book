function formatted_content = formatContent(title, content)
        prompt = [
        "You are an expert text formatter and summarizer." ;
        "Here is an article:" ;
        "Title: " + title ;
        "Content:" ;
        content ;
        "Please format this scraped text into a clean, readable content."];
        prompt = strjoin(prompt, newline);
    % Call the bot function with the constructed prompt
    formatted_content = bot(prompt);
end