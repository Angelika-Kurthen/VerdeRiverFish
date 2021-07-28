library(data.table)
library(lubridate)
library(ggplot2)

clarkdale.df <- fread("https://nwis.waterdata.usgs.gov/usa/nwis/uv/?cb_00060=on&format=rdb&site_no=09504000&period=&begin_date=2005-01-01&end_date=2021-07-07")
clarkdale.df <- clarkdale.df[c(-1, -2) , ]

clarkdale.df$V3 <- as.POSIXct(clarkdale.df$V3,tz=Sys.timezone())
clarkdale.df$V5 <- as.numeric(clarkdale.df$V5)

clarkdale.df <- as.data.frame(aggregate(V5 ~ V3, clarkdale.df, mean))
colnames(clarkdale.df) <- c("Date", "Discharge (cfs)")
mean(clarkdale.df$`Discharge (cfs)`)

class(clarkdale.df$Date)

ggplot(clarkdale.df, aes(x = Date, y = `Discharge (cfs)`))+
  geom_line(color = "blue") +
  scale_y_continuous(trans='log10')+ 
  theme_bw()
