getwd()
ads=read.csv("ads.csv")
head(ads)
names(ads[1])="display"
head(ads)
boxplot(ads)
library(dplyr)
ads1= ads %>% rename(Ad=ï..Ad)
boxplot(ads1)
head(ads1)
a1=aov(Sales~Ad,data=ads1)
summary(a1)
plot(a1)
a2=TukeyHSD(a1)
summary(a2)
a2
plot(a2)
install.packages('agricolae')
library(agricolae)
a4=HSD.test(a1,"Ad",group=FALSE)
a4
diffograph(a4, main=NULL,color1="blue",color2="red",color3="black",
           cex.axis=0.8,las=1,pch=20,bty="l",cex=0.8,lwd=1,xlab="",ylab="")


