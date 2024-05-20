

library(dplyr)
library(hms)

hh_df <- read.table("household_power_consumption.txt",
                    sep = ";",
                    header = TRUE,
                    colClasses = c(rep("character", 2),
                                   rep("numeric", 7)),
                    na.strings = "?")

hh_df$Date <- as.Date(hh_df$Date, "%d/%m/%Y")
hh_df$Time <- as_hms(hh_df$Time)

hh_df_feb <- hh_df %>% filter(between(Date, 
                                      as.Date('2007-02-01'),
                                      as.Date('2007-02-02')))

png(filename = "plot3.png",
    width = 480, height = 480)

dttime <- as.POSIXct(paste(hh_df_feb$Date, hh_df_feb$Time),
                     format="%Y-%m-%d %H:%M:%S")

plot(dttime,
     hh_df_feb$Sub_metering_1,
     col = "black",
     type = "l",
     ylab = "Energy sub metering",
     xlab = "",
     xaxt = "n"
)

lines(dttime, hh_df_feb$Sub_metering_2, col = "red")
lines(dttime, hh_df_feb$Sub_metering_3, col = "blue")

legend("topright", legend = c("Sub_metering_1",
                              "Sub_metering_2",
                              "Sub_metering_3"),
       lty = 1, col = c("black", "red", "blue"),
       cex = 0.8)

axis.POSIXct(1, at = as.Date(dttime), format = "%a")

dev.off()

