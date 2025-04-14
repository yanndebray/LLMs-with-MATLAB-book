% create a UI figure window
fig = uifigure(Name="Chatbot with model choice");
% add a 7x4 grid 
g = uigridlayout(fig);
g.RowHeight = {'1x',22,22,22,22,22,'1x'};
g.ColumnWidth = {150,300,50,'1x'};
% add a title
ttl = uilabel(g,Text="My first chatbot 🤖");
ttl.HorizontalAlignment = "center";
ttl.FontSize = 24;
ttl.Layout.Row = 1;
ttl.Layout.Column = [1,3];
% add an input field
eflabel = uilabel(g,Text="Enter your message");
eflabel.Layout.Row = 2;
eflabel.Layout.Column = 2;
ef = uieditfield(g);
ef.Layout.Row = 3;
ef.Layout.Column = [2,3];
ef.Value = "Hello";
% add an output field
oflabel = uilabel(g,Text="Response");
oflabel.Layout.Row = 5;
oflabel.Layout.Column = 2;
of = uieditfield(g);
of.Layout.Row = 6;
of.Layout.Column = [2,3];

% add a dropdown before the button
items = ["gpt-4o-mini","gpt-4o"];
dd = uidropdown(g,Items=items);
dd.Layout.Row = 2;
dd.Layout.Column = 1;

% update the callback input arguments
btn = uibutton(g,Text="Send") ;
btn.ButtonPushedFcn=@(src,event) chat(dd,ef,of);
btn.Layout.Row = 4;
btn.Layout.Column = 3;


% this function runs when the button is clicked
function chat(selection,inputField,outputField)
    systemPrompt = "If I say hello, say world";
    % modify this depending on which release you use
    client = openAIChat(systemPrompt, ...
            ApiKey=getSecret("OPENAI_API_KEY"), ... 
            ModelName=selection.Value);
    prompt = string(inputField.Value);
    [txt,msgStruct,response] = generate(client,prompt);
    if isfield(response.Body.Data,"error")
        error(response.Body.Data.error)
    else
        outputField.Value = txt;
    end
end