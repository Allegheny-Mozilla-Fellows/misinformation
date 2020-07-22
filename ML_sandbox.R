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

# Feature Normalization is the adjustment of each feature (variable) in the same way across all examples, while Example Normalization
# is the adjustment of each example individually.

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

# setting a seed
set.seed(1234)

ind <- sample(2, nrow(iris), replace=TRUE, prob=c(0.67, 0.33))

# compose training set
iris.training <- iris[ind==1, 1:4]

# inspect training set
head(iris.training)

# compose test set
iris.test <- iris[ind==2, 1:4]

# inspect test set
head(iris.test)

# compose `iris` training labels
iris.trainLabels <- iris[ind==1,5]

# inspect result
print(iris.trainLabels)

# compose `iris` test labels
iris.testLabels <- iris[ind==2, 5]

# inspect result
print(iris.testLabels)

# build the model
iris_pred <- knn(train = iris.training, test = iris.test, cl = iris.trainLabels, k=3)

# inspect `iris_pred`
iris_pred

# put `iris.testLabels` in a data frame
irisTestLabels <- data.frame(iris.testLabels)

# merge `iris_pred` and `iris.testLabels` 
merge <- data.frame(iris_pred, iris.testLabels)

# specify column names for `merge`
names(merge) <- c("Predicted Species", "Observed Species")

merge

install.packages('gmodels')
library('gmodels')

# how correct was the model?
CrossTable(x = iris.testLabels, y = iris_pred, prop.chisq=FALSE)


# now using Caret to classify your data
install.packages('caret')
library('caret')

# Create index to split based on labels  
index <- createDataPartition(iris$Species, p=0.75, list=FALSE)

# Subset training set with index
iris.training <- iris[index,]

# Overview of algos supported by caret
names(getModelInfo())

# Train a model
model_knn <- train(iris.training[, 1:4], iris.training[, 5], method='knn')

# Predict the labels of the test set
predictions<-predict(object=model_knn,iris.test[,1:4])

# Evaluate the predictions
table(predictions)

# Confusion matrix 
confusionMatrix(predictions,iris.test[,5])

# Train the model with preprocessing
model_knn <- train(iris.training[, 1:4], iris.training[, 5], method='knn', preProcess=c("center", "scale"))

# Predict values
predictions<-predict.train(object=model_knn,iris.test[,1:4], type="raw")

# Confusion matrix
confusionMatrix(predictions,iris.test[,5])




