
<a id="TMP_6c3f"></a>

# Chap 5 \- OpenAI functions

Test my function

```matlab
res = getCurrentWeather("New York");
jsondecode(res)
```

```matlabTextOutput
ans = struct with fields:
       location: 'New York'
    temperature: '72'
           unit: 'fahrenheit'
       forecast: {2x1 cell}

```

```matlab
res = getCurrentWeather("Paris","celsius");
jsondecode(res)
```

```matlabTextOutput
ans = struct with fields:
       location: 'Paris'
    temperature: '72'
           unit: 'celsius'
       forecast: {2x1 cell}

```


Equip the weather agent with the right function to call

```matlab
% Step 0: Setup the agent equipped with his one tool, the weather function
f = openAIFunction("getCurrentWeather","Get the current weather in a given location");
f = addParameter(f,"location", type="string", description="Name of a city");
f = addParameter(f,"unit", type="string", enum=["celsius" "fahrenheit"], description="Unit for the temperature");
agent = openAIChat("You are a helpful weather agent", Tools=f) 
```

```matlabTextOutput
agent = 
  openAIChat with properties:

           ModelName: "gpt-4o-mini"
         Temperature: 1
                TopP: 1
       StopSequences: [0x0 string]
             TimeOut: 10
        SystemPrompt: {[1x1 struct]}
      ResponseFormat: "text"
     PresencePenalty: 0
    FrequencyPenalty: 0
       FunctionNames: "getCurrentWeather"

```

```matlab
% Step 1: send the conversation to the agent
prompt = "What is the weather in Boston?";
messages = messageHistory;
messages = addUserMessage(messages, prompt);
[~,completeOutput] = agent.generate(messages)
```

```matlabTextOutput
completeOutput = struct with fields:
           role: 'assistant'
        content: []
     tool_calls: [1x1 struct]
        refusal: []
    annotations: []

```

```matlab
messages = addResponseMessage(messages,completeOutput);
```

```matlab
% Step 2: Check if the agent wants to call a function
if isfield(completeOutput, 'tool_calls') && isstruct(completeOutput.tool_calls)
    % Extract the tool call details and execute the function call
    toolCallID = string(completeOutput.tool_calls.id);
    functionCalled = string(completeOutput.tool_calls.function.name);
    args = jsondecode(toolCall.arguments);
    location = args.location;
    unit = args.unit;
    if functionCalled == "getCurrentWeather"
        weatherData = getCurrentWeather(location, unit)
        messages = addToolMessage(messages,toolCallID,functionCalled,weatherData)
    end
end
```

```matlabTextOutput
weatherData = '{"location":"Boston","temperature":"72","unit":"celsius","forecast":["sunny","windy"]}'
messages = 
  messageHistory with properties:

    Messages: {[1x1 struct]  [1x1 struct]  [1x1 struct]}

```

```matlab
% Step 3: Format the response
generatedText = agent.generate(messages)
```

```matlabTextOutput
generatedText = "The current weather in Boston is 72°C, which seems unusually high. The forecast indicates it is sunny and windy. Would you like me to check something else?"
```

<a id="TMP_01fa"></a>

## Functions
```matlab
function jason = getCurrentWeather(location, unit)
% getCurrentWeather Get the current weather in a given location.
% Example:
%   jason = getCurrentWeather('New York');
%   jason = getCurrentWeather('Paris', 'celsius');

    if nargin < 2
        unit = 'fahrenheit';
    end

    weatherInfo = struct();
    weatherInfo.location = location;
    weatherInfo.temperature = '72';
    weatherInfo.unit = unit;
    weatherInfo.forecast = {'sunny', 'windy'};

    jason = jsonencode(weatherInfo);
end
```
## Resources

[https://github.com/matlab\-deep\-learning/llms\-with\-matlab/blob/main/doc/functions/openAIFunction.md](https://github.com/matlab-deep-learning/llms-with-matlab/blob/main/doc/functions/openAIFunction.md)

