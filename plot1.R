

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

png(filename = "plot1.png",
    width = 480, height = 480)

hist(hh_df_feb$Global_active_power,
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency",
     col = "red")

dev.off()

