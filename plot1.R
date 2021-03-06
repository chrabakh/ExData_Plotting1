# read data
datafile<-"household_power_consumption.txt";
if(!file.exists(datafile)){
temp<-tempfile();
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp,"curl");

unzip(temp,datafile);
unlink(temp);
}
#Read file
powerdf<-read.csv("household_power_consumption.txt",header=TRUE,sep=";");
#filter by feb 1,2 
powerdf[,1]<-as.Date(powerdf[,1], "%d/%m/%Y");
pdfeb12<-subset(powerdf,(Date=="2007-02-01") | (Date=="2007-02-02"));
#replace Date col by POSIXct for Date and Time values
pdfeb12[,1]<-as.POSIXct(strptime(paste(pdfeb12[,1],pdfeb12[,2]),"%Y-%m-%d %H:%M:%S"));
#change from factor to numeric
pdfeb12[,3]<-as.numeric(levels(pdfeb12[,3]))[pdfeb12[,3]];
#open devide
png("plot1.png",width=504,height=504);
#plot active power by frequency
with(pdfeb12,hist(Global_active_power, col="red",xlab="Global Active Power (kilowatts)", main="Global Active Power"));

dev.off();
