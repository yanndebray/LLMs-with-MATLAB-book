%% transformer models

%% 1) Add the transformer-models repo to the path
folderName = 'transformer-models';
repo = "https://github.com/matlab-deep-learning/"+folderName;
if ~isfolder(folderName)
    gitclone(repo);
else
    disp("The folder "+folderName+"/ already exists.");
end
addpath(genpath(folderName))

%% 2) Load pretrained GPT-2
% This will download weights automatically if not present
mdl    = gpt2();            
enc    = mdl.Tokenizer;     % tokenizer object
params = mdl.Parameters;    % network weights & hyperparams

%% 3) Set your prompt & sampling settings
prompt        = "A long time ago in a galaxy far";  % seed text
maxNewTokens  = 100;                 % number of tokens to generate
temperature   = 1.0;                 % higher -> more random
topK          = 40;                  % sample from top-K logits

%% 4) Tokenize and prime the model
inputTokens = enc.encode(prompt);
numLayers   = params.Hyperparameters.NumLayers;
pasts       = repmat({[]}, numLayers, 1);

if numel(inputTokens)>1
    % Run all but last token to initialize 'presents'
    [~, presents] = gpt2.model(inputTokens(1:end-1), pasts, params);
    prevToken = inputTokens(end);
else
    presents = pasts;
    prevToken = inputTokens;
end

%% 5) Autoregressive sampling loop
generated = "";

for i = 1:maxNewTokens
    [logits, presents] = gpt2.model(prevToken, presents, params);
    % apply temperature & top-K filtering
    logits = logits ./ temperature;
    logits = sampling.topKLogits(logits, topK);
    % convert to probabilities
    probs = softmax(logits, 'DataFormat','CTB');
    % sample next token ID
    nextID = sampling.sampleFromCategorical(extractdata(probs));
    % decode and append text
    generated = generated + enc.decode(nextID);
    prevToken = nextID;
end

%% 6) Display the full completed text
disp("=== Prompt ===")
disp(prompt)
disp("=== Completion ===")
disp(generated)