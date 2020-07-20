# Some code bits were taken from https://www.youtube.com/watch?v=l37n_HDD1qs

# Installing the rvest and stringr package
install.packages('rvest')
install.packages("rcorpora") 
install.packages("radlibs")
install.packages("stringr")
install.packages("spacyr")
install.packages("qdapDictionaries")
# install.packages("quanteda")
# install.packages("rlist")


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
url <- 'insert NYT url in parentheses here'
# url <- 'https://www.nytimes.com/2020/06/15/nyregion/nyc-affordable-housing-lottery.html'

# # Reading the HTML code from the website
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


# Creating a demonstration list of sentences to test the for loop on
# Remove the hashtags and copy and paste if you would like to see the changes on a smaller sample

# demo_list <- list("Two roads diverged in a yellow wood",
#                   "And sorry I could not travel both",
#                   "And be one traveler, long I stood",
#                   "And looked down one as far as I could",
#                   "To where it bent in the undergrowth;",
# 
#                   "Then took the other, as just as fair,",
#                   "And having perhaps the better claim,",
#                   "Because it was grassy and wanted wear;",
#                   "Though as for that the passing there",
#                   "Had worn them really about the same,",
# 
#                   "And both that morning equally lay",
#                   "In leaves no step had trodden black.",
#                   "Oh, I kept the first for another day!",
#                   "Yet knowing how way leads on to way,",
#                   "I doubted if I should ever come back.",
# 
#                   "I shall be telling this with a sigh",
#                   "Somewhere ages and ages hence:",
#                   "Two roads diverged in a wood, and I—",
#                   "I took the one less traveled by,",
#                   "And that has made all the difference.")
# demo_list <- str_split(demo_list, " ")
# demo_list <- setNames(demo_list, paste0("p", seq_along(demo_list)))


# Turn 'paragraphs' and 'paragraphs_separated_by_word' into list objects, change naming conventions
paragraph_list <- setNames(as.list(paragraphs), paste0("p", seq_along(paragraphs)))
psw_list <- setNames(as.list(paragraphs_separated_by_word), paste0("p", seq_along(paragraphs_separated_by_word)))
rm(paragraphs_separated_by_word)

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


# The for loop to use on the demonsration list
# Remove the hashtags and copy and paste if you would like to see the changes on a smaller sample

# for (i in 1:iterations){ # for a specific change in the total amount of changes
#   LIST_OF_UNACCEPTABLE_POS <- list("AUX", "CONJ", "DET", "INTJ", "NUM", "PART", "PROPN", "PUNCT", "SCONJ", "SYM",
#                                    "X",  "CCONJ", "SCONJ")
#   repeat{
#     n <- sample(names(demo_list), 1)
#     j <- sample(length(demo_list[[n]]), 1)
#     parsed <- spacy_parse(demo_list[[n]][j])
#     pos <- parsed[1,6]
#     # print(pos)
#     if(!(pos %in% LIST_OF_UNACCEPTABLE_POS))
#       break;
#   }
#   if (pos == "NOUN"){
#     sample(nouns, 1) -> replacement
#     as.character(replacement) -> replacement
#     demo_list[[n]][j] <- replacement
#   } else if (pos == "ADJ"){
#     sample(adjs, 1) -> replacement
#     as.character(replacement) -> replacement
#     demo_list[[n]][j] <- replacement
#   } else if (pos == "ADV"){
#     sample(adverbs, 1) -> replacement
#     as.character(replacement) -> replacement
#     demo_list[[n]][j] <- replacement
#   } else if (pos == "PROPN"){
#     sample(proper_nouns, 1) -> replacement
#     as.character(replacement) -> replacement
#     demo_list[[n]][j] <- replacement
#   } else if (pos == "ADP"){
#     sample(prepositions, 1) -> replacement
#     as.character(replacement) -> replacement
#     demo_list[[n]][j] <- replacement
#   } else if (pos == "VERB"){
#     str_detect(demo_list[[n]][j], "ed$") -> end_of_verb
#     if (end_of_verb == "TRUE"){
#       sample(verbs_past, 1) -> replacement
#       as.character(replacement) -> replacement
#       demo_list[[n]][j] <- replacement
#     } else if (end_of_verb == "FALSE"){
#       sample(verbs_present, 1) -> replacement
#       as.character(replacement) -> replacement
#       demo_list[[n]][j] <- replacement
#     }
#   }
# }

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
      psw_list[[n]][j] <- replacement
    }
  }
}

# Remove the whitespace in between the words
paragraph_list <- lapply(psw_list, paste, collapse = " ")

# Write the new paragraphs to a txt file
write(unlist(paragraph_list), "new_article.txt", sep = "\n")


# Turning the demonstration list into a txt file
# Remove the hashtags and copy and paste if you would like to see the changes on a smaller sample

# Remove the whitespace in between the words
# paragraph_list <- lapply(demo_list, paste, collapse = " ")

# Write the new paragraphs to a txt file
# write(unlist(paragraph_list), "new_article.txt", sep = "\n")







