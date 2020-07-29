# install.packages('testthat')

source("/Users/declancasey/Desktop/Summer2020/misinformation/MisInfoBot/MisInfoBot.R", chdir = TRUE)
library('testthat')

test_that("paragraphs_list contains a nested list", {
  paragraphs_list <- readNYTLinkToParagraphs(url)
  expect_output(str(paragraphs_list), "List of")
})

test_that("psw_list contains a nested list", {
  psw_list <- readNYTLinkToPSW(url)
  expect_output(str(psw_list), "List of")
})

test_that("url contains an New York Times url", {
  expect_match(url, "https://www.nytimes.com/")
})

test_that("iterations is a number", {
  expect_output(str(iterations), "num")
})