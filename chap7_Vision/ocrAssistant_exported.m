classdef ocrAssistant_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        OCRAssistantUIFigure  matlab.ui.Figure
        GridLayout            matlab.ui.container.GridLayout
        HTML                  matlab.ui.control.HTML
        PerformOpticalCharacterRecognitionLabel  matlab.ui.control.Label
        PasteanimagefromclipboardButton  matlab.ui.control.Button
        TextArea              matlab.ui.control.TextArea
        OCRAssistantLabel     matlab.ui.control.Label
        Image                 matlab.ui.control.Image
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            addpath preface
            setup;
            if isempty(getenv("OPENAI_API_KEY"))
                disp("Store your OPENAI_API_KEY key in a .env file and restart the app.")
            end
        end

        % Button pushed function: PasteanimagefromclipboardButton
        function PasteanimagefromclipboardButtonPushed(app, event)
            ts = char(datetime('now','Format','yyyyMMdd_HHmmssSSS'));
            printscreenPath = fullfile(tempdir,['printscreen_' ts '.png']);
            imclipboard('paste',printscreenPath)
            app.Image.ImageSource = printscreenPath;
            app.TextArea.Value = chatVision("Extract the text from the image, return only the text.",printscreenPath);
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Get the file path for locating images
            pathToMLAPP = fileparts(mfilename('fullpath'));

            % Create OCRAssistantUIFigure and hide until all components are created
            app.OCRAssistantUIFigure = uifigure('Visible', 'off');
            app.OCRAssistantUIFigure.Position = [100 100 640 480];
            app.OCRAssistantUIFigure.Name = 'OCR Assistant';
            app.OCRAssistantUIFigure.Icon = fullfile(pathToMLAPP, 'eyes.png');

            % Create GridLayout
            app.GridLayout = uigridlayout(app.OCRAssistantUIFigure);
            app.GridLayout.ColumnWidth = {'1x', '1x', '1x'};
            app.GridLayout.RowHeight = {'1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x'};

            % Create Image
            app.Image = uiimage(app.GridLayout);
            app.Image.Layout.Row = [1 4];
            app.Image.Layout.Column = [2 3];

            % Create OCRAssistantLabel
            app.OCRAssistantLabel = uilabel(app.GridLayout);
            app.OCRAssistantLabel.HorizontalAlignment = 'center';
            app.OCRAssistantLabel.FontWeight = 'bold';
            app.OCRAssistantLabel.Layout.Row = 1;
            app.OCRAssistantLabel.Layout.Column = 1;
            app.OCRAssistantLabel.Text = 'OCR Assistant 👀';

            % Create TextArea
            app.TextArea = uitextarea(app.GridLayout);
            app.TextArea.Layout.Row = [5 8];
            app.TextArea.Layout.Column = [2 3];

            % Create PasteanimagefromclipboardButton
            app.PasteanimagefromclipboardButton = uibutton(app.GridLayout, 'push');
            app.PasteanimagefromclipboardButton.ButtonPushedFcn = createCallbackFcn(app, @PasteanimagefromclipboardButtonPushed, true);
            app.PasteanimagefromclipboardButton.Layout.Row = 3;
            app.PasteanimagefromclipboardButton.Layout.Column = 1;
            app.PasteanimagefromclipboardButton.Text = 'Paste an image from clipboard';

            % Create PerformOpticalCharacterRecognitionLabel
            app.PerformOpticalCharacterRecognitionLabel = uilabel(app.GridLayout);
            app.PerformOpticalCharacterRecognitionLabel.HorizontalAlignment = 'center';
            app.PerformOpticalCharacterRecognitionLabel.FontSize = 10;
            app.PerformOpticalCharacterRecognitionLabel.Layout.Row = 2;
            app.PerformOpticalCharacterRecognitionLabel.Layout.Column = 1;
            app.PerformOpticalCharacterRecognitionLabel.Text = 'Perform Optical Character Recognition';

            % Create HTML
            app.HTML = uihtml(app.GridLayout);
            app.HTML.HTMLSource = '<p style="font-family: Helvetica, Arial, sans-serif; font-size: 8pt;">Requires <a href="https://www.mathworks.com/matlabcentral/fileexchange/28708-imclipboard">imclipboard</a></p>';
            app.HTML.Layout.Row = 8;
            app.HTML.Layout.Column = 1;

            % Show the figure after all components are created
            app.OCRAssistantUIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = ocrAssistant_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.OCRAssistantUIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.OCRAssistantUIFigure)
        end
    end
end