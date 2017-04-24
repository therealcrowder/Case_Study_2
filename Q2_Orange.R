OrangeData <- Orange
# Below we build a function to get the mean and median tree circumference #
Q2aFunction <- function(x) {c(mean = mean(x), median = median(x))}
# We then declare our variables and run our function to get the answer #
cbind(Tree = unique(OrangeData$Tree),
  do.call(rbind, tapply(OrangeData$circumference, OrangeData$Tree, Q2aFunction)))
# With the below plot we are looking for a relationship between the circumference of the tree trunk and the age of the tree. #
library(ggplot2)
qplot(data = OrangeData, x = age, y = circumference, shape = Tree, xlab = "Circumference", ylab = "Age", main = "Trunk Circumference versus Age by Tree #", color = Tree)

# For the boxplot we use ggplot to generate Truck Circumference by Tree using different colors by tree #
ggplot(data = OrangeData,
  aes(x = Tree,
    y = circumference,
    group = Tree)) +
  geom_boxplot(
    aes(color = Tree)) +
  labs(x = "Tree #", y = "Trunk Circumference", title = "Trunk Circumference by Tree Number")