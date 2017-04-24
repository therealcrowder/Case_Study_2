CityTempDataAvgMinANDMaxTemp

ggplot() +
  # Country Plot (Black Circles)
  geom_point(data=AvgMinANDMaxTempByDiffTop20, aes(x=Country, y=AvgMaxMinDiff), show.legend = TRUE, size = 3, shape = 19) +
  # City Plot (Colored Triangles)
  geom_point(data=CityTempDataAvgMinANDMaxTemp, aes(x=Country, y=AvgMaxMinDiff, color = City, fill = City), show.legend = TRUE, shape = 24, size = 3) +
  theme(axis.text.x = element_text(angle=90)) + labs(x = "Countries (Avg for countries are represnted by black circle points)", y = "Difference from min and max avg. temperature (C)", title = "Top 20 Cities and Top 20 Countries")