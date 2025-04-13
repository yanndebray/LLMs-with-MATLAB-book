
<a id="T_0b93"></a>

# Setup
<!-- Begin Toc -->

## Table of Contents
&emsp;&emsp;[LLM with MATLAB](#H_131b)
 
&emsp;&emsp;[OpenAI API key](#H_418f)
 
<!-- End Toc -->
<a id="H_50f9"></a>
<a id="H_131b"></a>

## LLM with MATLAB
```matlab
folderName = 'llms-with-matlab';
if ~isfolder(folderName)
    gitclone("https://github.com/matlab-deep-learning/llms-with-matlab");
else
    disp('The folder already exists.');
end
```

```matlabTextOutput
The folder already exists.
```

```matlab
addpath(genpath("llms-with-matlab"))
```
<a id="H_418f"></a>

## OpenAI API key

Save your API key in a file named `.env`

```matlab
loadenv('.env')
OPENAI_API_KEY = getenv("OPENAI_API_KEY");
```
