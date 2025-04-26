%% Setup
% 
% LLM with MATLAB

folderName = 'llms-with-matlab';
repo = "https://github.com/matlab-deep-learning/"+folderName;
if ~isfolder(folderName)
    gitclone(repo);
else
    disp("The folder "+folderName+"/ already exists.");
end
addpath(genpath(folderName))

% OpenAI API key
% Save your API key in a file named |.env|

loadenv('.env')
OPENAI_API_KEY = getenv("OPENAI_API_KEY");