# Some code bits were taken from https://www.youtube.com/watch?v=l37n_HDD1qs

# Installing the rvest and stringr package
install.packages('rvest')
install.packages("rcorpora")
install.packages("radlibs")
install.packages("stringr")
install.packages("quanteda")
install.packages("spacyr")
install.packages("rlist")

# Loading some useful packages
library('rvest')
library('stringr')
library('spacyr')
library('purrr')
library('xml2')
library('dplyr')
library('quanteda')
library('rcorpora')
library('radlibs')
library('rlist')

# Specifying the url for desired website to be scraped
# All NYT url's seem to work so far
url <- 'https://www.nytimes.com/2020/06/15/nyregion/nyc-affordable-housing-lottery.html'
# url <- 'https://www.nytimes.com/2020/06/15/us/gay-transgender-workers-supreme-court.html'
# url <- 'https://www.nytimes.com/2020/06/15/opinion/lgbt-supreme-court-ruling.html?action=click&module=Opinion&pgtype=Homepage'
# url <- 'https://www.nytimes.com/2020/06/15/us/politics/supreme-court-lgbtq-rights.html?action=click&module=Top%20Stories&pgtype=Homepage'
# url <- 'https://www.nytimes.com/2020/06/15/magazine/parenting-black-teens.html?action=click&module=Top%20Stories&pgtype=Homepage'
# url <- 'https://www.nytimes.com/2020/06/15/technology/coronavirus-disinformation-russia-iowa-caucus.html'
# url <- 'https://www.nytimes.com/2020/06/03/health/coronavirus-contact-tracing-apps.html'


# Reading the HTML code from the website
NYTwebpage <- read_html(url)

# Pull text from the html and separate each paragraph
NYTwebpage %>%
  html_nodes(".css-53u6y8 p") %>%
  html_text() -> paragraphs 

# Pull text from html and separate each paragraph by each word
NYTwebpage %>%
  html_nodes(".css-53u6y8 p") %>%
  html_text() %>% 
  str_split(' ') -> paragraphs_separated_by_word

# Turn 'paragraphs' and 'paragraphs_separated_by_word' into list objects, change naming conventions
paragraph_list <- setNames(as.list(paragraphs), paste0("p", seq_along(paragraphs)))
psw_list <- setNames(as.list(paragraphs_separated_by_word), paste0("p", seq_along(paragraphs_separated_by_word)))
rm(paragraphs_separated_by_word)

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

# Pull a dataframe of proper nouns and save them as a list 
data("proper_nouns")
proper_nouns <- force(proper_nouns)
proper_nouns <- setNames(as.list(proper_nouns$word), paste0("pr", seq_along(proper_nouns$word)))

# Pull a dataframe of past and present verbs and save them as lists
verbs <- corpora('words/verbs')
verbs <- verbs$verbs
verbs_present <- setNames(as.list(verbs$present), paste0("v", seq_along(verbs$present)))
verbs_past <- setNames(as.list(verbs$past), paste0("v", seq_along(verbs$past)))

# Need to randomly select a word from psw_list (based on user input divided by number of paragraphs?), find the
# pos of the word, randomly find a word of the same part of speech in one of the other lists, pull that word in
# and replace it with the original one.

# Steps from here: 1) Take in the total number of iterations from the shiny app widget, and evenly divide those among 
# the total number of paragraphs in the article? Or make it top heavy like OBC mentioned, putting the majority of the
# changes towards the beginning of the article. 2) Begin writing the algorithm that will randomly decide what types
# of words to change (as in parts of speech) using the methods written above. 3) Find a library of words of the same
# parts of speech, check Spacyr again, but I believe that feature may only be in Spacy. 3) Figure out how to pull in
# a new word of the same parts of speech from that library and then replace the randomly selected word with the new one.

# Algorithm thar decides which words to change, use nouns, adjs, and adverbs at the moment.

# select random noun from 'nouns' and replace it with the old and save it in the paragraph
psw_list$p1[WORD] <- str_replace(psw_list$p1[WORD], psw_list$p1[WORD], sample(1, nouns)) # works
replaceNoun(psw_list$p1[24])

# Function to replace a chosen noun 
replaceNoun <- function(noun){
  random_noun <- toString(sample(nouns, 1))
  noun <- str_replace(noun, noun, random_noun)
  return(noun)
}

# Function to replace a chosen adjective
replaceAdj <- function(adj){ # 'adj' should like 'psw_list$p1[1]'
  random_adj <- toString(sample(adjs, 1))
  adj <- str_replace(adj, adj, random_adj)
  return(adj)
} #doesn't save the new adj in place of the old one, have to do so explicitly afterwards

# Function to replace a chosen adverb
replaceAdverb <- function(adv){ # adj' should like 'psw_list$p1[1]'
  random_adv <- toString(sample(adverbs, 1))
  adv <- str_replace(adv, adv, random_adv)
  return(adv)
}

# Function to replace a chosen proper noun
replaceProperNoun <- function(prpnoun){ # adj' should like 'psw_list$p1[1]'
  random_prpnoun <- toString(sample(adjs, 1))
  prpnoun <- str_replace(prpnoun, prpnoun, random_prpnoun)
  return(prpnoun)
}

# 'iterations' will be read in from the slider in shiny
# go through psw_list and select a word to parse

# Loop for the pseudocode to go through
iterations == 7
for (i in iterations){ # for a specific change in the total amount of changes
  # select a random word and find the pos using 'pos' in spacy_parsed
  random_p <- sample(psw_list, 1)
  random_w_in_p <- sample(random_p, 1)
  parsed <- spacy_parse(sample(psw_list$p1, 1)) 
  pos <- parsed[1,6] 
  # coditional logic below
  # make sure the word is changed and saved in the logic
  # go to the next word
  if (pos == NOUN){
    n <- selectNoun(1, psw_list$p1)
    n <- replaceNoun(n)
  } else if (pos == ADJ){
    n <- selectAdj(1, psw_list$p1)
    n <- replaceAdj(n)
  } else if (pos == ADV){
    n <- selectAdverbs(1, psw_list$p1)
    n <- replaceAdverb(n)
  } else if (pos == PROPN){
    n <- selectProperNoun(1, psw_list$p1)
    n <- replaceProperNoun(n) 
  } else if (pos == VERB){
    # this is the tricky part
  }else if (pos == NUM){
    n <- selectNumber(1, psw_list$p1)
    n <- replaceNumber(n) # need to write this function
  } else if( word.pos == somethingelse) {
    # or just else?
    # pick another word but dont increase the i?
  }
}

# Pseudocode for logical flow of replacement of one word
# Will this be inside a for loop?
if (pos == NOUN){
  n <- selectNoun(1, psw_list$p1)
  n <- replaceNoun(n)
} else if (pos == ADJ){
  n <- selectAdj(1, psw_list$p1)
  n <- replaceAdj(n)
} else if (pos == ADV){
  n <- selectAdverbs(1, psw_list$p1)
  n <- replaceAdverb(n)
} else if (pos == PROPN){
  n <- selectProperNoun(1, psw_list$p1)
  n <- replaceProperNoun(n) 
} else if (pos == VERB){
  # this is the tricky part
}else if (pos == NUM){
  n <- selectNumber(1, psw_list$p1)
  n <- replaceNumber(n) # need to write this function
} else if( word.pos == somethingelse) {
  # or just else?
  # pick another word but dont increase the i?
}
