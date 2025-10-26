install.packages("matchingMarkets")
library(matchingMarkets)
############################
# Part I
alice<-c(1,2,3,4)
bob<-c(1,2,3,4)
carol<-c(2,1,4,3)
denis<-c(2,1,4,3)
matrix_prefs<-matrix(c(alice, bob, carol, denis), 4,4)
dictators <- c(1,2,3,4)
results <- matrix(0, 4, 4)
nSlots<-c(1,1,1,1)
first_prefs <- matrix(c(matrix_prefs[1,]))
count_first <- 0
second_prefs <- matrix(c(matrix_prefs[2,]))
third_prefs <- matrix(c(matrix_prefs[3,]))
fourth_prefs <- matrix(c(matrix_prefs[4,]))
count_second <- 0
count_third <- 0
count_fourth <- 0

for (i in 1:10000) {
    order <- sample(dictators)
    assignment <- rsd(prefs = matrix_prefs, priority = order, nSlots = nSlots)
    for (i in 1:4) {
        results[i, assignment[i,2]] <- results[i, assignment[i,2]]+1
        }

    first_choice <- matrix(c(ifelse(first_prefs == assignment[,2], 1, 0)))
    count_first <- count_first + sum(first_choice)
    second_choice <- matrix(c(ifelse(second_prefs == assignment[,2], 1, 0)))
    count_second <- count_second + sum(second_choice)
    third_choice <- matrix(c(ifelse(third_prefs == assignment[,2], 1, 0)))
    count_third <- count_third + sum(third_choice)
    fourth_choice <- matrix(c(ifelse(fourth_prefs == assignment[,2], 1, 0)))
    count_fourth <- count_fourth + sum(fourth_choice)
}

results <- results/10000
count_first <- count_first/10000
count_second <- count_second/10000
count_third <- count_third/10000
count_fourth <- count_fourth/10000
print(results)
#######################################
# Part II
n_students <- 60
n_schools <- 4
n_slots <- c(10, 20, 15, 15)  # School capacities
schools <- 1:n_schools  # School IDs
students <- 1:n_students  # Student IDs 
n_simulations <- 5000

# Fixed school priorities
school_priority <- matrix(0, n_students, n_schools)
for (i in 1:n_schools) {
  school_priority[, i] <- sample(students)
}

# Initialize counters for DA and TTC
da_first <- da_second <- da_third <- 0
ttc_first <- ttc_second <- ttc_third <- 0

# Run 5,000 simulations
set.seed(123)  # For reproducibility
for (sim in 1:n_simulations) {
  # Random student preferences for this iteration
  student_preferences <- matrix(0, n_schools, n_students)
  for (i in 1:n_students) {
    student_preferences[, i] <- sample(schools)
  }
  
  # Run DA
  res_da <- hri(s.prefs = student_preferences, c.prefs = school_priority, nSlots = n_slots)
  da_matchings <- res_da[["matchings"]]
  
  # Debug: Check structure in first iteration
  if (sim == 1) {
    print("DA Matchings Structure (First Iteration):")
    print(str(da_matchings))
  }
  
  da_assignments <- rep(NA, n_students)  # Initialize with NA
  # Use correct column names and convert to numeric
  for (i in 1:nrow(da_matchings)) {
    if (da_matchings[i, "matching"] == 1) {  # Filter for final matching
      student_id <- as.numeric(da_matchings[i, "student"])
      school_id <- as.numeric(da_matchings[i, "college"])
      da_assignments[student_id] <- school_id
    }
  }
  
  # Debug: Print da_assignments in the first iteration
  if (sim == 1) {
    print("DA Assignments (First Iteration):")
    print(da_assignments)
  }
  
  # Count preferences for DA with debug
  for (i in 1:n_students) {
    assigned_school <- da_assignments[i]
    if (is.na(assigned_school)) next  # Skip unassigned (shouldn't happen)
    prefs <- student_preferences[, i]
    if (sim == 1 && i <= 2) {
      print(paste("Student", i, "Assigned:", assigned_school, "Prefs:", paste(prefs, collapse=" ")))
    }
    if (assigned_school == prefs[1]) da_first <- da_first + 1
    else if (assigned_school == prefs[2]) da_second <- da_second + 1
    else if (assigned_school == prefs[3]) da_third <- da_third + 1
  }
  
  # Run TTC
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

# Averages
da_first_avg <- da_first / n_simulations
da_second_avg <- da_second / n_simulations
da_third_avg <- da_third / n_simulations
ttc_first_avg <- ttc_first / n_simulations
ttc_second_avg <- ttc_second / n_simulations
ttc_third_avg <- ttc_third / n_simulations

# Results table
results_table <- matrix(c(da_first_avg, da_second_avg, da_third_avg, 
                          ttc_first_avg, ttc_second_avg, ttc_third_avg), 
                        nrow = 2, byrow = TRUE)
rownames(results_table) <- c("DA", "TTC")
colnames(results_table) <- c("First", "Second", "Third")
print("Average Number of Students per Preference (Part II):")
print(results_table)
