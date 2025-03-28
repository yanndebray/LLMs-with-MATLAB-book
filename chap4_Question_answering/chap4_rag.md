
<a id="TMP_57bb"></a>

# Chap 4 \- Retrieval Augmented Generation
<!-- Begin Toc -->

## Table of Contents
&emsp;&emsp;[Traditional Search](#TMP_31e8)
 
&emsp;&emsp;[Vector Search](#TMP_0025)
 
&emsp;&emsp;[Utils](#TMP_16e3)
 
&emsp;&emsp;[Resources](#TMP_52c9)
 
<!-- End Toc -->
<a id="TMP_31e8"></a>

## Traditional Search

DuckDuckGo can be used as a free search engine, as it provides an API that enables to parse the search results as JSON without API key (alternative exists based on Google and other search engines).


![image_0.png](./chap4_rag_media/image_0.png)


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
T = search(query)
```


| |title|href|body|
|:--:|:--:|:--:|:--:|
|1|"Parag Agrawal - Wikipedia"|"https://en.wikipedia.org/wiki/Parag_Agrawal"|"Agrawal held research internships at Microsoft Research and Yahoo! Research before joining Twitter as a software engineer in 2011. [16] In October 2017, Twitter announced the appointment of Agrawal as chief technology officer following the departure of Adam Messinger. [17] In December 2019, Twitter CEO Jack Dorsey announced that Agrawal would be in charge of Project Bluesky, an initiative to ..."|
|2|"Jack Dorsey - Wikipedia"|"https://en.wikipedia.org/wiki/Jack_Dorsey"|"Jack Patrick Dorsey (born November 19, 1976) [3] is an American businessperson, who is a co-founder of Twitter, Inc. and its CEO during 2007-2008 and 2015-2021, as well as co-founder, principal executive officer and chairman of Block, Inc. (developer of the Square financial services platform). He is also the founder of Bluesky.. As of December 2024, Forbes estimated his net worth to be \$5. ..."|
|3|"Twitter (X) CEO History: From Dorsey to Yaccarino"|"https://www.historyoasis.com/post/twitter-x-ceo-history"|"Dick Costolo successfully led Twitter as CEO through its IPO, where the young social platform when from a private company valued at \$3.7 billion to \$23 billion after it went public. However, after the IPO, the company struggled to grow its user base. The period was also filled with platform abuse issues and slow innovation. ‍ JACK DORSEY ..."|
|4|"A timeline of Twitter ownership as Elon Musk completes buyout - Metro"|"https://metro.co.uk/2022/10/28/who-owned-twitter-before-elon-musk-timeline-of-ownership-17655892/"|"Despite not being CEO of the company since 2021, Jack Dorsey still owns 2.4%of Twitter. How much did Elon Musk buy Twitter for? The purchase of Twitter is reported to have cost the Tesla founder a ..."|
|5|"Parag Agrawal went from Twitter engineer to CEO in just 10 years"|"https://www.cnbc.com/2021/11/30/parag-agrawal-went-from-twitter-engineer-to-ceo-in-just-10-years.html"|"Parag Agrawal, who has been Twitter's CTO since 2017, will take over as CEO immediately after Jack Dorsey's surprise resignation on Monday."|
|6|"Twitter co-founder Jack Dorsey steps down as chief executive - BBC"|"https://www.bbc.com/news/technology-59465747"|"Calls for his departure came in 2020 from Elliott management, an investment firm which owns a significant amount of Twitter's shares. The firm reportedly felt that a full-time chief executive with ..."|
|7|"Jack Dorsey Steps Down as Twitter CEO, Parag Agrawal Named New CEO"|"https://www.hollywoodreporter.com/business/digital/jack-dorsey-step-down-twitter-ceo-1235053816/"|"Twitter CEO Jack Dorsey to Step Down, Parag Agrawal Named Successor. Dorsey, who co-founded the social networking site, will remain on the company's board of directors through his current term ..."|
|8|"New Twitter CEO steps from behind the scenes to high profile"|"https://apnews.com/article/parag-agrawal-twitter-new-ceo-3e7e1c7c0c6d60777feae0b2bf8bd5a2"|"At the end of last year, the company had a workforce of 5,500. Agrawal previously worked at Microsoft, Yahoo and AT&T in research roles. At Twitter, he's worked on machine learning, revenue and consumer engineering and helping with audience growth. He studied at Stanford and the Indian Institute of Technology, Bombay."|
|9|"Acquisition of Twitter by Elon Musk - Wikipedia"|"https://en.wikipedia.org/wiki/Acquisition_of_Twitter_by_Elon_Musk"|"Musk began purchasing Twitter stock on January 31, 2022. [4] On April 4, he announced that he had acquired 9.2 percent of the company's shares totaling \$2.64 billion, [8] making him the company's largest shareholder. [9] Following the announcement, Twitter's stock experienced its largest intraday surge since the company's initial public offering (IPO) in 2013, rising by as much as 27 percent. [10]"|
|10|"19 years of Twitter: From 'Larry the bird' to an X, a timeline of how ..."|"https://economictimes.indiatimes.com/tech/technology/19-years-of-twitter-from-larry-the-bird-to-an-x-a-timeline-of-how-the-platform-has-evolved/articleshow/119298594.cms"|"2010: "Trending topics", the retweet option and the hashtag (#) debut. Twitter also adds "Promoted Tweets", marking the beginning of its advertising platform. 2012: By June, the platform surpasses 500 million users. 2013: Twitter goes public on the New York Stock Exchange with a valuation of \$31 billion. November 2016: The microblogging platform plays a major role in the US presidential ..."|


```matlab
writetable(T,"search_results.csv")
```

```matlab
for i = 1:3 %height(T)
    c = extractHTMLText(webread(T.href(i)));
    T.tokens(i) = tokenizedDocument(c);
end
```

Perform similarity search based on tokenized documents (also defined as sparse document embeddings)


[https://www.mathworks.com/help/textanalytics/ug/information\-retrieval\-with\-document\-embeddings.html](https://www.mathworks.com/help/textanalytics/ug/information-retrieval-with-document-embeddings.html) 

```matlab
embQuery = bm25Similarity(T.tokens, tokenizedDocument(query));
[embQuery, idx] = sort(embQuery, "descend");
T.title(idx(1))
```

```matlabTextOutput
ans = "Elon Musk confirms Twitter's new CEO is ad guru Linda Yaccarino from ..."
```

<a id="TMP_0025"></a>

## Vector Search

Let's use dense document embeddings to perform search over a vector space capturing the semantic meaning of sentences and documents.


![image_1.png](./chap4_rag_media/image_1.png)

```matlab
model = documentEmbedding(Model='all-MiniLM-L6-v2'); % or 'all-MiniLM-L12-v2'
T.embedding = model.embed(T.body);
```

```matlab
query_emb = model.embed(query);
simi = cosineSimilarity(query_emb,T.embedding)
```

```matlabTextOutput
simi = 1x10
    0.5906    0.6451    0.6690    0.5352    0.5161    0.5506    0.6698    0.4797    0.5592    0.5075

```

```matlab
[top, idx] = sort(simi,"descend");
T.title(idx(1:5))
```

```matlabTextOutput
ans = 5x1 string
"Jack Dorsey Steps Down as Twitter CEO, Parag Agrawal Named New…  
"Twitter (X) CEO History: From Dorsey to Yaccarino"               
"Jack Dorsey - Wikipedia"                                         
"Parag Agrawal - Wikipedia"                                       
"Acquisition of Twitter by Elon Musk - Wikipedia"                 

```

<a id="TMP_16e3"></a>

## Utils

Search based on DuckDuckGo

```matlab
function T = search(query)
    ddgs = py.duckduckgo_search.DDGS();
    res = ddgs.text(query);
    df = py.pandas.DataFrame(res);
    T = table(df);
end
```
<a id="TMP_52c9"></a>

## Resources

Retrieval Augmented Generation based on keyword search:


[https://github.com/matlab\-deep\-learning/llms\-with\-matlab/blob/main/examples/RetrievalAugmentedGenerationUsingChatGPTandMATLAB.md](https://github.com/matlab-deep-learning/llms-with-matlab/blob/main/examples/RetrievalAugmentedGenerationUsingChatGPTandMATLAB.md)

