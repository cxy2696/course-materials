hw8 <- read.csv(file.choose(), header=TRUE)

hw8Model <- lm(ahe~age+female+bachelor, hw8)
summary(hw8Model, robust=T)


hw8Model_log_lin <- lm(log(ahe)~age+female+bachelor, hw8)
summary(hw8Model_log_lin, robust=T)


hw8Model_log_log <- lm(log(ahe)~log(age)+female+bachelor, hw8)
summary(hw8Model_log_log, robust=T)

hw8Model_2 <- lm(ahe~age+I(age*age)+female+bachelor, hw8)
summary(hw8Model_2)

hw8Model_log_lin_2 <- lm(log(ahe)~age+female+bachelor+I(age*female), hw8)
summary(hw8Model_log_lin_2)

1.660198 + 0.034636 * 40 + 0.309802 + 0.426673 - 0.016767 * 40




