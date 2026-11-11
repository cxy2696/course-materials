# --- Shared setup (data paths + package checks) -----------------------------
source("_setup.R")
require_packages(c("lattice"))

setosa = subset(iris, Species == "setosa")
attach(setosa)
lattice::xyplot(Sepal.Length ~ Petal.Length, type = c("p","r"))
sModel = lm(Sepal.Length~Petal.Length)
summary(sModel)
plot(sModel$fitted.values,sModel$residuals)
hist(sModel$residuals)
qqnorm(sModel$residuals)
