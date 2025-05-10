function [text, response] = bot(prompt, temperature)
    % Set defaults if not provided
    if nargin < 2, temperature = 0; end
    
    % Load environment settings (if needed)
    loadenv("../.env");
    
    % Define the model name (as in our chap1 example)
    modelName = "gpt-4o-mini";
    chat = openAIChat("You are a MATLAB expert.", ...
            "ModelName", modelName, ...
            "Temperature", temperature, ...
            "TimeOut", 30 ...    
    );
    
    % Initialize message history and add the user prompt
    messages = messageHistory;
    messages = addUserMessage(messages, prompt);
    
    % Generate the response
    [text, response] = generate(chat, messages);
end