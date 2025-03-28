% Set up the query
query = "MATLAB";
% URL encode the query string to handle special characters and spaces
query = urlencode(query);
% Construct the base URL for the DuckDuckGo API
url = "https://api.duckduckgo.com/?format=json&q="+query;
% Make the API request
options = weboptions('ContentType', 'json');
response = webread(url, options);

% Display the response title and abstract
disp("Heading: " + response.Heading)
disp("Abstract: " + response.Abstract)