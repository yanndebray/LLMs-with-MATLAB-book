%% Setup
% 
% LLM with MATLAB

folderName = 'llms-with-matlab';
if ~isfolder(folderName)
    gitclone("https://github.com/matlab-deep-learning/llms-with-matlab");
else
    disp('The folder already exists.');
end
addpath(genpath("llms-with-matlab"))

% OpenAI API key
% Save your API key in a file named |.env|

loadenv('.env')
OPENAI_API_KEY = getenv("OPENAI_API_KEY");