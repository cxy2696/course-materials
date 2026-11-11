# --- Shared setup (data paths + package checks) -----------------------------
source("_setup.R")

# Homework 8: returns to education with log and quadratic specifications.

hw8 <- read_data("hw 8-5.CSV")

hw8Model <- lm(ahe~age+female+bachelor, hw8)
robust_summary(hw8Model)


hw8Model_log_lin <- lm(log(ahe)~age+female+bachelor, hw8)
robust_summary(hw8Model_log_lin)


hw8Model_log_log <- lm(log(ahe)~log(age)+female+bachelor, hw8)
robust_summary(hw8Model_log_log)

hw8Model_2 <- lm(ahe~age+I(age*age)+female+bachelor, hw8)
summary(hw8Model_2)

hw8Model_log_lin_2 <- lm(log(ahe)~age+female+bachelor+I(age*female), hw8)
summary(hw8Model_log_lin_2)

1.660198 + 0.034636 * 40 + 0.309802 + 0.426673 - 0.016767 * 40




