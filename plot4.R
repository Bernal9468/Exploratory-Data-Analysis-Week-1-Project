unzip('exdata_data_household_power_consumption.zip')
fileName <- 'household_power_consumption.txt'
library(data.table)
power <- fread(input = fileName, sep = ';', na.strings = '?')
power[, DateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]
subpower <- subset(power, power$Date == '1/2/2007' | power$Date == '2/2/2007')
subpower$Voltage <- as.numeric(subpower$Voltage)
subpower$Global_reactive_power <- as.numeric(subpower$Global_reactive_power)

png('plot4.png', width = 480, height = 480)
par(mfrow = c(2, 2))

plot(subpower$DateTime, subpower$Global_active_power, type = 'l', xlab = '',
     ylab = 'Global Active Power')

plot(subpower$DateTime, subpower$Voltage, type = 'l', xlab = 'DateTime',
     ylab = 'Voltage')

plot(subpower$DateTime, subpower$Sub_metering_1, type = 'n', xlab = '', 
     ylab = 'Energy sub metering')
legend('topright', lty = 1, col = c('black', 'red', 'blue'),
       legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), cex = 0.5)
with(subpower, lines(DateTime, Sub_metering_1))
with(subpower, lines(DateTime, Sub_metering_2, col = 'red'))
with(subpower, lines(DateTime, Sub_metering_3, col = 'blue'))

plot(subpower$DateTime, subpower$Global_reactive_power, type = 'l',
     xlab = 'DateTime', ylab = 'Global Reactive Power')
dev.off()
