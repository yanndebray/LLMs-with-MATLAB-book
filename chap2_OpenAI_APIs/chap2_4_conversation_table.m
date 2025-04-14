% create a ui figure window
fig = uifigure(Name="My conversation table");
% set the figure size
fig.Position(end) = 150;
% add a 3x1 grid 
g = uigridlayout(fig,[3,1]);
g.RowHeight = {80,22,'1x'};
% add a table
uit = uitable(g); 
uit.Data = ["user","hello";"assistant","world"];
uit.ColumnName = ["Role","Content"];
uit.Layout.Row = 1;
% add an input field
ef = uieditfield(g,Placeholder="Enter your message");
ef.Layout.Row = 2;