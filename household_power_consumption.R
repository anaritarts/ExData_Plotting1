#Set WD
setwd("C:/Users/a1silva/Desktop/Coursera/Exploratory Data Analysis/Week 1")
#Loading Data
power <- read.table("./household_power_consumption.txt",skip=1,sep=";")
head(power)
#Rename Variables 
names(power) <- c("Date","Time","Global_active_power","Global_reactive_power",
                  "Voltage","Global_intensity","Sub_metering_1","Sub_metering_2",
                  "Sub_metering_3")
#Subsetting the date, because We will only be using data from  2007-02-01 and 2007-02-02.
subpower <- subset(power, power$Date == "1/2/2007" | power$Date == "2/2/2007")

##PLOT 1
#First Plot: Global Active Power Frequency
# 1. Open png file
png("plot1.png", width = 480, height = 480)

# 2. Create the plot
hist(as.numeric(as.character(subpower$Global_active_power)),col="red",main="Global Active Power",xlab="Global Active Power(kilowatts)")

# 3. Close the file
dev.off()


##PLOT 2
#Global Active Power vs Day of week (thu, fri, sat)
#Transform  Date and Time
subpower$Date <- as.Date(subpower$Date, format = "%d/%m/%Y")
subpower$Time <- strptime(subpower$Time, format = "%H:%M:%S")

#1440 is the first half, and 1441:2880 is the second half 
subpower[1:1440, "Time"] <- format(subpower[1:1440, "Time"], "2007-02-01 %H:%M:%S")
subpower[1441: 2880, "Time"] <- format(subpower[1441:2880, "Time"], "2007-02-02 %H:%M:%S")

#create plot 2
# 1. Open png file
png("plot2.png", width = 480, height = 480)

#2. create plot
plot(subpower$Time,as.numeric(as.character(subpower$Global_active_power)),type="l",xlab="",ylab="Global Active Power (kilowatts)", main="Global Active Power VS Time")

# 3. Close the file
dev.off()


#PLOT 3 - Energy sub metering vs time 
# 1. Open png file
png("plot3.png", width = 480, height = 480)
#2. create plot 
plot(subpower$Time,subpower$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering", main = "Energy Sub Meetering VS Time")
with(subpower,lines(Time,as.numeric(as.character(Sub_metering_1))))
with(subpower,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
with(subpower,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# 3. Close the file
dev.off()


#PLOT 4 - 2 COL, 2 Rows graphs - Global Active Power, Voltage, Energy sub metering, Global reactive power
# 1. Open png file
png("plot4.png", width = 480, height = 480)

#2. create plot
# initiating a composite plot with many graphs
par(mfrow=c(2,2))

# calling the basic plot function, to create 4 different plots (Global Active Power, Voltage, Energy sub metering, Global reactive power)
with(subpower,{
    plot(subpower$Time,as.numeric(as.character(subpower$Global_active_power)),type="l",  xlab="",ylab="Global Active Power")  
    plot(subpower$Time,as.numeric(as.character(subpower$Voltage)), type="l",xlab="datetime",ylab="Voltage")
    plot(subpower$Time,subpower$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
    with(subpower,lines(Time,as.numeric(as.character(Sub_metering_1))))
    with(subpower,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
    with(subpower,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
    legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.6)
    plot(subpower$Time,as.numeric(as.character(subpower$Global_reactive_power)),type="l",xlab="datetime",ylab="Global_reactive_power")
})

# 3. Close the file
dev.off()
