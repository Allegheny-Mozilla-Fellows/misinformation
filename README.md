# Misinformation

##### What is this?
A repository for activities to teach misinformation issues

##### GitHub link
git@github.com:Allegheny-Mozilla-Fellows/misinformation.git

## MisInfoBot Tutorial and it's Real-World Application

With the reliance on social media as a source of news and for nearly all information we consume, it has become very easy for misinformation to spread. In fact, misinformation spreads just as easily as correct information and telling the difference between the two is no longer straightforward. The source-checking and fact-checking duties have become the job of the reader rather than the writer, whether the information has already been fact-checked or not, and "fake news" has become the new normal. The purpose of this lab is to demonstrate how misinformation can spread computationally and how information becomes misinformation.

The MisInfoBot is an R script that reads in a New York Times Article and randomly changes a certain amount of words based on the user's input. It will write the newly changed article to a .txt file called 'new_article.txt'. The script essentially plays a game of telephone with itself, each 'iteration' acting as a news media outlet passing information to the next news media outlet, like CNN or Fox News coming out with a story before an instagram account hears about the story and creates a post about it.

If the CNN or Fox News story contains incorrect information, then the instagram account will likely publish that incorrect information along with the correct information without fact-checking it. How are they to know the story is incorrect? After all, the instagram account is not legally obligated to make sure they're publishing pinpoint accurate news, they're just looking for likes and clicks. This cycle can continue until the message of the story has been completely distorted, and the misinformation can completely permeate the news sphere, hence, the game of telephone.

## Using MisInfoBot

You can clone the repository by running the following command:

```bash
git clone git@github.com:Allegheny-Mozilla-Fellows/misinformation.git
```

Open MisInfoBot.R in RStudio and install and load the following packages:

