library(AER)
data(HMDA)
HMDA$deny <-as.numeric(HMDA$deny) - 1
HMDA

attach(HMDA) 
fm1 <- lm(deny ~ pirat)
summary(fm1, robust=T)

fm2 <- lm(deny ~ pirat+afam) # After correcting for P/I ratio
summary(fm2, robust=T)

fm3 <- glm(deny ~ pirat, family = binomial(link = "probit"), data = HMDA)
summary(fm3, robust=T)

fm4 <- glm(deny ~ pirat + afam, family = binomial(link = "probit"), )
summary(fm4, robust=T)

pnorm(-2.25879 + 0.3*2.74178 + 0*0.70816) 
pnorm(-2.25879 + 0.3*2.74178 + 1*0.70816)


probit_HMDA_4 <- glm(deny ~ afam + pirat + insurance + selfemp + single + hschool + unemp,,
                     family = binomial(link = "probit"), data = HMDA)
summary(probit_HMDA_4)

HMDA$afam <-as.numeric(HMDA$afam)-1
HMDA$insurance <-as.numeric(HMDA$insurance)-1
HMDA$selfemp<-as.numeric(HMDA$selfemp)-1
HMDA$single<-as.numeric(HMDA$single)-1
HMDA$hschool<-as.numeric(HMDA$hschool)-1

HMDAsubset<-subset(HMDA, select=c(afam, pirat, insurance, selfemp, single, hschool,unemp))
HMDAsubset

cor(HMDAsubset)


library(mfx)
probitmfx(deny ~ pirat + afam, 
          data=HMDA, atmean=FALSE)
########################################
