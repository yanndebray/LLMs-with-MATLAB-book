% row-tokens (queries):    Attention   is    all    you   need
labelsY = {'Attention','is','all','you','need'};  

% column-tokens (keys):    Attention  est    tout    ce   dont   vous  avez  besoin
labelsX = {'Attention','est','tout','ce','dont','vous','avez','besoin'};

% attention weight matrix (5×8)
A = [ ...
  0.8, 0.1, 0,   0,   0,   0,   0,   0.1;  % how “Attention” attends
  0,   0.9, 0.2, 0,   0,   0,   0,   0;    % how “is” attends
  0,   0,   0.8, 0.2, 0,   0,   0,   0;    % how “all” attends
  0,   0,   0,   0,   0.2, 0.5, 0,   0;    % how “you” attends
  0,   0,   0,   0,   0,   0,   0.2, 0.6   % how “need” attends
];

% Using imagesc
figure
imagesc(A)                    %# plot the matrix as colored cells
axis equal tight              %# square cells, tight framing

% apply a nice colormap & colorbar
colormap(parula)              %# parula is MATLAB default; use viridis if installed
c = colorbar;
c.Label.String = 'Attention Weight';
c.Ticks = linspace(0,0.9,5);

% label the ticks
set(gca, ...
    'XTick', 1:numel(labelsX), ...
    'XTickLabel', labelsX, ...
    'XTickLabelRotation', 45, ...
    'YTick', 1:numel(labelsY), ...
    'YTickLabel', labelsY, ...
    'FontSize', 12);

% title('Attention Weights')