- [Devtools](https://www.r-project.org/nosvn/pandoc/devtools.html) is a package that provides many R functions that simplify many common tasks. Follow the steps in the link provided to make sure you have the latest version of devtools installed.

- [Spacyr](https://cran.r-project.org/web/packages/spacyr/spacyr.pdf) is an R wrapper to the 'Python' 'spaCy' 'NLP' library, from <http://spacy.io>. It is is a library for language processing and is used for some text mining  manipulations. Before installing Spacyr, make sure to have the miniconda installed(https://docs.conda.io/en/latest/miniconda.html). It can be installed with the following commands:

 ``` bash
 install.packages("spacyr")
 spacy_install() # only use this command once, otherwise it drastically slows down performance
 ```

- [Rvest](https://blog.rstudio.com/2014/11/24/rvest-easy-web-scraping-with-r/) is a package used for scraping data from html webpages. It can be installed with the following command:

 ``` bash
 install.packages("rvest")
 ```

- [Rcorpora](https://cran.r-project.org/web/packages/rcorpora/index.html) is a collection of small text corpora of interesting data such as names, foods, geography, and parts of speech. It can be installed with the following command:

 ``` bash
 install.packages("rcorpora")
 ```

- [Stringr](https://stringr.tidyverse.org/) Built on top of stringi and part of the [tidyverse](https://www.tidyverse.org/), stringr provides correct implementations of common string manipulations. It can be installed with the following command:

 ``` bash
 install.packages("stringe")
 ```

- [Radlibs](https://cran.r-project.org/web/packages/radlibs/radlibs.pdf) is a package used to help build your own Madlibs, containing some funny and interesting keywords. It can be installed with the following command:

 ``` bash
 install.packages("radlibs")
 ```

- [QDapDictionaries](https://cran.r-project.org/web/packages/qdapDictionaries/index.html) is a collection of text analysis dictionaries and word lists for use with the 'qdap' package. It can be installed with the following command:

 ``` bash
 install.packages("qdapdictionaries")
 ```

There are two main variables that are to be changed within the code:

 ``` bash
iterations <- 15
 ```
 and:

 ``` bash
 url <- "enter url here"
 ```

`iterations` decides how many changes are to be made in the article, and `url` is the article that the MisInfoBot is manipulating and MUST be a New York Times article. You can then run the entirety of the code, the newly manipulated article will be written to `new_article.txt` and the original, unedited article will be written to `old_article.txt`. You can choose any amount of changes, whether 5 changes or 500, but the more changes that are to be made the longer it will take the code to run; if you make too many changes, for example over 1,000, RStudio may crash and you would have to restart, so try to avoid making too many.

There are two functions that need to be declared, the first being `readNYTLinkToParagraphs`, which reads and scrapes text from the chosen New York Times Article in one specific format:

```
readNYTLinkToParagraphs <- function(url){
  NYTwebpage <- read_html(url)
  NYTwebpage %>%
    html_nodes(".css-53u6y8 p") %>%
    html_text() -> paragraphs
  setNames(as.list(paragraphs), paste0("p", seq_along(paragraphs))) -> paragraphs
  return(paragraphs)
}
```

As well as `readNYTLinkToPSW`, which reads and scrapes text from the chosen New York Times Article in another specific format:

```
readNYTLinkToPSW <- function(url){
  NYTwebpage <- read_html(url)
  NYTwebpage %>%
    html_nodes(".css-53u6y8 p") %>%
    html_text() %>%
    str_split(' ') -> paragraphs_separated_by_word
  setNames(as.list(paragraphs_separated_by_word), paste0("p", seq_along(paragraphs_separated_by_word))) -> paragraphs_separated_by_word
  return(paragraphs_separated_by_word)
```

If you have declared the necessary variables and functions and would like to see the results, then copy and paste the rest of the code and run it in the console. You may then compare the two articles. If you are a student and are ready to start doing some analysis, head down to the "Student Discussion and Reflection Questions" section.

### Classroom Demonstration Code

You can also run the code on a smaller sample size for demonstration purposes using the MisInfoBot_demo.R file found in the MisInfoBot directory. This allows you to easily demonstrate the changes being made in a classroom setting, rather than making 15 changes on a 20 paragraph article and having to read the entire thing.

The only two bits of code you can manually change are `iterations`, which serves the same function as it does in MisInfoBot, and `demo_list`, which replaces the `url` variable from MisInfoBot and currently holds a 16 line Robert Frost poem, "The ROad Not Taken". You may change what `demo_list` holds but make sure it is in the correct list structure, where each line is surrounded by quotations and separated by a comma.

The final last two lines of code write the original and manipulated articles to .txt files, each respectively named `old_article_demo` and `new_article_demo`. Place both side by side and you'll notice how much clearer the changes are.

## Student Discussion and Reflection Questions

Before running the code, keep in mind the real-world application of the code and answer the following questions in about a short paragraph:

1. How many times is a new story likely to be recycled? What type of information is likely to be changed, whether through honest mistakes from reporters or intentionally?


Now, make sure you DO NOT read the article that your professor has given to you before making changes to it. After declaring the variables, declare two functions that follow; these functions handle the parsing of the article. You can now copy and paste the rest of the code and run it in the console. This may take some time, depending on how fast your computer is as well as how many changes are being made. Read the newly mutated article and answer the second question in blue.

2. Read the newly mutated article (the one given to you) and answer the following questions in a lengthy paragraph: What is the message of the new article? How often are you left confused by words, sentences, or even an entire paragraph? Now read the original article and answer the exact same questions for both the mutated and original article, as well as generally comparing and contrasting them:


Now that you've done some analysis on an article given to you, you're going to do some analysis on a New York Times article of your choosing. Make sure the article is about a topic you are very familiar with, whether a sports article about LeBron James' high school career, a tech article about the specs for the new MacBook, or an article on the newest Quentin Tarantino movie. However, do not yet read this article. You are going to follow the same process as you did for the article given to you. You will first choose the amount of changes you want to make using the 'iterations' variable, but consider the length of the article this time; how many changes would make the mutations far too obvious? For example, if the article is only five paragraphs long then 100 changes might be too obvious. Since it is an article about a topic you already know well, try and trick yourself. Maybe start with a low number of changes, say 2-6 for each paragraph (meaning anywhere from 10 to 35 changes in a 5 paragraph article) and working up from there. Now read the newly mutated article and answer the third question in blue. Then, read the original article and answer the fourth question in blue.

3. Read the newly mutated article (the one you gave chosen) and answer the following questions in a lengthy paragraph: How false does this article seem to you, given that you have knowledge of it's topic already? What kinds of changes are obvious to you? What is the message of this new article, and how does that message differ from what you were expecting it to be?



4. Read the original article and pay careful attention to the differences between it and the mutated article. Then answer the following questions in a lengthy paragraph: What major changes, if there were any, immediately stuck out to you and what kinds of changes were they? Would a reader with zero background knowledge notice the changes that were made? Why or why not? What are the ethical implications of the changes made in the article?



`iterations` decides how many changes are to be made in the article, and `url` is the article that the MisInfoBot is manipulating and MUST be a New York Times article. You can then run the entirety of the code, the newly manipulated article will be written to `new_article.txt` and the original, unedited article will be written to `old_article.txt`. You can now begin comparing the new article with the old article side by side, .txt file next to New York Times article and begin thinking about the 'Questions in Blue' and how to help students consider these questions.
