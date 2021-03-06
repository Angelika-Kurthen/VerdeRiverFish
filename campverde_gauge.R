library(data.table)
library(lubridate)
library(ggplot2)

campverde.df <- fread("https://nwis.waterdata.usgs.gov/usa/nwis/uv/?cb_00060=on&cb_00065=on&format=rdb&site_no=09506000&period=&begin_date=2005-01-01&end_date=2021-07-08")
campverde.df <- campverde.df[c(-1, -2) , ]

campverde.df$V3 <- as.POSIXct(campverde.df$V3,tz=Sys.timezone())
campverde.df$V9 <- as.numeric(campverde.df$V9)

head(campverde.df)
campverde.df <- as.data.frame(aggregate(V9 ~ V3, campverde.df, mean))
colnames(campverde.df) <- c("Date", "Discharge (cubic meters per second)")
mean(campverde.df$`Discharge (cfs)`)

#0.028316847 cubic meter/second.
class(campverde.df$Date)
campverde.df$`Discharge (cubic meters per second)` <- campverde.df$`Discharge (cubic meters per second)` * 0.028316847
ggplot(campverde.df, aes(x = Date, y = `Discharge (cubic meters per second)`))+
  geom_line(color = "blue") +
  scale_y_continuous(trans='log10')+
  theme_bw()

