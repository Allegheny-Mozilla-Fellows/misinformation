# Some code bits were taken from https://www.youtube.com/watch?v=l37n_HDD1qs

# Installing the rvest and stringr package
install.packages('rvest')
install.packages("stringr")
install.packages("quanteda")
install.packages("spacyr")

# Loading some useful packages
library('rvest')
library('readtext')
library('stringr')
library('spacyr')
library('purrr')
library('robotstxt')
library('xml2')
library('dplyr')
library(quanteda)

# Check if we can scrape from this site, if TRUE we can, if FALSE we can't
paths_allowed(
  paths = c("insert url here")
)

# Specifying the url for desired website to be scraped
# All NYT url's seem to work so far
# url <- 'https://www.nytimes.com/2020/06/15/nyregion/nyc-affordable-housing-lottery.html'
# url <- 'https://www.nytimes.com/2020/06/15/us/gay-transgender-workers-supreme-court.html'
# url <- 'https://www.nytimes.com/2020/06/15/opinion/lgbt-supreme-court-ruling.html?action=click&module=Opinion&pgtype=Homepage'
# url <- 'https://www.nytimes.com/2020/06/15/us/politics/supreme-court-lgbtq-rights.html?action=click&module=Top%20Stories&pgtype=Homepage'
# url <- 'https://www.nytimes.com/2020/06/15/magazine/parenting-black-teens.html?action=click&module=Top%20Stories&pgtype=Homepage'
# url <- 'https://www.nytimes.com/2020/06/15/technology/coronavirus-disinformation-russia-iowa-caucus.html'
# url <- 'https://www.nytimes.com/2020/06/03/health/coronavirus-contact-tracing-apps.html'


# Reading the HTML code from the website
NYTwebpage <- read_html(url)

# Pull text from the html and separate each paragraph, or separate each paragraph by each word
NYTwebpage %>%
  html_nodes(".css-53u6y8 p") %>%
  html_text() %>% # -> paragraphs
  str_split(' ') # -> paragraphs_separated_by_word

# Turn 'paragraphs' and '(paragraphs_separated_by_word' into list objects
paragraph_list <- setNames(as.list(paragraphs), paste0("p", seq_along(paragraphs)))
psw_list <- setNames(as.list(paragraphs_separated_by_word), paste0("p", seq_along(paragraphs_separated_by_word)))

# useful for selecting words of specific POS, only works on 'paragraph_list' since it's not tokenized

# SELECT NOUN FUNCTION
selectNoun <- function(num_of_nouns, string_to_parse){
  nouns <- spacy_parse(string_to_parse, pos = TRUE) %>%
    as.tokens(include_pos = "pos") %>%
    tokens_select(pattern = c("*/NOUN"))
  nouns <- str_split(nouns, "   ")
  return(sample(nouns, num_of_nouns))
}


# SELECT PROPER NOUN FUNCTION
selectProperNoun <- function(num_of_prnouns, string_to_parse){
  proper_nouns <- spacy_parse(string_to_parse, pos = TRUE) %>%
    as.tokens(include_pos = "pos") %>%
    tokens_select(pattern = c("*/PROPN"))
  proper_nouns <- str_split(proper_nouns, "   ")
  return(sample(proper_nouns, num_of_prnouns))
}

# SELECT ADJECTIVE FUNCTION
selectAdj <- function(num_of_adjs, string_to_parse){
  adjs <- spacy_parse(string_to_parse, pos = TRUE) %>%
    as.tokens(include_pos = "pos") %>%
    tokens_select(pattern = c("*/ADJ"))
  adjs <- str_split(adjs, "   ")
  return(sample(adjs, num_of_adjs))
}

# SELECT VERB FUNCTION
selectVerb <- function(num_of_verbs, string_to_parse){
  verbs <- spacy_parse(string_to_parse, pos = TRUE) %>%
    as.tokens(include_pos = "pos") %>%
    tokens_select(pattern = c("*/VERB"))
  verbs <- str_split(verbs, "   ")
  return(sample(verbs, num_of_verbs))
}

# SELECT ADVERB FUNCTION
selectAdverbs <- function(num_of_adverbs, string_to_parse){
  adverbs <- spacy_parse(string_to_parse, pos = TRUE) %>%
    as.tokens(include_pos = "pos") %>%
    tokens_select(pattern = c("*/ADV"))
  adverbs <- str_split(adverbs, "   ")
  return(sample(adverbs, num_of_adverbs))
}

# SELECT NUMBER FUNCTION 
selectNumber <- function(num_of_numbers, string_to_parse){
  numbers <- spacy_parse(string_to_parse, pos = TRUE) %>%
    as.tokens(include_pos = "pos") %>%
    tokens_select(pattern = c("*/NUM"))
  numbers <- str_split(numbers, "   ")
  return(sample(numbers, num_of_numbers))
}

# SELECT ADPOSITION FUNCTION
selectAdpo <- function(num_of_adpos, string_to_parse){
  adpos <- spacy_parse(string_to_parse, pos = TRUE) %>%
    as.tokens(include_pos = "pos") %>%
    tokens_select(pattern = c("*/ADP"))
  adpos <- str_split(adpos, "   ")
  return(sample(adpos, num_of_adpos))
}


# Steps from here: 1) Take in the total number of iterations from the shiny app widget, and evenly divide those among 
# the total number of paragraphs in the article? Or make it top heavy like OBC mentioned, putting the majority of the
# changes towards the beginning of the article. 2) Begin writing the algorithm that will randomly decide what types
# of words to change (as in parts of speech) using the methods written above. 3) Find a library of words of the same
# parts of speech, check Spacyr again, but I believe that feature may only be in Spacy. 3) Figure out how to pull in
# a new word of the same parts of speech from that library and then replace the randomly selected word with the new one.

for (p in psw_list){
 spacy_parse(sample(p, 1), pos = TRUE, tag = TRUE)
    # code that randomly selects same POS word
}

# Replacing words in either paragraphs_list or psw_list: how to? Maybe write a function
random_psw <- setNames(sample(psw_list), paste0("p", seq_along(psw_list))) # randomly reorders and renames 'psw_list'
selectNoun(2, random_psw$p1)
# found this randomWords() function from the OpenRepGrid package but you need to download a specific package outside
# of R which probably isn't super viable.

# reading in massive csv of words
# randomWordData <- read.csv(file = '/Users/dcasey/Desktop/Summer2020/misinformation/data/randomWords.csv', sep = ',')
# randomWordData <- setNames(as.list(randomWordData), paste0("p", seq_along(randomWordData)))
# rwDataList <- as.list(randomWordData)
# rwDataChar <- as.character(rwDataList)
#     seq_along(rwDataList)
# spacy_parse(rwDataList)

# Trying to use rcorpora


