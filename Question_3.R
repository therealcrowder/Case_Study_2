
Question #2
> mean(OrangeData$circumference)
[1] 115.8571
> median(OrangeData$circumference)
[1] 115
> qplot(x = OrangeData$circumference, y = OrangeData$age, shape=OrangeData$Tree, xlab = "Circumference", ylab = "Age")
> boxplot(OrangeData$circumference~OrangeData$Tree, Data=OrangeData, xlab = "Tree", ylab = "Circumference")

#Question #3 part 1

TEMPData <- read.csv("TEMP.csv")

TEMPDataSince1900 <- TEMPData[nrow(TEMPData):1,]

install.packages("lubridate")
library(lubridate)



TEMPDataC <- na.omit(TEMPData)



AvgTempMin <- aggregate(TEMPData$Monthly.AverageTemp ~ TEMPData$Country, TEMPData, function(x) min(x))
AvgTempMax <- aggregate(TEMPData$Monthly.AverageTemp ~ TEMPData$Country, TEMPData, function(x) max(x))

library(plyr)

AvgMinANDMaxTemp <- merge(AvgTempMax, AvgTempMin, by=1)

AvgMinANDMaxTemp <- rename(AvgMinANDMaxTemp, c("TEMPData$Country"="Country", "TEMPData$Monthly.AverageTemp.x"="AvgMaxTemp", "TEMPData$Monthly.AverageTemp.y"="AvgMinTemp"))

AvgMinANDMaxTemp$AvgMaxMinDiff <- AvgMinANDMaxTemp$AvgMaxTemp - AvgMinANDMaxTemp$AvgMinTemp

AvgMinANDMaxTempByDiff <- AvgMinANDMaxTemp[order(AvgMinANDMaxTemp$AvgMaxMinDiff, decreasing = TRUE), ]

AvgMinANDMaxTempByDiffTop20 <- AvgMinANDMaxTempByDiff[order(-AvgMinANDMaxTempByDiff$AvgMaxMinDiff),][1:20,]


ggplot(data = AvgMinANDMaxTempByDiffTop20, aes(x = AvgMinANDMaxTempByDiffTop20$Country, y = AvgMinANDMaxTempByDiffTop20$AvgMaxMinDiff, fill = AvgMinANDMaxTempByDiffTop20$Country)) + geom_col(show.legend = FALSE) + theme(axis.text.x = element_text(angle = 90)) + ggtitle("Top 20 countries with the maximum average temperature differences for the period since 1900") + xlab("Country") + ylab("Diff between Avg Min & Max Temp")