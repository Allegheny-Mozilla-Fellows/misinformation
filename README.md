# Misinformation

##### What is this?
A repository for activities to teach misinformation issues

##### GitHub link
git@github.com:Allegheny-Mozilla-Fellows/misinformation.git

## Using MisInfoBot

You can clone the repository by running the following command:

```bash
git clone git@github.com:Allegheny-Mozilla-Fellows/misinformation.git
```

Open MisInfoBot.R in RStudio and install and load the following packages:
- [Spacyr](https://cran.r-project.org/web/packages/spacyr/spacyr.pdf) is an R wrapper to the 'Python' 'spaCy' 'NLP' library, from <http://spacy.io>. It is is a library for      language processing and is used for some text mining  manipulations. It can be installed with the following command:

 ``` bash
 install.packages("spacyr")
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
 
 `iterations` decides how many changes are to be made in the article, and `url` is the article that the MisInfoBot is manipulating and MUST be a New York Times article. You can then run the entirety of the code, the newly manipulated article will be written to `new_article.txt` in plain text.
 
 ### Classroom Demonstration Code
 
 You can also run the code on a smaller sample size for demonstration purposes using the code blocks that are commented out. This allows you to easily demonstrate the changes being made in a classroom setting, rather than making 15 changes on a 20 paragraph article and having to read the entire thing. The first portion to remove the comments from is `demo_list`, which  contains a Robert Frost poem called 'The Road Not Taken' by Robert Frost, as well as these lines which handle the maniuplation of the poem:
 ``` bash
 demo_list <- str_split(demo_list, " ")
 demo_list <- setNames(demo_list, paste0("p", seq_along(demo_list)))
 ```
 
 Make sure that when running the script you are not running the code before the `demo_list` block, besides `iterations` as it only pertains to reading New York Times Articles. Then make sure to find the for loop that is not commented out and proceed to comment it all out using command + shit + C. Then find the for loop that is commented out, and remove the comments using the same command. Then 
 
 


 
