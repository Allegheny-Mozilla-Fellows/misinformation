# Some code bits were taken from https://www.youtube.com/watch?v=l37n_HDD1qs

# Installing the rvest and stringr package
install.packages('rvest')
install.packages("stringr")

# Loading some useful packages
library('rvest')
library('stringr')
library('purrr')
library('robotstxt')
library('xml2')
library('dplyr')

# Check if we can scrape from this site, if TRUE we can, if FALSE we can't
paths_allowed(
  paths = c("insert url here")
)

# Specifying the url for desired website to be scraped
# url <- 'https://www.nytimes.com/2020/06/15/nyregion/nyc-affordable-housing-lottery.html'
# url <- 'https://www.nytimes.com/2020/06/15/us/gay-transgender-workers-supreme-court.html'
# url <- 'https://www.nytimes.com/2020/06/15/opinion/lgbt-supreme-court-ruling.html?action=click&module=Opinion&pgtype=Homepage'
# url <- 'https://www.nytimes.com/2020/06/15/us/politics/supreme-court-lgbtq-rights.html?action=click&module=Top%20Stories&pgtype=Homepage'
# url <- 'https://www.nytimes.com/2020/06/15/magazine/parenting-black-teens.html?action=click&module=Top%20Stories&pgtype=Homepage'
# url <- 'https://www.nytimes.com/2020/06/15/technology/coronavirus-disinformation-russia-iowa-caucus.html'
# url <- 'https://www.nytimes.com/2020/06/03/health/coronavirus-contact-tracing-apps.html'


# Reading the HTML code from the website
NYTwebpage <- read_html(url)

# Test to pull out text from the article

NYTwebpage %>%
  html_nodes(".css-53u6y8 p") %>%
  html_text() %>%
  str_split(' ') -> paragraphs_separated_by_word
  # map_chr() to pull out specific elements by number


