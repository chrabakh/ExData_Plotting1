# read data
datafile<-"household_power_consumption.txt";
if(!file.exists(datafile)){
temp<-tempfile();
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp,"curl");

unz(temp,datafile);
unlink(temp);
}
powerdf<-read.csv("household_power_consumption.txt",header=TRUE,sep=";");
powerdf[,1]<-as.Date(powerdf[,1], "%d/%m/%Y");
pdfeb12<-subset(powerdf,(Date=="2007-02-01") | (Date=="2007-02-02"));
#replace Date col by POSIXct for Date and Time values
pdfeb12[,1]<-as.POSIXct(strptime(paste(pdfeb12[,1],pdfeb12[,2]),"%Y-%m-%d %H:%M:%S"));
#change from factor to numeric
pdfeb12[,7]<-as.numeric(levels(pdfeb12[,7]))[pdfeb12[,7]];
pdfeb12[,8]<-as.numeric(levels(pdfeb12[,8]))[pdfeb12[,8]];

#plot active Date by submetering 1,2 and 3 
xrange<-range(pdfeb12$Date);
yrange<-range(pdfeb12$Sub_metering_1);
plot(xrange,yrange,type="n",xlab="",ylab="Energy sub mertering");
lines(pdfeb12$Date,pdfeb12$Sub_metering_3, type="l", col="blue");
lines(pdfeb12$Date,pdfeb12$Sub_metering_2, type="l", col="red");
lines(pdfeb12$Date,pdfeb12$Sub_metering_1, type="l", col="black");
legend("topright",legend=names(pdfeb12)[7:9], col=c("blue","red","black"), lty=c(1,1,1));

dev.copy(png,"plot3.png");
dev.off();