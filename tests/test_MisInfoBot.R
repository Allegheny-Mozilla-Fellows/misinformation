# install.packages('testthat')

source("/Users/declancasey/Desktop/Summer2020/misinformation/MisInfoBot/MisInfoBot.R", chdir = TRUE)
library('testthat')



# pretty sure this works
test_that("paragraphs_list contains a nested list", {
  paragraphs_list <- readNYTLinkToParagraphs(url)
  expect_output(str(paragraphs_list), "List of")
})

# pretty sure this works
test_that("psw_list contains a nested list", {
  psw_list <- readNYTLinkToPSW(url)
  expect_output(str(psw_list), "List of")
})

test_that("url contains an New York Times url",{
  expect_match(url, "https://www.nytimes.com/")
})