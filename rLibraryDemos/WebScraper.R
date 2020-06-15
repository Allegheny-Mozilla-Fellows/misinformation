# Some code bits were taken from https://www.youtube.com/watch?v=l37n_HDD1qs

# Installing the rvest and stringr package
install.packages('rvest')
install.packages("stringr")

# Loading the rvest package
library('rvest')
library('stringr')
library('purrr')
library('robotstxt')
library('xml2')
library('dplyr')

# Check if we can scrape from this site, if TRUE we can, if FALSE we can't
paths_allowed(
  paths = c("https://www.nytimes.com/2020/06/15/nyregion/nyc-affordable-housing-lottery.html")
)

# Specifying the url for desired website to be scraped
url <- 'https://www.nytimes.com/2020/06/15/nyregion/nyc-affordable-housing-lottery.html'

# Reading the HTML code from the website
NYTwebpage <- read_html(url)

# Test to pull out text from the article

NYTwebpage %>%
  html_nodes(".css-53u6y8 p") %>%
  html_text() %>%
  str_split(' ') -> paragraphs_separated_by_word
  # map_chr() to pull out specific elements by number

# NYTwebpage %>%
#   html_nodes(".css-158dogj p") %>%
#   html_text()



# Using CSS selectors to scrape the rankings section
rank_data_html <- html_nodes(webpage,'.text-primary')

# Converting the ranking data to text
rank_data <- html_text(rank_data_html)

# Let's have a look at the rankings
head(rank_data)




.text-primary

