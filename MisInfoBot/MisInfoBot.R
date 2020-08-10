# Some code bits were taken from https://www.youtube.com/watch?v=l37n_HDD1qs
# make sure to have miniconda installed: https://docs.conda.io/en/latest/miniconda.html

# Installing the necesary packages
# install.packages("devtools")
# devtools::install_github("quanteda/spacyr", build_vignettes = FALSE)
# install.packages('rvest')
# install.packages("rcorpora")
# install.packages("radlibs")
# install.packages("stringr")
# install.packages("spacyr") # other instructions here: https://cran.r-project.org/web/packages/spacyr/readme/README.html
# spacy_install() # only do this once
# install.packages("qdapDictionaries")

# Loading all used packages
library('rvest') 
library('stringr') 
library('spacyr') 
library('rcorpora') 
library('radlibs') 
library('qdapDictionaries')

# PLAY AROUND WITH ITERATIONS, change the number and re-declare the variable every time you want to change the amount of changes
# that are made in the article.
iterations <- 15

# Specifying the url for desired website to be scraped
url <- 'enter NYT url here'
url <- 'https://www.nytimes.com/2020/07/15/science/hybrid-sturgeon-paddlefish.html'

# need to test this function
# test the format of the output? whether there is output or not?
readNYTLinkToParagraphs <- function(url){
  NYTwebpage <- read_html(url)
  NYTwebpage %>%
    html_nodes(".css-53u6y8 p") %>%
    html_text() -> paragraphs
  setNames(as.list(paragraphs), paste0("p", seq_along(paragraphs))) -> paragraphs
  return(paragraphs)
}

# need to test this function
# test the format of the output? whether there is output or not?
readNYTLinkToPSW <- function(url){
  NYTwebpage <- read_html(url)
  NYTwebpage %>%
    html_nodes(".css-53u6y8 p") %>%
    html_text() %>%
    str_split(' ') -> paragraphs_separated_by_word
  setNames(as.list(paragraphs_separated_by_word), paste0("p", seq_along(paragraphs_separated_by_word))) -> paragraphs_separated_by_word
  return(paragraphs_separated_by_word)
}


# The 'main' method: Copy and paste all of the code below and run it in the console
paragraphs_list<- readNYTLinkToParagraphs(url)
psw_list <- readNYTLinkToPSW(url)
write(unlist(paragraphs_list), "old_article.txt", sep = "\n")
    # Pull a nested list of adjectives from rcopora and convert the adjectives to their own list.
adjs <- corpora('words/adjs')
adjs <- setNames(as.list(adjs$adjs), paste0("adj", seq_along(adjs$adjs)))
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
    # Conditional Logic that randomly replaces a word with another word of the same part of speech
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
    str_detect(psw_list[[n]][j], "ed$") -> end_of_verb
    if (end_of_verb == "TRUE"){
      sample(verbs_past, 1) -> replacement
      as.character(replacement) -> replacement
      psw_list[[n]][j] <- replacement
    } else if (end_of_verb == "FALSE"){
      sample(verbs_present, 1) -> replacement
      as.character(replacement) -> replacement
    }
  }
}
    # Remove the whitespace in between the words
paragraphs_list <- lapply(psw_list, paste, collapse = " ")
    # Write the new paragraphs to a txt file
write(unlist(paragraphs_list), "new_article.txt", sep = "\n")