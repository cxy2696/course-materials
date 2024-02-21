# earnheight

earnheight <- read.csv(file.choose(),header=TRUE)
summary(earnheight)
head(earnheight)

earnheightModel<-lm(earnings~sex, data=earnheight)
summary(earnheightModel)

