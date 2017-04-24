# Read in the City Temp data #
CityTempData <- read.csv("CityTemp.csv")
# We start the tidying process by cleaning the dates and setting the formats needed to complete our tasks #
CityTempData$FormattedDate <- as.Date(CityTempData$Date, format="%m/%d/%Y")
CityTempData$Month <- months(CityTempData$FormattedDate)
CityTempData$Year <- year(CityTempData$FormattedDate)
# Here we order the data by year
CityTempData <- CityTempData[order(CityTempData$Year),]
# Now we pull the since 1900 #
CityTempData <- CityTempData[complete.cases(CityTempData[,10]),]

# With these lines we set variables for both min and the max, then we combine into one single variable #
CityTempDataAvgMin <- aggregate(CityTempData$Monthly.AverageTemp ~ CityTempData$City, TEMPData, function(x) min(x))
CityTempDataAvgMax <- aggregate(CityTempData$Monthly.AverageTemp ~ CityTempData$City, TEMPData, function(x) max(x))
CityTempDataAvgMinANDMaxTemp <- merge(CityTempDataAvgMax, CityTempDataAvgMin, by=1)
# Now we calculate the differences #
CityTempDataAvgMinANDMaxTemp$AvgMaxMinDiff <- CityTempDataAvgMinANDMaxTemp$`CityTempData$Monthly.AverageTemp.x` - CityTempDataAvgMinANDMaxTemp$`CityTempData$Monthly.AverageTemp.y`
# Make columns human readable #
CityTempDataAvgMinANDMaxTemp <- rename(CityTempDataAvgMinANDMaxTemp, c("CityTempData$City"="City", "CityTempData$Monthly.AverageTemp.x"="AvgMaxTemp", "CityTempData$Monthly.AverageTemp.y"="AvgMinTemp"))

CityTempDataAvgMinANDMaxTemp <- CityTempDataAvgMinANDMaxTemp[order(CityTempDataAvgMinANDMaxTemp$AvgMaxMinDiff, decreasing = TRUE), ]

CityTempDataAvgMinANDMaxTemp <- CityTempDataAvgMinANDMaxTemp[order(-CityTempDataAvgMinANDMaxTemp$AvgMaxMinDiff),][1:20,]

CityTempDataAvgMinANDMaxTemp[,"Country"] <- NA

CityTempDataAvgMinANDMaxTemp$Country <- CityTempData$Country[match(CityTempDataAvgMinANDMaxTemp$City,CityTempData$City)]

# Plot for Top 20 Cities
ggplot(data=CityTempDataAvgMinANDMaxTemp, aes(x=City, y=AvgMaxMinDiff, group=1, color=City)) + geom_point(size = 3) + theme(axis.text.x = element_text(angle=90)) + guides(colour=FALSE) + labs(x = "Cities", y = "Difference from min and max avg. temperature (C)", title = "Top 20 cities with greatest difference in average temperature since 1900")