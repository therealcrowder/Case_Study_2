# We read in the data set that has already been downloaded from box.com #
TEMPData <- read.csv("TEMP.csv")
# Here we parse the data to what we need #
TEMPDataSince1900 <- TEMPData[nrow(TEMPData):1,]

# If you don't already have the package lubridate please install by taking the "#" off #
#install.packages("lubridate")
# load the library #
library(lubridate)
# Remove the NA's in this dataset #
TEMPDataC <- na.omit(TEMPData)
# These two lines will gives us the variables for temp min and max #
AvgTempMin <- aggregate(TEMPData$Monthly.AverageTemp ~ TEMPData$Country, TEMPData, function(x) min(x))
AvgTempMax <- aggregate(TEMPData$Monthly.AverageTemp ~ TEMPData$Country, TEMPData, function(x) max(x))
# If you don't already have the package plyr please install by taking the "#" off #  

#install.packages("plyr")
library(plyr)
# We then merge the Min and Max data #
AvgMinANDMaxTemp <- merge(AvgTempMax, AvgTempMin, by=1)
# Continuing the tidying process we take the AvgMinANDMaxTemp and name the column names #
AvgMinANDMaxTemp <- rename(AvgMinANDMaxTemp, c("TEMPData$Country"="Country", "TEMPData$Monthly.AverageTemp.x"="AvgMaxTemp", "TEMPData$Monthly.AverageTemp.y"="AvgMinTemp"))

# With the below line of code, we take the difference of the min and max #
AvgMinANDMaxTemp$AvgMaxMinDiff <- AvgMinANDMaxTemp$AvgMaxTemp - AvgMinANDMaxTemp$AvgMinTemp
# This line sets the order of the difference to prepare for the seperation of the top 20 countries #
AvgMinANDMaxTempByDiff <- AvgMinANDMaxTemp[order(AvgMinANDMaxTemp$AvgMaxMinDiff, decreasing = TRUE), ]
# Here we accomplish the actual seperation of the top 20 countries with the max differences since 1900 #
AvgMinANDMaxTempByDiffTop20 <- AvgMinANDMaxTempByDiff[order(-AvgMinANDMaxTempByDiff$AvgMaxMinDiff),][1:20,]

# We simply display the varible below to get our table of the largest variations in tempeture by country.
AvgMinANDMaxTempByDiffTop20
# With plotting this data we want to display the difference between the Avg Min and Max Temp by the top 20 countries #
ggplot(data = AvgMinANDMaxTempByDiffTop20, aes(x = AvgMinANDMaxTempByDiffTop20$Country, y = AvgMinANDMaxTempByDiffTop20$AvgMaxMinDiff, color = AvgMinANDMaxTempByDiffTop20$Country)) + geom_point(size = 3, show.legend = FALSE) + theme(axis.text.x = element_text(angle = 90)) + ggtitle("Top 20 countries with the maximum average temperature differences for the period since 1900") + xlab("Country") + ylab("Diff between Avg Min & Max Temp")