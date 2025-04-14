% First query
addpath("preface"); setup;
modelName = "gpt-4o-mini";
model = openAIChat("You are a MATLAB expert.",ModelName=modelName);
model.generate("create code for a linear regression")