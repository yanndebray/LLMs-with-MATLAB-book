function podcastgentask
    dt = datetime('now','Format','yyyy-MM-dd');
    dateStr = string(dt);
    episode = "tech_" + dateStr;
    listing = dir(fullfile("podcast",episode,"text","*.txt"));
    tbl = struct2table(listing);
    articles = string(tbl.name);
    audioFolder = fullfile("podcast", episode, "audio");
    if ~exist(audioFolder, 'dir')
        mkdir(audioFolder);
    end
    for article = articles(1:3)'
        disp(article)
        filePath = fullfile("podcast",episode,"text",article);
        txt =  fileread(filePath);
        numChar = length(txt);
        disp("Number of characters:")
        disp(numChar)
        if numChar > 4000
            disp("Summarizing...")
            txt = summarizeArticleForPodcast(txt);
            disp("New character count:")
            disp(length(txt))
        end
        response = pyrun( ...
            "import openai                             " + ...
            "; response = openai.audio.speech.create(" + ...
            "    model='tts-1',                        " + ...
            "    voice='alloy',                        " + ...
            "    input=text                            " + ...
            ")                                         " , ...
            "response", ...   % Python variable name you want back
            text=txt ...   % inject MATLAB var `txt` as Py var `text`
            );
            response.stream_to_file(fullfile("podcast",episode,"audio",replace(article,".txt",".mp3")))
    end
end

function summary = summarizeArticleForPodcast(content)
     summaryPrompt = [
            "Summarize the article in less than 4000 characters";
            content;
            ];
    summaryPrompt = strjoin(summaryPrompt, newline);
    [summary,~] = bot(summaryPrompt);
    summary = char(summary);
end

function [text, response] = bot(prompt, temperature)
    % Set defaults if not provided
    if nargin < 2, temperature = 0; end
    
    % Load environment settings (if needed)
    % loadenv("../.env");
    
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
    [text, response] = generate(chat, messages, ...
        MaxNumTokens=1000);
end