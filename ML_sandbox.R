# sandbox for machine learning practicals
# demo code from https://www.datacamp.com/community/tutorials/machine-learning-in-r#one

install.packages('ggvis')

library('ggvis')

iris

# scatter plot for iris sepal info
iris %>% ggvis(~Sepal.Length, ~Sepal.Width, fill = ~Species) %>% layer_points()

# scatter plot for iris petal info
iris %>% ggvis(~Petal.Length, ~Petal.Width, fill = ~Species) %>% layer_points()

# view the structure of the iris dataset
cor(iris$Petal.Length, iris$Petal.Width)

# summary overview of `iris`
summary(iris) 

# refined summary overview
summary(iris[c("Petal.Width", "Sepal.Width")])


### Preparing the workspace, data, and the model
library(class)

# When deciding whether we need to normalize the data, look at the minimum and maximum value of the variables being studied. If they
# are drastically different than the data needs normalizing, if not it doesn't. You can write a normalize() function to perform
# feature normalization. You can pipe this new normalized into a data frame using as.data.frame() after the function lapply() returns
# a list of the same length as the datset you piped in.

normalize <- function(x) {
  num <- x - min(x)
  denom <- max(x) - min(x)
  return (num/denom)
}

iris_norm <- as.data.frame(lapply(iris[1:4], normalize))
summary(iris_norm)











