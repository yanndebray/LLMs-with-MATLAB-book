# Preface

"The proper study of man is anything but himself, and it is through the
study of language that we learn about our own nature." -- J.R.R.
Tolkien

Language is a foundation for humanity. It is through language that we
have elevated ourselves, from the silence of nature. First we existed,
then our essence was granted by a Voice. We shared with one another. We
started telling each other stories, sometimes simply relaying
information, sometime making things up. We elaborated ideas, started
reasoning about them, turning them into plans. A sound became words --
letters, semantics, lexicons -- words transformed into writings, writing
into books, books into cultures, cultures into civilizations. Leading us
all the way to the current digital age, with the inter-connected-net of
articles, blogs, images, videos. All this content that started to feed
machines, eager to learn.

Ever since the release of an apparently harmless chatbot application, we
have observed an acceleration in the development of language modeling.
Artificial intelligence has marked a new epoch in our relationship with
language. These models, built on the crunching of numbers by the largest
supercomputers in the world, have enabled computers to understand and
generate human language with unprecedented accuracy. OpenAI\'s
Generative Pre-trained Transformers are at the forefront of this
revolution, demonstrating the extraordinary potential of AI to augment
human capabilities.

This book is designed to equip you with the knowledge and skills needed
to harness the power of GPTs, opening new horizons in the field of
artificial intelligence. Whether you are a seasoned developer or a
curious enthusiast, this practical guide will help you navigate the
complexities of building AI agents, transforming your ideas into
reality.

## Who is this book for

Ever heard of FOMO (Fear Of Missing Out)? I'll try not to use FUD (Fear
Uncertainty and Doubt) to sell you on GPTs. I'll also try really hard
not to use other TLAs (Three Letter Acronyms) in this book. Ok, I guess
I'll use one mainly: GPT. Wondering what this means, and how it could be
relevant to your work? Then you might find what you need in this book.

I am assuming that you are *NOT an AI expert* (quite the opposite
actually). If you already have some notions of what machine learning
means, those might prove useful as we go deeper into describing what
Generative AI is and how it differs from the previous waves of AI.

You are probably *tech savvy*, with likely some background in scientific
or technical studies. Don't worry, I won't use gory mathematical
equations to explain the concepts manipulated in the book. Instead, I'll
use concrete example of simple applications you can develop and tailor
to your needs.

I'll assume some *basic programming skills*, but no necessary experience
with AI libraries like scikit-learn or pytorch. I would be good for you
to have some basics of numeric, with libraries like numpy and pandas.
Those should be easy to acquire. Overall you should have some appetite
for coding, as it will make this experience much more enjoyable and give
you a deeper understanding of the concepts.

## About the author

I graduated from college with a degree in mechanical engineering. Some
of the course that I really got into involved numerical analysis with
Maple and Mathematica. But it's only after my studies, that I started to
learn about data science and machine learning. This was 2013 and the
rise of online courses, so like many, I followed the Stanford course
from Andrew Ng on Coursera[^1].

I discovered myself a passion about technical computing, and joined a
French start-up called Scilab. They were spinning off from the French
research to build a consulting business around open-source software. It
ended up being an exciting but challenging journey, with some new cloud
products roll out and an acquisition a few years later. As I was
learning more about the ways of open-source, I encountered another
programming language, Python, that I fell in love with.

Then in the beginning of 2020, as the world was starting to lock down, I
got a call from a company in Boston to work on the famous software
MATLAB, the leader in technical computing. A few years later, here I am,
more passionate than ever about numeric and eager to learn about its new
forms, mostly called AI now. And the best way to learn is to teach. So,
buckle up, and let's go for the ride!

*Disclaimer*: I have used ChatGPT to help me write this book. But I
would argue that the person who does not leverage AI to do her work is
going to be left behind. Or said in a more politically correct tone:
"You won't be replaced by AI, but you'll be replaced by someone using
AI". To read more about the potential of AI as an assistant, I'd
recommend reading "Impromptu".[^2]

## Setting up the Programming Environment

Setting up an effective programming environment is crucial for working
with Generative Pre-trained Transformers (GPTs). This section will guide
you through the necessary tools, libraries, and hardware requirements,
followed by a step-by-step setup process.

### Initial Setup Guide

