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
##Plot3
png('plot3.png',width=480,height=480)
xticks <- seq(0, 2880, 1440)
plot(seq(0,2880,length.out=10000),seq(0,38,length.out=10000),xaxt="n",type="n",ylab="Energy sub metering",xlab="")
lines(Data$Sub_metering_1,type="l",xaxt="n")
lines(Data$Sub_metering_2,type="l",xaxt="n",col="red")
lines(Data$Sub_metering_3,type="l" ,xaxt="n",col="blue")
axis(1, at = xticks, labels=c("Thu","Fri","Sat"))
legend_names<-c("sub_metering_1","sub_metering_2","sub_metering_3")
legend("topright",legend=legend_names, col = c("black", "red", "blue"), lty=c(1,1,1),
       cex = 0.5)
dev.off()

