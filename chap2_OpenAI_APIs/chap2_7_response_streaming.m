%% Chatbot with Streaming

% Initialize the UI figure and set its UserData property to the conversation object
initialHeight = 420; initialWidth = 610;
fig = uifigure(Name="Chatbot with Streaming",Icon="bot.png");
fig.Position = [100 100 initialWidth initialHeight]; 
fig.UserData = openAIMessages;  % openAIMessages returns the initial conversation structure

% Create a grid layout for the UI components (8 rows, 5 columns)
g = uigridlayout(fig);
g.RowHeight = {'1x', 22, 22, 22, '5x', 22, 22, 5};
g.ColumnWidth = {150, 100, 200, '1x', 100};

% Create the title label
ttl = uilabel(g, Text="Chatbot with Streaming 🤖");
ttl.FontSize = 24;
ttl.Layout.Row = 1;
ttl.Layout.Column = [1, 5];
ttl.HorizontalAlignment = "center";

% Create the uitable to display the conversation
uit = uitable(g);
uit.ColumnWidth = {100, '1x'};
uit.ColumnName = ["Role", "Content"];
uit.Layout.Row = [2, 6];
uit.Layout.Column = [2, 5];

% replace the dropdown
ddlabel = uilabel(g,Text="Select an OpenAI model");
ddlabel.Layout.Row = 2;
ddlabel.Layout.Column = 1;
dd = uidropdown(g,Items=["gpt-4o-mini","gpt-4o"]);
dd.Layout.Row = 3;
dd.Layout.Column = 1;

% add a listbox
lb = uilistbox(g);
list_history(lb);
lb.ValueChangedFcn = @(src,events) load_chat(lb,uit);
lb.Layout.Row = [5,7];
lb.Layout.Column = 1;

% Add the "Save Chat" button that uses the new save_chat function.
saveBtn = uibutton(g, Text="Save Chat");
saveBtn.ButtonPushedFcn = @(src, event) save_chat(lb, uit);
saveBtn.Layout.Row = 4;
saveBtn.Layout.Column = 1;

% Create the input field for entering chat messages
ef = uieditfield(g, Placeholder="Enter your message.");
ef.Layout.Row = 7;
ef.Layout.Column = [2, 4];

% replace dumb_chat with chat_stream
sendBtn = uibutton(g, Text="Send");
sendBtn.ButtonPushedFcn=@(src,events) chat_stream(dd,ef,uit);
sendBtn.Layout.Row = 7;
sendBtn.Layout.Column = 5;


%% Callback Functions

function save_chat(historyList, outputTable)
    % Retrieve the parent figure using ancestor
    fig = ancestor(historyList, "figure", "toplevel");
    convo = fig.UserData;
    if ~isempty(convo.Messages)
        % Create a new filename based on the files already present in the "chat" folder
        s = dir("chat");
        isMat = arrayfun(@(x) endsWith(x.name, ".mat"), s);
        filenames = arrayfun(@(x) string(x.name), s(isMat));
        if isempty(filenames)
            filename = "convo1";
        else
            filenames = extractBefore(filenames, ".mat");
            suffix = str2double(extractAfter(filenames, "convo"));
            filename = "convo" + (max(suffix) + 1);
        end
        historyfile = fullfile("chat", filename + ".mat");
        save(historyfile, "convo");
        % Update the history listbox with new conversation history filenames
        list_history(historyList);
    end
    % Reset the conversation stored in the figure's UserData and clear the table
    fig.UserData = openAIMessages;
    outputTable.Data = [];
end

function load_chat(listbox,outputField)
    historyfile = fullfile("chat", listbox.Value + ".mat");
    if isfile(historyfile)
        load(historyfile,"convo");
        fig = ancestor(outputField,"figure","toplevel");
        fig.UserData = convo;
        roles = cellfun(@(x) string(x.role), convo.Messages');
        contents = cellfun(@(x) string(x.content), convo.Messages');
        outputField.Data = [roles,contents];
    else
        outputField.Data = [];
    end
end

% list_history populates the dropdown list with the names of saved conversation files
function list_history(dropdown)
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
    dropdown.Items = items;
end

function chat_stream(dropdown,inputField,outputField)
    % modify this depending on which release you use
    client = openAIChat(ModelName=dropdown.Value, ... 				 
        ApiKey=getenv("OPENAI_API_KEY"), ...
        StreamFun=@(x) printStream(outputField,x)); 
    fig = ancestor(inputField,"figure","toplevel");
    convo = fig.UserData;
    prompt = string(inputField.Value);
    if isempty(outputField.Data)
        outputField.Data = ["user",prompt];
    else
        outputField.Data = [outputField.Data; "user",prompt];
    end
    convo = addUserMessage(convo,prompt);
    [txt,msgStruct,response] = generate(client,convo);
    convo = addResponseMessage(convo,msgStruct);

    if isfield(response.Body.Data,"error")
        error(response.Body.Data.error)
    else
        fig.UserData = convo;
        outputField.Data(end) = txt;
        inputField.Value = "";
    end
end

function printStream(h,x)
    data = string(h.Data);
    if strlength(x) == 0
        data = [data; "assistant",string(x)];
    else
        data(end) = data(end) + string(x);
    end
    h.Data = data;
    pause(0.1)
end
