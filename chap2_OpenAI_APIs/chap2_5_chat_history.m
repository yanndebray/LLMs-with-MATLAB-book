% Chatbot with history

% Create the uifigure with minimal width.
initialHeight = 420; initialWidth = 610;
fig = uifigure(Name="Chatbot with history");
fig.Position = [100 100 initialWidth initialHeight]; 

% Add an 8x5 grid layout
g = uigridlayout(fig);
g.RowHeight = {'1x',22,22,22,'5x',22,22,5};
g.ColumnWidth = {150,100,200,'1x',100};

% Title label
ttl = uilabel(g, Text="Chatbot with history 🤖");
ttl.FontSize = 24;
ttl.Layout.Row = 1;
ttl.Layout.Column = [1,5];
ttl.HorizontalAlignment = "center";

% Table to show the conversation
uit = uitable(g);
uit.ColumnWidth = {100, '1x'};  
uit.ColumnName = ["Role", "Content"];
uit.Layout.Row = [2,6];
uit.Layout.Column = [2,5];

% Listbox for conversation history
lb = uilistbox(g);
list_history(lb);
lb.ValueChangedFcn = @(src,events) load_chat(lb,uit);
lb.Layout.Row = [5,7];
lb.Layout.Column = 1;

% Input field for messages
ef = uieditfield(g, Placeholder="Enter your message.");
ef.Layout.Row = 7;
ef.Layout.Column = [2,4];

% Send button for the chat (run button)
sendBtn = uibutton(g, Text="Send");
sendBtn.ButtonPushedFcn = @(src,event) dumb_chat(ef, lb, openAIMessages);
sendBtn.Layout.Row = 7;
sendBtn.Layout.Column = 5;

% --- Callback and Helper Functions ---

function chat(selection, inputField, outputField)
    systemPrompt = "If I say hello, say world";
    client = openAIChat(systemPrompt, ...
            "ApiKey", getSecret("OPENAI_API_KEY"), ... 
            "ModelName", selection.Value);
    prompt = string(inputField.Value);
    [txt, msgStruct, response] = generate(client, prompt);
    if isfield(response.Body.Data, "error")
        error(response.Body.Data.error)
    else
        outputField.Value = txt;
    end
end

function load_chat(listbox, outputField)
    historyfile = fullfile("chat", listbox.Value + ".mat");
    if isfile(historyfile)
        load(historyfile, "convo");
        roles = cellfun(@(x) string(x.role), convo.Messages');
        contents = cellfun(@(x) string(x.content), convo.Messages');
        outputField.Data = [roles, contents];
    else
        outputField.Data = [];
    end
end

function list_history(inputField)
    if isfolder("chat")
        s = dir("chat");
        isMat = arrayfun(@(x) endsWith(x.name, ".mat"), s);
        filenames = arrayfun(@(x) string(x.name), s(isMat));
    else
        mkdir("chat");
        filenames = [];
    end
    items = "Select a conversation";
    if ~isempty(filenames)
        filenames = extractBefore(filenames, ".mat");
        items = [items, filenames'];
    end
    inputField.Items = items;
end

function dumb_chat(inputField, listbox, convo)
    prompt = string(inputField.Value);
    convo = addUserMessage(convo, prompt);
    txt = "Hello world";
    msgStruct = struct("role", "assistant", "content", txt);
    convo = addResponseMessage(convo, msgStruct);
    save_chat(convo, "convo0");
    list_history(listbox);
end

function save_chat(convo, filename)
    historyfile = fullfile("chat", filename + ".mat");
    save(historyfile, "convo");
end
