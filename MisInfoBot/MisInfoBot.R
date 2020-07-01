# Some code bits were taken from https://www.youtube.com/watch?v=l37n_HDD1qs

# Installing the rvest and stringr package
install.packages('rvest')
install.packages("rcorpora")
install.packages("radlibs")
install.packages("stringr")
# install.packages("quanteda")
install.packages("spacyr")
# install.packages("rlist")
install.packages("qdapDictionaries")

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
library('qdapDictionaries')

# Specifying the url for desired website to be scraped
url <- 'insert NYT url in parentheses here'
url <- 'https://www.nytimes.com/2020/06/15/nyregion/nyc-affordable-housing-lottery.html'

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

# Creating a demo list of sentences to test the for loop on
demo_list <- list("I want to eat all the hamburger buns in the entire world because I am so hungy.",
                  "I just ate a sprite can by accident, I think I should go to the hospital.",
                  "The doctor gave me some ibuprofen, I don't think he is qualified to do his job.",
                  "The medicine isn't working, I am more sick than I was before I went to the doctor, send help.",
                  "A week later and I have lost all sense of taste, probably a good time to lay off the Mickey D's.")
demo_list <- str_split(demo_list, " ")
demo_list <- setNames(demo_list, paste0("p", seq_along(demo_list)))



# Turn 'paragraphs' and 'paragraphs_separated_by_word' into list objects, change naming conventions
paragraph_list <- setNames(as.list(paragraphs), paste0("p", seq_along(paragraphs)))


psw_list <- setNames(as.list(paragraphs_separated_by_word), paste0("p", seq_along(paragraphs_separated_by_word)))
rm(paragraphs_separated_by_word)

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

# Pull a list of prepositions from the 'qdapDictionaries' library
data(preposition)
prepositions <- setNames(as.list(preposition), paste0("prep", seq_along(preposition)))

# Currently, the loop below 1) takes in a number of iterations (fized # ATM) from the shiny app and will use that
# to figure out how many loops to complete, 2) selects a random paragraph to choose a word from and saves that
# paragraph's index as n, 4) randomly selects a word from that paragraph and saves that word's index as j, 5) spacy
# parses that word and saves the part of speech as a variable, 6) performs the conditional logic that randomly
# selects a word from a large dataset of words of the same part of speech, 7) converts that replacement word from
# a list element to a string, 8) replaces that new word in the old word's index, specifically 'psw_list[[n]][j]'.

# IT NOW NEEDS: 1) specification of the verb's tense, either past or present; 2)  to go back to the beginning of the
# loop if it is neither a verb, noun, proper noun, adjective, adverb, preposition/adposition

iterations <- 15
for (i in 1:iterations){ # for a specific change in the total amount of changes
  LIST_OF_UNACCEPTABLE_POS <- list("AUX", "CONJ", "DET", "INTJ", "NUM", "PART", "PROPN", "PUNCT", "SCONJ", "SYM",
                                   "X",  "CCONJ", "SCONJ")
  repeat{
    n <- sample(names(psw_list), 1) 
    j <- sample(length(psw_list[[n]]), 1) 
    parsed <- spacy_parse(psw_list[[n]][j])
    pos <- parsed[1,6]
    # print(pos)
    if(!(pos %in% LIST_OF_UNACCEPTABLE_POS))
      break;
  } 
  print(pos)
  if (pos == "NOUN"){
    sample(nouns, 1) -> replacement
    as.character(replacement) -> replacement
    psw_list[[n]][j] <- replacement
  } else if (pos == "ADJ"){
    sample(adjs, 1) -> replacement
    as.character(replacement) -> replacement
    psw_list[[n]][j] <- replacement
  } else if (pos == "ADV"){
    sample(adverbs, 1) -> replacement
    as.character(replacement) -> replacement
    psw_list[[n]][j] <- replacement
  } else if (pos == "PROPN"){
    sample(proper_nouns, 1) -> replacement
    as.character(replacement) -> replacement
    psw_list[[n]][j] <- replacement
  } else if (pos == "ADP"){
    sample(prepositions, 1) -> replacement
    as.character(replacement) -> replacement
    psw_list[[n]][j] <- replacement
  } else if (pos == "VERB"){
    sample(verbs_present, 1) -> replacement
    as.character(replacement) -> replacement
    psw_list[[n]][j] <- replacement
    # Need to add nested if to determine if it's past or present tense
    # Ask OBC about this
    # if (some_string == "past"){
    #   sample(verbs_past, 1) -> replacement
    #   as.character(replacement) -> replacement
    #   psw_list[[n]][j] <- replacement
    # } else if (some_string == "present"){
    #   sample(verbs_present, 1) -> replacement
    #   as.character(replacement) -> replacement
    #   psw_list[[n]][j] <- replacement
    # }
  }
}

# Remove the whitespace in between the words
paragraph_list <- lapply(psw_list, paste, collapse = " ")

# Write the new paragraphs to a txt file
write(unlist(psw_list), "new_article.txt", sep = "\n")



