%% transformer models

%% 1) Add the transformer-models repo to the path
folderName = 'transformer-models';
repo = "https://github.com/matlab-deep-learning/"+folderName;
if ~isfolder(folderName)
    gitclone(repo);
else
    disp("The folder "+folderName+"/ already exists.");
end
addpath(genpath(folderName))

%% 2) Load pretrained GPT-2
mdl = gpt2();

%% 3) Summarize the preface
text = ["Language is a foundation for humanity. It is through language that we have elevated ourselves, from the silence of nature. First we existed, then our essence was granted by a Voice. We shared with one another. We started telling each other stories, sometimes simply relaying information, sometime making things up. We elaborated ideas, started reasoning about them, turning them into plans. A sound became words – letters, semantics, lexicons – words transformed into writings, writing into books, books into cultures, cultures into civilizations. Leading us all the way to the current digital age, with the inter-connected-net of articles, blogs, images, videos. All this content that started to feed machines, eager to learn.";
"Ever since the release of an apparently harmless chatbot application, we have observed an acceleration in the development of language modeling. Artificial intelligence has marked a new epoch in our relationship with language. These models, built on the crunching of numbers by the largest supercomputers in the world, have enabled computers to understand and generate human language with unprecedented accuracy. The next wave that is gradually taking the human away from the conversational loop is AI agents. Agents build on large language models, but they can act autonomously, by using tools and carrying out entire workflows without necessarily needing tight supervision from end-users, such as browsing the web to perform research and analysis, to return detailed reports.";
"This book is designed to equip you with the knowledge and skills needed to harness the power of agents, opening new horizons in the field of artificial intelligence. Whether you are a seasoned developer or a curious enthusiast, this practical guide will help you navigate the complexities of building AI agents, transforming your ideas into reality."];
text = strjoin(txt,newline);
generateSummary(mdl, text)
