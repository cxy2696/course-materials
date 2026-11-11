# --- Shared setup (data paths + package checks) -----------------------------
source("_setup.R")

# Lecture examples for Stock & Watson: class size, wage gaps, and beer taxes.

#cashool data
caschool <- read_data("caschool.csv")
summary(caschool)
head(caschool)

plot(testscr~str, data=caschool)

MyModel<-lm(testscr~str, data=caschool)
summary(MyModel)
robust_summary(MyModel) # to see if heteroskedasticity exist

-2.2798-1.96*0.4798
-2.2798+1.96*0.4798

-2.2798-2.58*0.4798
-2.2798+2.58*0.4798

confint(MyModel)
confint(MyModel, level=0.9)
confint(MyModel, level=0.99)

model2<-lm(testscr~str+el_pct, data=caschool)
summary(model2)
robust_summary(model2)

cor(subset(caschool, select=c(str, el_pct)))

###########################################
linModel<-lm(testscr~avginc, caschool)
robust_summary(linModel)

plot(testscr~avginc, caschool)
abline(linModel, col="red")

hist(caschool$avginc)

# Alternatively
quadModel<-lm(testscr~avginc+I(avginc^2), caschool) # I() produce a number variable
robust_summary(quadModel)

# Add quatratic function to the plot
order_id<-order(caschool$avginc)
lines(x=caschool$avginc[order_id],
      y=fitted(quadModel)[order_id],
      col="blue",
      lwd=2)

# F-test
anova(quadModel, linModel)


################################
linlin<-lm(testscr~avginc, caschool)
robust_summary(linlin)

linlog<-lm(testscr~I(log(avginc)), caschool)
robust_summary(linlog)

loglin<-lm(I(log(testscr))~avginc, caschool)
robust_summary(loglin)

loglog<-lm(I(log(testscr))~I(log(avginc)), caschool)
robust_summary(loglog)

#################################
wageData <- read_data("wageData.CSV")
wageModel<-lm(wage~female+exper+I(exper*female), wageData)
robust_summary(wageModel)

###############################
# fatality
fatality <- read_data("fatality.csv")
# Fixed Effect Model
# Transform mrall to be deaths per 1,000,000
fatality$mrall2 = fatality$mrall*1000000

# create subset for 1982
f1982<-subset(fatality, year==1982)

# regress mrall2 on beertax
fm1982<-lm(mrall2~beertax, f1982)
robust_summary(fm1982)

# plot mrall2 vs beertax
plot(mrall2~beertax, f1982)
abline(fm1982, lwd=3, col='red')


fstate<-lm(mrall2~beertax+state, fatality)
summary(fstate)

fstate_0<-lm(mrall2~0+beertax+state, fatality)
summary(fstate_0)


fyear<-lm(mrall2~0+beertax+factor(year), fatality)
summary(fyear)






