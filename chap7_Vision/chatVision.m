function response = chatVision(prompt, imagePath, timeOut)
%CHATVISION Summary of this function goes here
%   Takes a prompt and an image (either path on disk or url)
%   Returns a response to the prompt (can be an explanation of the image)
arguments (Input)
    prompt (1, :) string
    imagePath (1, :) string
    timeOut double {mustBePositive} = 30
end

arguments (Output)
    response (1, :) string
end
    chat = openAIChat(ModelName="gpt-4o-mini");
    messages = messageHistory;
    messages = addUserMessageWithImages(messages,prompt, imagePath);
    response = generate(chat, messages, TimeOut=timeOut);
end