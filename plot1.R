#read file 
EPC_data<-read.table(file = "./household_power_consumption.txt",sep = ";",header = TRUE)

#describe data
str(EPC_data)
head(EPC_data)
summary(EPC_data)

#replace ? by NAs
EPC_data[EPC_data=='?']<-NA

#Extract Date/Time
EPC_data$sDT <-paste(EPC_data$Date,EPC_data$Time)
EPC_data$DateTime<-strptime(EPC_data$sDT,format = "%d/%m/%Y %H:%M:%S")

#Get the working subset
dataLimitStart<-as.POSIXct("2007-02-01 00:00:00")
dataLimitEnd<-as.POSIXct("2007-02-02 23:59:59")
EPC_data<-subset(x = EPC_data, subset = (EPC_data$DateTime>=dataLimitStart & EPC_data$DateTime<=dataLimitEnd))

#Change format variables to numeric
str(EPC_data)
EPC_data$Global_active_power<-as.numeric(as.character(EPC_data$Global_active_power))
EPC_data$Global_reactive_power<-as.numeric(as.character(EPC_data$Global_reactive_power))
EPC_data$Voltage<-as.numeric(as.character(EPC_data$Voltage))
EPC_data$Global_intensity<-as.numeric(as.character(EPC_data$Global_intensity))
EPC_data$Sub_metering_1<-as.numeric(as.character(EPC_data$Sub_metering_1))
EPC_data$Sub_metering_2<-as.numeric(as.character(EPC_data$Sub_metering_2))


#Plot1
par(mfcol=c(1,1))
hist(EPC_data$Global_active_power,main = "Global Active Power",xlab = "Global Active Power (kilowatts)",col = "Red")
dev.copy(png,file="plot1.png",width = 480,height = 480)
dev.off()
