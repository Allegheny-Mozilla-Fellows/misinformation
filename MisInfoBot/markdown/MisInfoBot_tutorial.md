##### Name:
##### Date:

##### The MisInfoBot

With the reliance on social media as a source of news and for nearly all information we consume, it has become very easy for misinformation to spread. In fact, misinformation spreads just as easily as correct information and telling the difference between the two is no longer straightforward. The source-checking and fact-checking duties have become the job of the reader rather than the writer, whether the information has already been fact-checked or not, and "fake news" has become the new normal. The purpose of this lab is to demonstrate how misinformation can spread computationally and how information becomes misinformation.

The MisInfoBot is an R script that reads in a New York Times Article and randomly changes a certain amount of words based on the user's input. It will write the newly changed article to a .txt file called 'new_article.txt'. The script essentially plays a game of telephone with itself, each 'iteration' acting as a news media outlet passing information to the next new media outlet, like CNN or Fox News coming out with a story before an instagram account hears about the story and creates a post about it. If the CNN or Fox News story contains incorrect information, then the instagram account will likely publish that incorrect information along with the correct information without fact-checking it. How are they to know the story is incorrect? After all, the instagram account is not legally obligated to make sure they're publishing pinpoint accurate news, they're just looking for likes and clicks. This cycle can continue until the message of the story has been completely distorted, and the misinformation can completely permeate the news sphere, hence, the game of telephone.

Make sure to install the necessary packages and load the necessary libraries before running the code. There are 2 user defined variables in the code, 'url' and 'iterations'; 'url' should be a link to New York Times article that is copy and pasted from the search bar and pasted in between the parentheses, and the 'iterations' variable is a number that determines how many changes will be made to the article. You can choose any amount of changes, whether 5 changes or 500, but the more changes that are to be made the longer it will take the code to run; if you make too many changes, for example over 1,000, RStudio may crash and you would have to restart, so try to avoid making too many.

There are certain lines of demonstration code that are commented out, these code bits are a smaller sample size list to make changes to, and a for loop that adheres to the demonstration list's naming standards. Feel free to experiment with this code before running it on an article, but it is not necessary.

Before running the code, keep in mind the real-world application of the code and answer the following questions in about a short paragraph: How many times is a new story likely to be recycled? What type of information is likely to be changed, whether through honest mistakes from reporters or intentionally?

Now, make sure you DO NOT read the article that your professor has given to you before making changes to it. Enter the URL for the article and the amount of changes you would like to make. After declaring the variables, you can copy and paste the entirety of the rest of the code and run it in the console. This may take some time, depending on how fast your computer is as well as how many changes are being made. Read the newly changed article and consider (do not answer them just yet) the following questions: What is the message of the new article? How often are you left confused by words, sentences, or even an entire paragraph? Now read the original article and answer the exact same questions for both the mutated and original article, as well as generally comparing and contrasting them in a lengthy paragraph (question #1).

Now that you've done some analysis on an article given to you, you're going to do some analysis on a New York Times article of your choosing. Make sure the article is about a topic you are very familiar with, whether a sports article about LeBron James' high school career, a tech article about the specs for the new MacBook, or an article on the newest Quentin Tarantino movie. However, do not yet read this article. You are going to follow the same process as you did for the article given to you. You will first choose the amount of changes you want to make using the 'iterations' variable, but consider the length of the article this time; how many changes would make the mutations far too obvious? For example, if the article is only five paragraphs long then 100 changes might be too obvious. Since it is an article about a topic you already know well, try and trick yourself. Maybe start with a low number of changes, say 2-6 for each paragraph (meaning anywhere from 10 to 35 changes in a 5 paragraph article) and working up from there. Read the newly mutated article and answer the following questions in a lengthy paragraph (question #2): how false does this article seem to you, given that you have knowledge of it's topic already? What kinds of changes are obvious to you? What is the message of this new article, and how does that message differ from what you were expecting it to be?

Now read the original article and pay careful attention to the differences between it and the mutated article. Then answer the following questions in a less lengthy paragraph: What major changes, if there were any, immediately stuck out to you and what kinds of changes were they? Would a reader with zero background knowledge notice the changes that were made? Why or why not? (question #3)

##### Analysis questions

1. First question:



2. Second question:



3. Third question: