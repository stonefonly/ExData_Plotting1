# Read in records for the 2-day period only, and update column names
data=read.csv2('household_power_consumption.txt',dec='.',
               na.strings = "\\?", stringsAsFactors=F,
               skip=66637,header=F,nrows=2880)
names(data)=names(read.csv2('household_power_consumption.txt',
                            header=T,nrows=1) )

# Merge Date and Time to generate new Time in POSIXlt type,
# and convert Date to date type.
data$Time=strptime(with(data,paste(Date,Time)),format='%d/%m/%Y %H:%M:%S')
data$Date=as.Date(data$Date,format="%d/%m/%Y")

# Generate plot and output to png file
png('plot2.png',width = 480, height = 480)
plot(data$Time,data$Global_active_power,type='l',
     xlab="",ylab="Global Active Power (kilowatts)" )
dev.off()