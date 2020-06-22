# Some code bits were taken from https://www.youtube.com/watch?v=l37n_HDD1qs

# Installing the rvest and stringr package
install.packages('rvest')
install.packages("rcorpora")
install.packages("stringr")
install.packages("quanteda")
install.packages("spacyr")

# Loading some useful packages
library('rvest')
# library('readtext')
library('stringr')
library('spacyr')
library('purrr')
library('robotstxt')
library('xml2')
library('dplyr')
library('quanteda')
library('rcorpora')

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
  html_text() %>% # -> paragraphs # chr value
  str_split(' ') # -> paragraphs_separated_by_word # list

# Turn 'paragraphs' and '(paragraphs_separated_by_word' into list objects
paragraph_list <- setNames(as.list(paragraphs), paste0("p", seq_along(paragraphs)))
psw_list <- paragraphs_separated_by_word

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
# Might delete this, probably not necessary
selectAdpo <- function(num_of_adpos, string_to_parse){
  adpos <- spacy_parse(string_to_parse, pos = TRUE) %>%
    as.tokens(include_pos = "pos") %>%
    tokens_select(pattern = c("*/ADP"))
  adpos <- str_split(adpos, "   ")
  return(sample(adpos, num_of_adpos))
}

# Pull a nested list of adjectives from rcopora and convert the adjectives to their own list.
adjs <- corpora('words/adjs')
adjs <- setNames(as.list(adjs$adjs), paste0("adj", seq_along(adjs$adjs))) # WORKED!!!!!

# Pull a nested list of adverbs from rcopora and comvert the adverbs to their own list.
adverbs <- corpora('words/adverbs')
adverbs <- setNames(as.list(adverbs$adverbs), paste0("adv", seq_along(adverbs$adverbs)))

# Pull a nested list of nouns from rcopora and convert the nouns to their own list.
nouns <- corpora('words/nouns')
nouns <- setNames(as.list(nouns$nouns), paste0("n", seq_along(nouns$nouns)))

# Need to randomly select a word from psw_list (based on user input divided by number of paragraphs?), find the
# pos of the word, randomly find a word of the same part of speech in one of the other lists, pull that word in
# and replace it with the original one.

sample(psw_list, 1) # randomly selects a paragraph from psw_list
for (i in psw_list){ # goes through all paragraphs
  print(spacy_parse(sample(i, 1))) # randomly selects a word and parses it
}

# code that randomly selects same POS word
for (p in psw_list){
  for (i in p){
    spacy_parse(i, lemma = FALSE, pos = TRUE, tag = FALSE, entity = FALSE) #%>%
      
  }
}

# trying to pull a word of specific pos
spacy_parse(i, pos = TRUE) %>%
  as.tokens(include_pos = "pos") %>%
  tokens_select(pattern = c("*/NOUN"))

# this for loop spacy parses each word in the entire article

for (i in psw_list){
  print(spacy_parse(i, pos = TRUE, tag = TRUE) %>%
          as.tokens(include_pos = "pos") %>%
          tokens_select(pattern = c("*/NOUN",))
          tokens_remove(pattern = c('*/PROPN', '*/ADP', '*/NUM', '*/ADV', '*/',)))
}

# Replacing words in either paragraphs_list or psw_list: how to? Maybe write a function

# Steps from here: 1) Take in the total number of iterations from the shiny app widget, and evenly divide those among 
# the total number of paragraphs in the article? Or make it top heavy like OBC mentioned, putting the majority of the
# changes towards the beginning of the article. 2) Begin writing the algorithm that will randomly decide what types
# of words to change (as in parts of speech) using the methods written above. 3) Find a library of words of the same
# parts of speech, check Spacyr again, but I believe that feature may only be in Spacy. 3) Figure out how to pull in
# a new word of the same parts of speech from that library and then replace the randomly selected word with the new one.

# Algorithm thar decides which words to change, use nouns, adjs, and adverbs at the moment.


# Sub Function testing
x <- "r tutorial"
y <- sub("r ","HTML ", x)
y

# This works, warning message pops up though
x <- sample(psw_list$p1, 1)
x <- gsub(x, psw_list$p1, sample(adjs, 1))


y <- str_replace(x, psw_list$p1, sample(adjs, 1))














