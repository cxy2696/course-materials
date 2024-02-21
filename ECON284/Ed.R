distanceData<-read.csv(file.choose(),header=TRUE)
summary(distanceData)
head(distanceData)

distanceModel<-lm(Ed~Dist, data=distanceData)
summary(distanceModel)