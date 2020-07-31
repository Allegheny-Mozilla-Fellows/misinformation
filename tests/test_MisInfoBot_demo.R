# install.packages('testthat')

source("/Users/declancasey/Desktop/Summer2020/misinformation/MisInfoBot/MisInfoBot_demo.R", chdir = TRUE)
library('testthat')

test_that("iterations is a number", {
  expect_output(str(iterations), "num")
})

test_that("demo_list contains a list", {
  expect_output(str(demo_list), "List")
})

# test push to make sure there's no merge conflict