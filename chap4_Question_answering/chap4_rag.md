
# Chap 4 \- Retrieval Augmented Generation
## Traditional Search

DuckDuckGo can be used as a free search engine, as it provides an API that enables to parse the search results as JSON without API key (alternative exists based on Google and other search engines).


![image_0.png](chap4_rag_media/image_0.png)


[https://duckduckgo.com/?q=matlab&ia=web](https://duckduckgo.com/?q=matlab&ia=web)


Here is an example of a similar query, but made this time to the DuckDuckGo API programmatically.

```matlab
% Set up the query
query = "what is MATLAB?";
% URL encode the query string to handle special characters and spaces
query = urlencode(query)
```

```matlabTextOutput
query = 'what+is+MATLAB%3F'
```

```matlab
% Construct the base URL for the DuckDuckGo API
url = "https://api.duckduckgo.com/?format=json&q="+query;
% Make the API request
options = weboptions('ContentType', 'json');
res = webread(url, options);

% Display the response title and abstract
disp("Heading: " + res.Heading)
```

```matlabTextOutput
Heading: MATLAB
```

```matlab
disp("Abstract: " + res.Abstract)
```

```matlabTextOutput
Abstract: MATLAB is a proprietary multi-paradigm programming language and numeric computing environment developed by MathWorks. MATLAB allows matrix manipulations, plotting of functions and data, implementation of algorithms, creation of user interfaces, and interfacing with programs written in other languages. Although MATLAB is intended primarily for numeric computing, an optional toolbox uses the MuPAD symbolic engine allowing access to symbolic computing abilities. An additional package, Simulink, adds graphical multi-domain simulation and model-based design for dynamic and embedded systems. As of 2020, MATLAB has more than four million users worldwide. They come from various backgrounds of engineering, science, and economics. As of 2017, more than 5000 global colleges and universities use MATLAB to support instruction and research.
```


Parse the first result.

```matlab
wiki = webread(res.AbstractURL);
context = extractHTMLText(wiki);
```

Use the context of the search result to provide a response.

```matlab
prompt = ["Based on the following context, answer the query:";
          "-------";
          "Context:";
           context;
          "-------";
          "Query:";
           query];
prompt = strjoin(prompt,newline);
model = openAIChat();
response = generate(model,prompt)
```

```matlabTextOutput
response = "MATLAB is a proprietary multi-paradigm programming language and numerical computing environment developed by MathWorks. The name "MATLAB" stands for "MATrix LABoratory," and it is designed primarily for numeric computation but can also facilitate matrix manipulations, plotting of functions and data, implementation of algorithms, and creating user interfaces. MATLAB supports various functionalities, including interfacing with programs written in other languages, and has optional toolboxes for symbolic computing and graphical multi-domain simulation through Simulink. It can run on multiple operating systems such as Windows, macOS, and Linux. MATLAB is widely used across various fields, including engineering, science, and economics."
```


This API only provides instant results, not full search.


For this, let's use the Python package `duckduckgo-search`

```matlab
query = "Who's the last CEO of twitter?";
search(query)
```


| |title|href|body|
|:--:|:--:|:--:|:--:|
|1|"Parag Agrawal - Wikipedia"|"https://en.wikipedia.org/wiki/Parag_Agrawal"|"Agrawal held research internships at Microsoft Research and Yahoo! Research before joining Twitter as a software engineer in 2011. [16] In October 2017, Twitter announced the appointment of Agrawal as chief technology officer following the departure of Adam Messinger. [17] In December 2019, Twitter CEO Jack Dorsey announced that Agrawal would be in charge of Project Bluesky, an initiative to ..."|
|2|"Twitter (X) CEO History: From Dorsey to Yaccarino"|"https://www.historyoasis.com/post/twitter-x-ceo-history"|"Dick Costolo successfully led Twitter as CEO through its IPO, where the young social platform when from a private company valued at \$3.7 billion to \$23 billion after it went public. However, after the IPO, the company struggled to grow its user base. The period was also filled with platform abuse issues and slow innovation. ‍ JACK DORSEY ..."|
|3|"Jack Dorsey - Wikipedia"|"https://en.wikipedia.org/wiki/Jack_Dorsey"|"Jack Patrick Dorsey (born November 19, 1976) [3] is an American businessperson, who is a co-founder of Twitter, Inc. and its CEO during 2007-2008 and 2015-2021, as well as co-founder, principal executive officer and chairman of Block, Inc. (developer of the Square financial services platform). He is also the founder of Bluesky.. As of December 2024, Forbes estimated his net worth to be \$5. ..."|
|4|"Elon Musk confirms Twitter's new CEO is ad guru Linda Yaccarino from ..."|"https://apnews.com/article/twitter-musk-new-ceo-a5df68e9a1e5f982368390c73aeabb50"|"Elon Musk has confirmed that the new CEO for Twitter, will be NBCUniversal's Linda Yaccarino, an executive with deep ties to the advertising industry. Musk said that Yaccarino "will focus primarily on business operations" while he plans to center on product design and new technology at the company, which is now called X Corp. Despite the shift in leadership, experts note that Musk is ..."|
|5|"A timeline of Twitter ownership as Elon Musk completes buyout - Metro"|"https://metro.co.uk/2022/10/28/who-owned-twitter-before-elon-musk-timeline-of-ownership-17655892/"|"Despite not being CEO of the company since 2021, Jack Dorsey still owns 2.4%of Twitter. How much did Elon Musk buy Twitter for? The purchase of Twitter is reported to have cost the Tesla founder a ..."|
|6|"Jack Dorsey steps down as Twitter CEO; Parag Agrawal succeeds him"|"https://www.npr.org/2021/11/29/1059756077/jack-dorsey-steps-down-as-twitter-ceo"|"Jack Dorsey is stepping down as CEO of Twitter, the social media company he co-founded in 2006. He will be replaced by Twitter's chief technology officer, Parag Agrawal, a 10-year veteran of the ..."|
|7|"Twitter under Elon Musk - Wikipedia"|"https://en.wikipedia.org/wiki/Twitter_under_Elon_Musk"|"Elon Musk initiated the acquisition of Twitter, Inc. on April 14, 2022, and completed it on October 28, 2022. [22] [23] His goal was to transform Twitter into X, an all-encompassing app inspired by WeChat. [24]By April, Musk had become Twitter's largest shareholder with a 9.2 percent stake and made an unsolicited \$44 billion offer on April 14, which Twitter's board initially resisted before ..."|
|8|"Parag Agrawal went from Twitter engineer to CEO in just 10 years"|"https://www.cnbc.com/2021/11/30/parag-agrawal-went-from-twitter-engineer-to-ceo-in-just-10-years.html"|"Parag Agrawal, who has been Twitter's CTO since 2017, will take over as CEO immediately after Jack Dorsey's surprise resignation on Monday."|
|9|"Twitter co-founder Jack Dorsey steps down as chief executive - BBC"|"https://www.bbc.com/news/technology-59465747"|"Calls for his departure came in 2020 from Elliott management, an investment firm which owns a significant amount of Twitter's shares. The firm reportedly felt that a full-time chief executive with ..."|
|10|"Jack Dorsey is stepping down as CEO of Twitter"|"https://www.cnn.com/2021/11/29/tech/jack-dorsey-twitter/index.html"|"Jack Dorsey, the cofounder and public face of Twitter, will step down from his role as CEO, effective immediately, the company announced Monday. Dorsey will remain a member of Twitter's board ..."|


```matlab
function T = search(query)
    ddgs = py.duckduckgo_search.DDGS();
    res = ddgs.text(query);
    df = py.pandas.DataFrame(res);
    T = table(df);
end
```
