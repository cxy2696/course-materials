install.packages("matchingMarkets")
library(matchingMarkets)

alice <- c(1, 2, 3, 4)
bob <- c(1, 2, 3, 4)
carol <- c(2, 1, 4, 3)
denis <- c(2, 1, 4, 3)

matrix_prefs <- matrix(c(alice, bob, carol, denis),4, 4)
dictators <- c(1, 2, 3, 4)
results <- matrix(0, 4, 4)
nslots <- c(1, 1, 1, 1)

first_prefs <- matrix_prefs[1, ]
second_prefs <- matrix_prefs[2, ]
third_prefs <- matrix_prefs[3, ]
fourth_prefs <- matrix_prefs[4, ]

# Initialize counters
count_first <- 0
count_second <- 0
count_third <- 0
count_fourth <- 0

# Run 10,000 simulations
for (i in 1:10000) {
  # Random order of dictators
  order <- sample(dictators)
  
  # Run Random Serial Dictatorship
  assignment <- rsd(prefs = matrix_prefs, priority = order, nSlots = nslots)
  
  # Update results matrix (object i assigned to person j)
  for (j in 1:4) {
    results[assignment[j, 2], assignment[j, 1]] <- results[assignment[j, 2], assignment[j, 1]] + 1
  }
  
  # Count preferences matched
  assigned_objects <- assignment[, 2]
  count_first <- count_first + sum(first_prefs == assigned_objects)
  count_second <- count_second + sum(second_prefs == assigned_objects)
  count_third <- count_third + sum(third_prefs == assigned_objects)
  count_fourth <- count_fourth + sum(fourth_prefs == assigned_objects)
}

# Convert to probabilities/averages
results <- results / 10000
count_first <- count_first / 10000
count_second <- count_second / 10000
count_third <- count_third / 10000
count_fourth <- count_fourth / 10000

# Output results
print("Probability Matrix (rows=objects, columns=individuals):")
print(results)
print(paste("Avg # people getting 1st pref:", count_first))
print(paste("Avg # people getting 2nd pref:", count_second))
print(paste("Avg # people getting 3rd pref:", count_third))
print(paste("Avg # people getting 4th pref:", count_fourth))


##################################################
# Install and load the matchingMarkets library
install.packages("matchingMarkets")
library(matchingMarkets)

# Define constants
n_students <- 60
n_schools <- 4
n_slots <- c(10, 20, 15, 15)  # School capacities
schools <- 1:n_schools  # School IDs (1, 2, 3, 4)
students <- 1:n_students  # Student IDs (1 to 60)
n_simulations <- 5000

# Generate fixed school priorities (random order of students for each school)
school_priority <- matrix(0, n_students, n_schools)
for (i in 1:n_schools) {
  school_priority[, i] <- sample(students)
}

# Initialize counters for DA and TTC
da_first <- da_second <- da_third <- 0
ttc_first <- ttc_second <- ttc_third <- 0

# Run 5,000 simulations
set.seed(123)  # For reproducibility; you can remove this
for (sim in 1:n_simulations) {
  # Generate random student preferences for this iteration
  student_preferences <- matrix(0, n_schools, n_students)
  for (i in 1:n_students) {
    student_preferences[, i] <- sample(schools)  # Random permutation of schools
  }
  
  # Run Deferred Acceptance (DA)
  res_da <- hri(s.prefs = student_preferences, c.prefs = school_priority, nSlots = n_slots)
  da_matchings <- res_da[["matchings"]]
  # Extract school assignments (cId) and map to student IDs (sId)
  da_assignments <- rep(NA, n_students)  # Initialize with NA for unassigned students
  for (i in 1:nrow(da_matchings)) {
    student_id <- da_matchings[i, "sId"]
    school_id <- da_matchings[i, "cId"]
    da_assignments[student_id] <- school_id
  }
  
  # Count preferences for DA
  for (i in 1:n_students) {
    assigned_school <- da_assignments[i]
    if (is.na(assigned_school)) next  # Skip unassigned students (shouldn't happen)
    prefs <- student_preferences[, i]
    if (assigned_school == prefs[1]) da_first <- da_first + 1
    else if (assigned_school == prefs[2]) da_second <- da_second + 1
    else if (assigned_school == prefs[3]) da_third <- da_third + 1
  }
  
  # Run Top Trading Cycles (TTC)
  res_ttc <- ttc2(s.prefs = student_preferences, c.prefs = school_priority, nSlots = n_slots)
  ttc_assignments <- res_ttc[, 2]  # Second column is school assignments
  
  # Count preferences for TTC
  for (i in 1:n_students) {
    assigned_school <- ttc_assignments[i]
    prefs <- student_preferences[, i]
    if (assigned_school == prefs[1]) ttc_first <- ttc_first + 1
    else if (assigned_school == prefs[2]) ttc_second <- ttc_second + 1
    else if (assigned_school == prefs[3]) ttc_third <- ttc_third + 1
  }
}

# Compute averages
da_first_avg <- da_first / n_simulations
da_second_avg <- da_second / n_simulations
da_third_avg <- da_third / n_simulations
ttc_first_avg <- ttc_first / n_simulations
ttc_second_avg <- ttc_second / n_simulations
ttc_third_avg <- ttc_third / n_simulations

# Print results
cat("DA Averages:\n")
cat("First: ", da_first_avg, "\nSecond: ", da_second_avg, "\nThird: ", da_third_avg, "\n")
cat("TTC Averages:\n")
cat("First: ", ttc_first_avg, "\nSecond: ", ttc_second_avg, "\nThird: ", ttc_third_avg, "\n")
