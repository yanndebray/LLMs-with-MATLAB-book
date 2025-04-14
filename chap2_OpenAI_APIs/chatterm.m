modelName = "gpt-4o-mini";
chat = openAIChat("You are a MATLAB expert.",ModelName=modelName);
messages = messageHistory;
stopWord = "end";
while true
    query = input("User: ", "s");
    query = string(query);
    if query == stopWord
        disp("AI: Closing the chat. Have a great day!")
        break;
    end
    messages = addUserMessage(messages, query);
    [text, response] = generate(chat, messages);
    disp("AI: " + text)
    messages = addResponseMessage(messages, response);
end