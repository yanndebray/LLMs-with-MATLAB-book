
<a id="TMP_6afa"></a>

# AI agents with MATLAB and Python

Learn AI agents using MATLAB and Python


Inspired from [programming\-GPTs](https://github.com/yanndebray/programming-GPTs)


This repo has been developed with MATLAB 24b and Python 3.10.


The code can be executed in MATLAB Online and MATLAB Desktop.


Some parts leverage other dev environments like VSCode and Jupyter. 

<!-- Begin Toc -->

## Table of Contents
&emsp;&emsp;[Setup](#TMP_8b14)
 
&emsp;&emsp;[Chap 1 \- LLMs with MATLAB and Python](#TMP_97ba)
 
&emsp;&emsp;[Chap 2 \- Build your own MatGPT](#TMP_6b40)
 
&emsp;&emsp;[Utils](#TMP_26e3)
 
<!-- End Toc -->
<a id="TMP_8b14"></a>

## Setup
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
addpath(genpath("llms-with-matlab\"))
```
<a id="TMP_97ba"></a>

## Chap 1 \- LLMs with MATLAB and Python

[matlab\-deep\-learning/llms\-with\-matlab: Connect MATLAB to LLM APIs, including OpenAI® Chat Completions, Azure® OpenAI Services, and Ollama™](https://github.com/matlab-deep-learning/llms-with-matlab)


Make your first query in MATLAB, same in Python

```matlab
edit chap1_LLMs_with_MATLAB_and_Python\chap1_first_query.m
edit chap1_LLMs_with_MATLAB_and_Python\chap1_first_query.py
```

Learn to manage messages history

```matlab
edit chap1_LLMs_with_MATLAB_and_Python\chap1_messages_history.mlx
```
<a id="TMP_6b40"></a>

## Chap 2 \- Build your own MatGPT

[toshiakit/MatGPT: MATLAB app to access ChatGPT API from OpenAI](https://github.com/toshiakit/MatGPT)


![image_0.png](README_media/image_0.png)


<a id="TMP_26e3"></a>

## Utils
```matlab
export README.mlx README.md
```
