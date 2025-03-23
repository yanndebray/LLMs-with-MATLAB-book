
# Setup
<a name="beginToc"></a>

## Table of Contents
&emsp;&emsp;[LLM with MATLAB](#llm-with-matlab)
 
&emsp;&emsp;[Python packages in MATLAB Online](#python-packages-in-matlab-online)
 
&emsp;&emsp;[OpenAI API key](#openai-api-key)
 
<a name="endToc"></a>

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
addpath(genpath("llms-with-matlab\"))
```

## Python packages in MATLAB Online

Some sections of the book require Python packages to complement MATLAB capabilities.


Get pip to install packages in your MATLAB Online session:

```matlab
websave("/tmp/get-pip.py","https://bootstrap.pypa.io/get-pip.py");
!python /tmp/get-pip.py
```

```matlabTextOutput
Defaulting to user installation because normal site-packages is not writeable
Collecting pip
  Using cached pip-25.0.1-py3-none-any.whl.metadata (3.7 kB)
Using cached pip-25.0.1-py3-none-any.whl (1.8 MB)
Installing collected packages: pip
  Attempting uninstall: pip
    Found existing installation: pip 25.0.1
    Uninstalling pip-25.0.1:
      Successfully uninstalled pip-25.0.1
□[33m  WARNING: The scripts pip, pip3 and pip3.10 are installed in '/home/matlab/.local/bin' which is not on PATH.
  Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location.□[0m□[33m
□[0mSuccessfully installed pip-25.0.1
```

```matlab
!python -m pip --version
```

```matlabTextOutput
pip 25.0.1 from /home/matlab/.local/lib/python3.10/site-packages/pip (python 3.10)
```

```matlab
!python -m pip install -r requirements.txt
```

```matlabTextOutput
Defaulting to user installation because normal site-packages is not writeable
Collecting python-dotenv (from -r requirements.txt (line 1))
  Downloading python_dotenv-1.0.1-py3-none-any.whl.metadata (23 kB)
Collecting openai (from -r requirements.txt (line 2))
  Downloading openai-1.68.2-py3-none-any.whl.metadata (25 kB)
Collecting youtube-transcript-api (from -r requirements.txt (line 3))
  Downloading youtube_transcript_api-1.0.2-py3-none-any.whl.metadata (23 kB)
Collecting anyio<5,>=3.5.0 (from openai->-r requirements.txt (line 2))
  Downloading anyio-4.9.0-py3-none-any.whl.metadata (4.7 kB)
Requirement already satisfied: distro<2,>=1.7.0 in /usr/lib/python3/dist-packages (from openai->-r requirements.txt (line 2)) (1.9.0)
Collecting httpx<1,>=0.23.0 (from openai->-r requirements.txt (line 2))
  Downloading httpx-0.28.1-py3-none-any.whl.metadata (7.1 kB)
Collecting jiter<1,>=0.4.0 (from openai->-r requirements.txt (line 2))
  Downloading jiter-0.9.0-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (5.2 kB)
Collecting pydantic<3,>=1.9.0 (from openai->-r requirements.txt (line 2))
  Downloading pydantic-2.10.6-py3-none-any.whl.metadata (30 kB)
Collecting sniffio (from openai->-r requirements.txt (line 2))
  Downloading sniffio-1.3.1-py3-none-any.whl.metadata (3.9 kB)
Collecting tqdm>4 (from openai->-r requirements.txt (line 2))
  Downloading tqdm-4.67.1-py3-none-any.whl.metadata (57 kB)
Collecting typing-extensions<5,>=4.11 (from openai->-r requirements.txt (line 2))
  Downloading typing_extensions-4.12.2-py3-none-any.whl.metadata (3.0 kB)
Collecting defusedxml<0.8.0,>=0.7.1 (from youtube-transcript-api->-r requirements.txt (line 3))
  Downloading defusedxml-0.7.1-py2.py3-none-any.whl.metadata (32 kB)
Requirement already satisfied: requests in /usr/lib/python3/dist-packages (from youtube-transcript-api->-r requirements.txt (line 3)) (2.31.0)
Collecting exceptiongroup>=1.0.2 (from anyio<5,>=3.5.0->openai->-r requirements.txt (line 2))
  Downloading exceptiongroup-1.2.2-py3-none-any.whl.metadata (6.6 kB)
Requirement already satisfied: idna>=2.8 in /usr/lib/python3/dist-packages (from anyio<5,>=3.5.0->openai->-r requirements.txt (line 2)) (3.6)
Requirement already satisfied: certifi in /usr/lib/python3/dist-packages (from httpx<1,>=0.23.0->openai->-r requirements.txt (line 2)) (2023.11.17)
Collecting httpcore==1.* (from httpx<1,>=0.23.0->openai->-r requirements.txt (line 2))
  Downloading httpcore-1.0.7-py3-none-any.whl.metadata (21 kB)
Collecting h11<0.15,>=0.13 (from httpcore==1.*->httpx<1,>=0.23.0->openai->-r requirements.txt (line 2))
  Downloading h11-0.14.0-py3-none-any.whl.metadata (8.2 kB)
Collecting annotated-types>=0.6.0 (from pydantic<3,>=1.9.0->openai->-r requirements.txt (line 2))
  Downloading annotated_types-0.7.0-py3-none-any.whl.metadata (15 kB)
Collecting pydantic-core==2.27.2 (from pydantic<3,>=1.9.0->openai->-r requirements.txt (line 2))
  Downloading pydantic_core-2.27.2-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (6.6 kB)
Downloading python_dotenv-1.0.1-py3-none-any.whl (19 kB)
Downloading openai-1.68.2-py3-none-any.whl (606 kB)
□[?25l   □[90m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━□[0m □[32m0.0/606.1 kB□[0m □[31m?□[0m eta □[36m-:--:--□[0m
□[2K   □[90m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━□[0m □[32m606.1/606.1 kB□[0m □[31m68.3 MB/s□[0m eta □[36m0:00:00□[0m
□[?25hDownloading youtube_transcript_api-1.0.2-py3-none-any.whl (1.9 MB)
□[?25l   □[90m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━□[0m □[32m0.0/1.9 MB□[0m □[31m?□[0m eta □[36m-:--:--□[0m
□[2K   □[90m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━□[0m □[32m1.9/1.9 MB□[0m □[31m169.8 MB/s□[0m eta □[36m0:00:00□[0m
□[?25hDownloading anyio-4.9.0-py3-none-any.whl (100 kB)
Downloading defusedxml-0.7.1-py2.py3-none-any.whl (25 kB)
Downloading httpx-0.28.1-py3-none-any.whl (73 kB)
Downloading httpcore-1.0.7-py3-none-any.whl (78 kB)
Downloading jiter-0.9.0-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (352 kB)
Downloading pydantic-2.10.6-py3-none-any.whl (431 kB)
Downloading pydantic_core-2.27.2-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (2.0 MB)
□[?25l   □[90m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━□[0m □[32m0.0/2.0 MB□[0m □[31m?□[0m eta □[36m-:--:--□[0m
□[2K   □[90m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━□[0m □[32m2.0/2.0 MB□[0m □[31m175.5 MB/s□[0m eta □[36m0:00:00□[0m
□[?25hDownloading sniffio-1.3.1-py3-none-any.whl (10 kB)
Downloading tqdm-4.67.1-py3-none-any.whl (78 kB)
Downloading typing_extensions-4.12.2-py3-none-any.whl (37 kB)
Downloading annotated_types-0.7.0-py3-none-any.whl (13 kB)
Downloading exceptiongroup-1.2.2-py3-none-any.whl (16 kB)
Downloading h11-0.14.0-py3-none-any.whl (58 kB)
Installing collected packages: typing-extensions, tqdm, sniffio, python-dotenv, jiter, h11, exceptiongroup, defusedxml, annotated-types, youtube-transcript-api, pydantic-core, httpcore, anyio, pydantic, httpx, openai
□[33m  WARNING: The script tqdm is installed in '/home/matlab/.local/bin' which is not on PATH.
  Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location.□[0m□[33m
□[0m□[33m  WARNING: The script dotenv is installed in '/home/matlab/.local/bin' which is not on PATH.
  Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location.□[0m□[33m
□[0m□[33m  WARNING: The script youtube_transcript_api is installed in '/home/matlab/.local/bin' which is not on PATH.
  Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location.□[0m□[33m
□[0m□[33m  WARNING: The script httpx is installed in '/home/matlab/.local/bin' which is not on PATH.
  Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location.□[0m□[33m
□[0m□[33m  WARNING: The script openai is installed in '/home/matlab/.local/bin' which is not on PATH.
  Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location.□[0m□[33m
□[0mSuccessfully installed annotated-types-0.7.0 anyio-4.9.0 defusedxml-0.7.1 exceptiongroup-1.2.2 h11-0.14.0 httpcore-1.0.7 httpx-0.28.1 jiter-0.9.0 openai-1.68.2 pydantic-2.10.6 pydantic-core-2.27.2 python-dotenv-1.0.1 sniffio-1.3.1 tqdm-4.67.1 typing-extensions-4.12.2 youtube-transcript-api-1.0.2
```

## OpenAI API key

Save your API key in a file named `.env`

```matlab
loadenv('.env')
OPENAI_API_KEY = getenv("OPENAI_API_KEY");
```
