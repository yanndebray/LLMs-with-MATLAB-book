function dailytechtask
    % Parse Techcrunch RSS Feed
    url = "https://techcrunch.com/feed";
    dt = datetime('now','Format','yyyy-MM-dd');
    dateStr = string(dt);
    episode = "tech_" + dateStr;

    % Get the RSS channel
    channel = rssFeed(url, episode, dateStr);

    % Extract all <item> nodes in the channel
    items = channel.getElementsByTagName('item');
    numItems = items.getLength();

    % Loop through each item, scrape the article
    for i = 0:(numItems-1)
        itemNode = items.item(i);
        [title, link, textData] = scrapeArticle(itemNode, episode);
        % Optionally display progress
        fprintf('Scraped: %s\n', title);
        fprintf('Link: %s\n',link);
    end
end

function channel = rssFeed(url, episode, dateStr)
    % Get the RSS data from the feed URL as text
    response = webread(url);  % returns a character vector

    % Save the entire RSS feed to a file
    rssFolder = fullfile("podcast", episode, "rss");
    if ~exist(rssFolder, 'dir')
        mkdir(rssFolder);
    end

    rssFile = fullfile(rssFolder, "techcrunch_" + dateStr + ".xml");
    fid = fopen(rssFile, 'w');
    fwrite(fid, response);
    fclose(fid);

    % Get the <channel> element
    doc = xmlread(rssFile);  % Parse the file as XML Document Object
    channel = doc.getElementsByTagName('channel').item(0);
end

function [title, link, textData] = scrapeArticle(itemNode, episode)
    % Extract title text from <title> node
    title = char(itemNode.getElementsByTagName('title').item(0).getFirstChild.getData());
    % Replace forbidden characters with '-'
    title = regexprep(title, '[<>:"/\\|?*]', '-');

    % Extract link text from <link> node
    link = char(itemNode.getElementsByTagName('link').item(0).getFirstChild.getData());

    % Fetch HTML of the article
    html = webread(link);

    % In MATLAB R2021b or later, you can parse HTML with htmlTree
    tree = htmlTree(html);

    % Find elements whose class="entry-content"
    entryContent = findElement(tree, '.entry-content');

    if ~isempty(entryContent)
        % Extract readable text
        textData = extractHTMLText(entryContent(1));
    else
        textData = ''; % fallback if no match
    end

    % Save text content
    textFolder = fullfile("podcast", episode, "text");
    if ~exist(textFolder, 'dir')
        mkdir(textFolder);
    end
    textFile = fullfile(textFolder, title + ".txt");

    fid = fopen(textFile, 'w', 'n', 'UTF-8');
    fwrite(fid, textData, 'char');
    fclose(fid);
end