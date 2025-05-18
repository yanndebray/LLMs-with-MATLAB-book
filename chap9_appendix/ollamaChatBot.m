% Simple Ollama ChatBot calling remote server via ngrok
ollamaServer = "<your-tunnel>.ngrok-free.app";
chat = ollamaChat("llama3.2", EndPoint=ollamaServer);
messages = messageHistory;
stopWord = "end";
while true
    query = input("User: ", "s");
    query = string(query);
    % dispWrapped("User", query)
    if query == stopWord
        disp("AI: Closing the chat. Have a great day!")
        break;
    end
    messages = addUserMessage(messages, query);
    [text, response] = generate(chat, messages);
    
    dispWrapped("AI", text)
    messages = addResponseMessage(messages, response);
end

function dispWrapped(prefix, text)
    indent = [newline, repmat(' ',1,strlength(prefix)+2)];
    text = strtrim(text);
    disp(prefix + ": " + join(textwrap(text, 70),indent))
end