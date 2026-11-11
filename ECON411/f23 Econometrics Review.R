# --- Shared setup (data paths + package checks) -----------------------------
source("_setup.R")
require_packages(c("corrplot", "lmtest", "sandwich", "stargazer"))

# Review of simple, multiple, and log regressions for Econometrics.

#Simple Regression
#Download data set "caschool" and import it using "Text(readr)"
#Run simple regression

3.851/(2*0.04231)

caschool <- read_data("caschool.csv")

MyModel1<-lm(testscr~str, caschool)
summary(MyModel1)

#Use heteroscedasticity-robust standard error calculations.
#Intall package "RCurl"
#Download and run "robust.R" R script.  "summary.lm" and "url_robust" should appear in the upper right pane.

robust_summary(MyModel1)

# Omitted Variable Bias
#What happens when we add another explanatory variable?  For example, #the variable "el_pct" which represents the percent of students for #whom English is a second language 

MyModel2<-lm(testscr~str+el_pct, caschool)
robust_summary(MyModel2)

#What changed?

# OVB - MyModel1 was subject to Omitted Variable Bias.  Omiitted variable in this case was el_pct

#OVB conditions
# 1.  omitted variable is a determinant of the dependent variable
# 2.  omitted variable is correlated with included variable

# Condition 1.  The following regression shows the el_pct is a determinant of testscr.

MyModel2<-lm(testscr~str+el_pct, caschool)
robust_summary(MyModel2)

# Condition 2. We can verify the second condition by calculating a correlation coefficient or by running a regression of one of the independent variables on the other.

cor(caschool$str,caschool$el_pct)

corModel<-lm(str~el_pct,caschool)
robust_summary(corModel)

#Multicollinearity
#Imperfect multicollinearity
#Import data set "mlb1"
mlb1 <- read_data("mlb1.csv")

mlbModel1<-lm(lsalary~years+gamesyr+bavg+hrunsyr+rbisyr,data=mlb1) 
robust_summary(mlbModel1)

mlbModel2<-lm(lsalary~years+gamesyr+bavg+rbisyr,data=mlb1)
robust_summary(mlbModel2)

mlbModel3<-lm(lsalary~years+gamesyr+bavg+hrunsyr,data=mlb1)
robust_summary(mlbModel3)

submlb1<-subset(mlb1, select=c(bavg, hrunsyr, rbisyr))

cor(submlb1)

pairs(submlb1,pch=16)

#install package "corrplot"

library(corrplot)
corrplot(cor(submlb1), method="circle")

# Conduct F-test of joint significance of the collinear performance variables

mlbunrestricted<-mlbModel1<-lm(lsalary~years+gamesyr+bavg+hrunsyr+rbisyr,data=mlb1)
mlbrestricted<-mlbModel1<-lm(lsalary~years+gamesyr,data=mlb1)

anova(mlbunrestricted, mlbrestricted)

#heteroscedasticity-robust F -test
library(lmtest)
library(sandwich)

waldtest(mlbrestricted, mlbunrestricted, vcov=vcovHC(mlbunrestricted))

#############################
#Non-linear functional forms
############################

plot(testscr~str, caschool)

plot(testscr~avginc, caschool)

linModel<-lm(testscr~avginc,caschool)
robust_summary(linModel)

abline(linModel, col="red")

QuadModel<-lm(testscr~avginc+I(avginc^2), caschool)
robust_summary(QuadModel)

# add quatratic function to the plot - we didn't do this in 284, so the code might not make sense.
order_id <- order(caschool$avginc)

lines(x = caschool$avginc[order_id], 
      y = fitted(QuadModel)[order_id],
      col = "blue", 
      lwd = 2) 

anova(linModel,QuadModel)

abline(linModel, col="red")

#CubicModel<-lm(testscr~avginc+I(avginc^2)+I(avginc^3), caschool)
#summary(CubicModel,robust=T)

#anova(CubicModel,linModel )
#anova(CubicModel,QuadModel )

#logarithmic models

linlin<-lm(testscr~avginc, caschool)
robust_summary(linlin)

linlog<-lm(testscr~I(log(avginc)), caschool)
robust_summary(linlog)

loglin<-lm(I(log(testscr))~avginc, caschool)
robust_summary(loglin)

loglog<-lm(I(log(testscr))~I(log(avginc)), caschool)
robust_summary(loglog)

caschool$lavginc<-log(caschool$avginc)

plot(testscr~lavginc, caschool)
abline(lm(caschool$testscr~caschool$lavginc), col="red") 

##########################################
# Making nice tables with "stargazer"
# https://docs.google.com/document/d/1lHabSqqnoMRp05tWFjudHwGu_1mV9cyK-XpoV16Weqw/edit
#########################################

# Descriptive statistics
library(stargazer)
stargazer(as.data.frame(caschool), type="html", title="Table 1. Descriptive Statistics",out="MyTable1.htm")

# Regression Results

stargazer(MyModel2, type="html", title="Table 2. Regression Results", report = "vcsp*", notes="",out="MyTable2.htm")

