# load the package AER and the STAR dataset
library(AER)
data(STAR)

# get an overview
head(STAR, 2)

# get variable names
#names(STAR)

# drop NA recordings for the first observation and print to the console
STAR[1, !is.na(STAR[1, ])]

# compute differences Estimates for each grades
fmk <- lm(I(readk + mathk) ~ stark, data = STAR)
summary(fmk, robust=T)
fm1 <- lm(I(read1 + math1) ~ star1, data = STAR)
summary(fm1, robust=T)
fm2 <- lm(I(read2 + math2) ~ star2, data = STAR)
summary(fm2, robust=T)
fm3 <- lm(I(read3 + math3) ~ star3, data = STAR)
summary(fm3, robust=T)

# compute robust standard errors for each model and gather them in a list
#rob_se_1 <- list(sqrt(diag(vcovHC(fmk, type = "HC1"))),
#                 sqrt(diag(vcovHC(fm1, type = "HC1"))),
#                sqrt(diag(vcovHC(fm2, type = "HC1"))),
#                sqrt(diag(vcovHC(fm2, type = "HC1"))))

library(stargazer)

#stargazer(fmk,fm1,fm2,fm3,
#         title = "Project STAR: Differences Estimates",
#         header = FALSE, 
#         type = "html",
#         model.numbers = F,
#         omit.table.layout = "n",
#         digits = 3, 
#         column.labels = c("K", "1", "2", "3"),
#         dep.var.caption  = "Dependent Variable: Reading + Math SAT",
#         dep.var.labels.include = FALSE,
#         se = rob_se_1, out="Ch13Table1.htm")

stargazer(fmk,fm1,fm2,fm3,
          title = "Project STAR: Differences Estimates",
          header = FALSE, 
          type = "html",
          model.numbers = F,
          omit.table.layout = "n",
          digits = 3, 
          column.labels = c("K", "1", "2", "3"),
          dep.var.caption  = "Dependent Variable: Reading + Math SAT",
          dep.var.labels.include = FALSE,
           out="Ch13Table1.htm")


