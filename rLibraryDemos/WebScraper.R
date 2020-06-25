# Some code bits were taken from https://www.youtube.com/watch?v=l37n_HDD1qs

# Installing the rvest and stringr package
install.packages('rvest')
install.packages("rcorpora")
install.packages("radlibs")
install.packages("stringr")
# install.packages("quanteda")
install.packages("spacyr")
install.packages("rlist")
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

iterations == 1
for (i in iterations){ # for a specific change in the total amount of changes
  n <- sample(names(psw_list), 1) 
  j <- sample(length(psw_list[[n]]), 1) 
  parsed <- spacy_parse(psw_list[[n]][j])
  pos <- parsed[1,6]
    # tabbing because the if starts here
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
    # Need to add nested if to determine if it's past or present tense
    sample(verbs_past, 1) -> replacement
    as.character(replacement) -> replacement
    psw_list[[n]][j] <- replacement
  } else if( word.pos == somethingelse) {
   
  }
}

# After this loop, which handles all word replacement in the code, we will need to reformat the 'psw_list' to look
# like paragraphs and print that out in the shiny app or in R markdown. Ask OBC if he has experience doing this.

# # SELECT NOUN FUNCTION
# selectNoun <- function(string_to_parse){
#   nouns <- spacy_parse(string_to_parse, pos = TRUE) %>%
#     as.tokens(include_pos = "pos") %>%
#     tokens_select(pattern = c("*/NOUN"))
#   nouns <- str_split(nouns, "   ")
#   return(sample(nouns, 1))
# }

# # Function to replace a chosen noun 
# replaceNoun <- function(noun){
#   random_noun <- toString(sample(nouns, 1))
#   noun <- str_replace(noun, noun, random_noun)
#   return(noun)
# }