I'll take as assumption that you are running on a Windows machine.
Wherever there is a major difference in OS, I'll try to make sure that I
give explanations for the different platforms.

-   Use MATLAB Online

Throughout this book, we will use MATLAB Online[^3], which provides
MATLAB, Simulink, and other commonly used toolboxes in the web browser.
MATLAB Online is free for up to 20 hours a month without a license,
hence it is one of the most accessible options. You can use it without
the monthly cap if you have an existing commercial, academic, or home
license. You can also use the desktop version of MATLAB. If you are new
to MATLAB, create a MathWorks account to get access to MATLAB Online.

MATLAB Online always comes with the latest version of the MATLAB
language and development environment. At the time of this writing, I am
using 24b. MATLAB Online also provides a pre-installed version of Python
(3.10 compatible with MATLAB 24b). Here is a table of the versions of
Python compatible with MATLAB, should dyou choose to install everything
locally[^4]:


|**Release**      | **Python versions supported**                       |
|-----------------|-----------------------------------------------------|
|R2024b           | 3.9, 3.10, 3.11, 3.12                               |
|R2024a           | 3.9, 3.10, 3.11                                     |
|R2023b           | 3.9, 3.10, 3.11                                     |
|R2023a           | 3.8, 3.9, 3.10                                      |
|R2022b           | 2.7, 3.8, 3.9, 3.10                                 |
|R2022a           | 2.7, 3.8, 3.9                                       |


You can download Python from the official Python website[^5].

-   Install Python packages in MATLAB Online[^6]

In my book about MATLAB with Python, I go over a simple way to install
Python packages into MATLAB Online.

First you need to retrieve pip
```matlab
>> websave("get-pip.py","https://bootstrap.pypa.io/get-pip.py");

>> !python get-pip.py

>> !python -m pip \--version
```
```
pip 24.2 from /home/matlab/.local/lib/python3.10/site-packages/pip
(python 3.10)
```

You can now simply install a package like langchain and transformers as
such:
```matlab
>> !python -m pip install langchain transformers
```
*LangChain*[^7] is useful for chaining language model calls and building
complex applications. *Transformers*[^8] is a popular library for
working with open-source AI models. You will learn about those packages
later in the book, and how to invoke them from MATLAB.

Bear in mind that the MATLAB Online environment is ephemeral, and that
you will have to repeat this process each time you start a new session.

-   Install LLMs-with-MATLAB

Large Language Models (LLMs) with MATLAB[^9] (a.k.a. "LLMs with MATLAB")
is the official library provided by MathWorks for interacting with the
OpenAI APIs.

1.  Go to "Add-Ons" in the Home tab of MATLAB interface to open the
    Add-On Explorer.

2.  Search "Large Language Models (LLMs) with MATLAB".

3.  Click "Add" to install the package.


-   API Keys and Authentication (For OpenAI)

Obtain an API key from OpenAI by registering on their platform. Set up
authentication by adding your API key to your environment variables with
an .env file.

1.  Create a new file in the editor:

    `>> edit .env`

2.  Type *OPENAI_API_KEY=\<your key>* and save it as an .env file (the
    file won't appear by default in the file browser in MATLAB Online,
    but you can change this setting)

3.  Load your API key every time you start a new MATLAB session:

    `>> load(".env")`

4.  Retrieve your API key:

    `>> getenv("OPENAI_API_KEY")`


-   Test Installation

Verify your setup by running a small script to interact with the OpenAI
API.

```matlab
addpath("path/to/llms-with-matlab");
loadenv("path/to/.env");
client = openAIChat( \...
ApiKey=getenv("OPENAI_API_KEY"), \...
ModelName="gpt-4o-mini");
res = generate(client,"Say this is a test")
```
[^1]: <https://www.coursera.org/specializations/machine-learning-introduction>

[^2]: <https://www.impromptubook.com/>

[^3]: <https://www.mathworks.com/products/matlab-online.html>

[^4]: <https://www.mathworks.com/support/requirements/python-compatibility.html>

[^5]: [www.python.org](http://www.python.org)

[^6]: <https://github.com/yanndebray/matlab-with-python-book/blob/main/8_Resources.md>

[^7]: <https://www.langchain.com/>

[^8]: <https://huggingface.co/docs/transformers>

[^9]: <https://github.com/matlab-deep-learning/llms-with-matlab>
