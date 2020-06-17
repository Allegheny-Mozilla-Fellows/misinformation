# Some code bits were taken from https://www.youtube.com/watch?v=l37n_HDD1qs

# Installing the rvest and stringr package
install.packages('rvest')
install.packages("stringr")
install.packages("quanteda")
install.packages("spacyr")

# Loading some useful packages
library('rvest')
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
noun_parsed <- spacy_parse(paragraph_list$p1, pos = TRUE) %>%
                as.tokens(include_pos = "pos") %>%
                tokens_select(pattern = c("*/NOUN"))

proper_noun_parsed <- spacy_parse(paragraph_list$p1, pos = TRUE) %>%
                        as.tokens(include_pos = "pos") %>%
                        tokens_select(pattern = c("*/PROPN"))

adj_parsed <- spacy_parse(paragraph_list$p1, pos = TRUE) %>%
                as.tokens(include_pos = "pos") %>%
                tokens_select(pattern = c("*/ADJ"))

verb_parsed <- spacy_parse(paragraph_list$p1, pos = TRUE) %>%
                as.tokens(include_pos = "pos") %>%
                tokens_select(pattern = c("*/VERB"))

adverb_parsed <- spacy_parse(paragraph_list$p1, pos = TRUE) %>%
                  as.tokens(include_pos = "pos") %>%
                  tokens_select(pattern = c("*/ADV"))

number_parsed <- spacy_parse(paragraph_list$p1, pos = TRUE) %>%
                    as.tokens(include_pos = "pos") %>%
                    tokens_select(pattern = c("*/NUM"))

adposition_parsed <- spacy_parse(paragraph_list$p1, pos = TRUE) %>%
                      as.tokens(include_pos = "pos") %>%
                      tokens_select(pattern = c("*/ADP"))

# TEST FUNCTION TO RANDOMLY SELECT ONE NOUN
# ask OBC about writing this function
selectNoun <- function(num_of_nouns, string_to_parse){
    nouns <- spacy_parse(string_to_parse, pos = TRUE) %>%
                as.tokens(include_pos = "pos") %>%
                tokens_select(pattern = c("*/NOUN"))
    nouns <- str_split(nouns, "   ")
    return(sample(nouns, num_of_nouns))
}

str_split(test, "     ") # splits the noun object in selectNoun into pieces

parsedtxt <- spacy_parse(psw_list$p1, pos = TRUE)
as.tokens(parsedtxt, include_pos = "pos")


# Randomly select a paragraph or randomly select a word from a paragraph?
# spacy_parse doesn't work on lists
spacy_parse(sample(psw_list, 1))
# spacy_parse does work on one item in a list, like this:
spacy_parse()

spacy_parse(sample(psw_list$p1, 1), pos = TRUE, tag = TRUE)

for (p in psw_list){
 spacy_parse(sample(p, 1), pos = TRUE, tag = TRUE) %>%
    # code that randomly selects same POS word
}


