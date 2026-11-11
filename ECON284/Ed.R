# --- Shared setup (data paths + package checks) -----------------------------
source("_setup.R")

# Simple regression of education on distance (dataset not included in the repo).

# The distance dataset is not redistributed with the course materials.
# Supply it with ECON284_DISTANCE_DATA=/path/to/distance.csv
distanceData <- read_env_data("ECON284_DISTANCE_DATA", "distance.csv")
summary(distanceData)
head(distanceData)

distanceModel<-lm(Ed~Dist, data=distanceData)
summary(distanceModel)