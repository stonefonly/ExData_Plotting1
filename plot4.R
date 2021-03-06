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
png('plot4.png',width = 480, height = 480)
par(mfcol = c(2,2))

plot(data$Time,data$Global_active_power,type='l',
     xlab="",ylab="Global Active Power" )

plot(data$Time,data$Sub_metering_1,type='l',col='black',
     xlab="",ylab="Energy sub metering" )
lines(data$Time,data$Sub_metering_2,type='l',col='red')
lines(data$Time,data$Sub_metering_3,type='l',col='blue')
legend('topright',lty=1,col=c('black','red','blue'),bty='n',
       legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3') )

plot(data$Time,data$Voltage,type='l',
     xlab='datetime',ylab='Voltage')

plot(data$Time,data$Global_reactive_power,type='l',
     xlab='datetime',ylab='Global_reactive_power')

dev.off()