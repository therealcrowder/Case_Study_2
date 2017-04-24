# Bring in the data again for TEMP.csv #
TempData = read.csv("TEMP.csv")
# We change the dataset name to prep for subsetting out the US Data #
USTemp <- TEMPData
# Here we subset the US data out #
USTemp <- subset(USTemp, Country == "United States")
# We isolate the US Temp from 1990 #
USTemp <- USTemp[-c(1:2656), ]
# If you don't already have the package "weathermetrics" please install by taking the "#" off #
#install.packages("weathermetrics")
# load the library #
library(weathermetrics)
# We use the weathermetrics package to execute the function to convert the celsisus to fahrenheit and answer part a #
USTemp$Monthly.AverageTempFahrenheit <- celsius.to.fahrenheit(USTemp$Monthly.AverageTemp, round = 3)

DateTesting <- USTemp
# We are simply formating the dates into one format #
DateTesting$FormattedDate <- as.Date(DateTesting$Date, format="%m/%d/%Y")

DateTesting$Month <- months(DateTesting$FormattedDate)
#If you don't already have the package "lubridate" please install by taking the "#" off #
#install.packages("lubridate")

library(lubridate)
#Here we start tidying the data by cleaning the dates #
DateTesting$Year <- year(DateTesting$FormattedDate)
# These
landTemp <- aggregate(DateTesting$Monthly.AverageTempFahrenheit ~ DateTesting$Year, DateTesting, function(x) mean(x))

landTemp$Monthly.AverageTempFahrenheitDifference <- c(NA, round(diff(landTemp$`DateTesting$Monthly.AverageTempFahrenheit`), digits = 3))

landTemp$`DateTesting$Monthly.AverageTempFahrenheit` <- NULL

landTemp <- rename(landTemp, c("DateTesting$Year"="Year", "Monthly.AverageTempFahrenheitDifference"="AverageTemperatureDifferenceFromPreviousYear"))

landTemp <- arrange(landTemp, -landTemp$AverageTemperatureDifferenceFromPreviousYear)

landTemp[1, ]

landTemp <- aggregate(DateTesting$Monthly.AverageTempFahrenheit ~ DateTesting$Year, DateTesting, function(x) mean(x))

ggplot(data = landTemp, aes(x = landTemp$`DateTesting$Year`, y = landTemp$`DateTesting$Monthly.AverageTempFahrenheit`, group=1)) + geom_line() + geom_point(aes(color = landTemp$`DateTesting$Year`)) + labs(x = "Year", y = "Avg. Temp. in F", title = "Average Land Temperature by Year since 1990") + scale_x_continuous(breaks = round(seq(min(landTemp$`DateTesting$Year`), max(landTemp$`DateTesting$Year`), by = 1),1)) + theme(axis.text.x = element_text(angle=90)) + guides(colour=FALSE)

