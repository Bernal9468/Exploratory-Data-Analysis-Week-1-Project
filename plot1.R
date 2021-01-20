unzip('exdata_data_household_power_consumption.zip')
fileName <- 'household_power_consumption.txt'
library(data.table)
power <- fread(input = fileName, sep = ';', na.strings = '?')
power[, DateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]
subpower <- subset(power, power$Date == '1/2/2007' | power$Date == '2/2/2007')

subpower$Global_active_power <- as.numeric(subpower$Global_active_power)
png('plot1.png', width = 480, height = 480)
f1 <- hist(subpower$Global_active_power, col = 'red', xlab = 'Global active power (kilowatts)',
           main = 'Global active power')
dev.off()
