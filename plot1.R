library(dplyr)
library(lubridate)


# beginning index: start of 2007-2-1 - 1
i0 <- grep('1/2/2007', readLines('household_power_consumption.txt'))[1] - 1
# ending index: start of 2007-2-3 - 1
i1 <- grep('3/2/2007', readLines('household_power_consumption.txt'))[1] - 1

# reading only the desired dates from the csv dataset while skipping the rest. 
# variable names set according to description
data <- tibble(read.csv('household_power_consumption.txt',
                        header = FALSE,
                        sep = ';', 
                        skip = i0, 
                        nrow = i1 - i0,
                        col.names = c('Date', 'Time', 'Global_active_power', 'Global_reactive_power', 'Voltage', 'Global_intensity', 'Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3')))

# combining Date & Time columns into a DateTime column with DateTime class.
data <- data %>% mutate(Date = dmy_hms(paste(data$Date, data$Time))) %>% select(-Time) %>% rename(DateTime = Date)

## PLOT 1
png(filename = 'plot1.png')
hist(data$Global_active_power, col = 'red', main = 'Global Active Power', xlab = 'Global Active Power (kilowatts)')
dev.off()
