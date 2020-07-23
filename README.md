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
 
 `iterations` decides how many changes are to be made in the article, and `url` is the article that the MisInfoBot is manipulating.
 
