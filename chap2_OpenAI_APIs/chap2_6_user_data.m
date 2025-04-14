%% Chatbot with User Data

% Initialize the UI figure and set its UserData property to the conversation object
initialHeight = 420; initialWidth = 605;
fig = uifigure(Name="Chatbot with UserData");
fig.Position = [100 100 initialWidth initialHeight]; 
fig.UserData = openAIMessages;  % openAIMessages returns the initial conversation structure

% Create a grid layout for the UI components (8 rows, 5 columns)
g = uigridlayout(fig);
g.RowHeight = {'1x', 22, 22, 22, '5x', 22, 22, 5};
g.ColumnWidth = {150, 100, 200, '1x', 100};

% Create the title label
ttl = uilabel(g, Text="Chatbot with UserData 🤖");
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

% Create the dropdown for conversation history
dd = uidropdown(g);
list_history(dd);
dd.ValueChangedFcn = @(src, event) load_chat(dd, uit);
dd.Layout.Row = 3;
dd.Layout.Column = 1;

% Add the "Save Chat" button that uses the new save_chat function.
% Note: here we pass the dropdown (for updating its Items) and the table (for clearing Data).
saveBtn = uibutton(g, Text="Save Chat");
saveBtn.ButtonPushedFcn = @(src, event) save_chat(dd, uit);
saveBtn.Layout.Row = 4;
saveBtn.Layout.Column = 1;

% Create the input field for entering chat messages
ef = uieditfield(g, Placeholder="Enter your message.");
ef.Layout.Row = 7;
ef.Layout.Column = [2, 4];

% Create the "Send" button and update its callback accordingly.
sendBtn = uibutton(g, Text="Send");
sendBtn.ButtonPushedFcn = @(src, event) dumb_chat(ef, uit);
sendBtn.Layout.Row = 7;
sendBtn.Layout.Column = 5;


%% Callback Functions

% Modified dumb_chat function to update the conversation stored in the figure's UserData.
function dumb_chat(inputField, outputTable)
    % Retrieve the parent figure using ancestor
    fig = ancestor(inputField, "figure", "toplevel");
    % Get the current conversation from the figure's UserData property
    convo = fig.UserData;
    prompt = string(inputField.Value);
    
    % Update the table: append the new user message
    if isempty(outputTable.Data)
        outputTable.Data = ["user", prompt];
    else
        outputTable.Data = [outputTable.Data; "user", prompt];
    end
    
    % Update the conversation structure with the user's message
    convo = addUserMessage(convo, prompt);
    
    % Generate a response (for now, this is hard-coded to "Hello world")
    txt = "Hello world";
    msgStruct = struct("role", "assistant", "content", txt);
    convo = addResponseMessage(convo, msgStruct);
    
    % Update the figure's UserData property with the new conversation
    fig.UserData = convo;
    
    % Append the assistant's message to the table
    outputTable.Data = [outputTable.Data; "assistant", txt];
    
    % Clear the input field after processing
    inputField.Value = "";
end

% Repurposed save_chat function (invoked by the "Save Chat" button)
% Here, 'dropdown' is used for updating the chat history list via list_history,
% and 'outputTable' is the conversation table that gets cleared.
function save_chat(dropdown, outputTable)
    % Retrieve the parent figure using ancestor
    fig = ancestor(dropdown, "figure", "toplevel");
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
        % Update the dropdown list with new conversation history filenames
        list_history(dropdown);
    end
    % Reset the conversation stored in the figure's UserData and clear the table
    fig.UserData = openAIMessages;
    outputTable.Data = [];
end

% load_chat loads a saved conversation from a file selected in the dropdown
function load_chat(dropdown, outputTable)
    historyfile = fullfile("chat", dropdown.Value + ".mat");
    if isfile(historyfile)
        load(historyfile, "convo");
        roles = cellfun(@(x) string(x.role), convo.Messages');
        contents = cellfun(@(x) string(x.content), convo.Messages');
        outputTable.Data = [roles, contents];
    else
        outputTable.Data = [];
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
