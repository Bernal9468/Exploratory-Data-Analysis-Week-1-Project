setwd('D:/Google drive/R/Exploratory data analysis/project 1')
unzip('exdata_data_household_power_consumption.zip')
fileName <- list.files(full.names = TRUE)[2]
library(data.table)
power <- fread(input = fileName, sep = ';', na.strings = '?')
power[, DateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]
subpower <- subset(power, power$Date == '1/2/2007' | power$Date == '2/2/2007')

png('plot3.png', width = 480, height = 480)
f3 <- plot(subpower$DateTime, subpower$Sub_metering_1, type = 'n', xlab = '', 
           ylab = 'Energy sub metering')
legend('topright', lty = 1, col = c('black', 'red', 'blue'),
       legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))
title(main = 'Energy sub-metering')
with(subpower, lines(DateTime, Sub_metering_1))
with(subpower, lines(DateTime, Sub_metering_2, col = 'red'))
with(subpower, lines(DateTime, Sub_metering_3, col = 'blue'))
dev.off()