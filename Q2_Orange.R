OrangeData <- Orange
#We are going to use a SQL function to get answer to part A #
#summaryBy(circumference ~ Tree, data = OrangeData, FUN = list(mean, median))


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