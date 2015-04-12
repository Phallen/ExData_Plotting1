# Plot1.R

rm(list=ls())   # Clear out workspace

# Read data file
day1<-as.Date("2007-02-01","%Y-%m-%d")
day2<-as.Date("2007-02-02","%Y-%m-%d")

r1<-66637  # Start of first day in input file
r2<-68076  # End   of first day in input file
r3<-68077  # Start of second day in input file
r4<-69516  # End   of second day in input file, last record input

pwr <- read.csv("household_power_consumption.txt",na.strings="?",sep=";",
                colClasses=c("character","character",
                rep("numeric",7)),nrows=r4)

pwr <- pwr[r1:r4,]   # Limit data set to required data

N <- nrow(pwr)   # Number of input records used

# Add a new column to data frame containing a new POSIX time variable, "DayTime"
pwr <- cbind(pwr,as.POSIXlt(rep(0,N),origin = "1960-01-01"))
colnames(pwr)[10]<-"DayTime"

# Form DayTime POSIX variable
for (i in 1:N){
    p<-paste(pwr$Date[i],pwr$Time[i],sep=" ")  # Combine Date & Time into one string
    
    pwr$DayTime[i] <- strptime(p, "%d/%m/%Y %H:%M:%S")  # Convert to POSIX variable
}

# Create Plot

#     Open PNG device
      png(filename = "plot1.png", width = 480, height = 480, units = "px")

#     Plot Histogram
      hist( pwr$Global_active_power, col="red", main="Global Active Power", 
          xlab="Global Active Power (kilowatts)")

#     Close device
      dev.off()




      