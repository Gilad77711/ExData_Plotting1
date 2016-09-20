##Reading, Cleaning and arranging the data:
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
Data_NAMES<-read.table(unz(temp, "household_power_consumption.txt"),sep=";",nrow=1,header=F)
Data_raw<-read.table(unz(temp, "household_power_consumption.txt"),sep=";",skip=60000,nrow=10000,header=F)
View(Data_raw)
Data<-Data_raw[6638:9517,]
View(Data)
names(Data)=c("Date","Time","Global_active_power", "Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
View(Data)

install.packages("lubridate")
library(lubridate)
Data$dateform <- as.Date(Data[,1],format="%m/%d/%Y")
Data$Day<-wday(Data$dateform, label=TRUE)
View(Data)

##Changing the variables to numeric variables
Data$Global_active_power<-as.numeric(as.character(Data$Global_active_power))
Data$Voltage<-as.numeric(as.character(Data$Voltage))
Data$Sub_metering_1<-as.numeric(as.character(Data$Sub_metering_1))
Data$Sub_metering_2<-as.numeric(as.character(Data$Sub_metering_2))
Data$Sub_metering_3<-as.numeric(as.character(Data$Sub_metering_3))
Data$Global_reactive_power<-as.numeric(as.character(Data$Global_reactive_power))

##Plotting:

##Plot1
png('plot1.jpg')
hist(Data$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
dev.off()
