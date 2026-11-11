# --- Shared setup (data paths + package checks) -----------------------------
source("_setup.R")

# Earnings and height: a simple two-group comparison.

# earnheight

earnheight <- read_data("earnheight.CSV")
summary(earnheight)
head(earnheight)

earnheightModel<-lm(earnings~sex, data=earnheight)
summary(earnheightModel)

