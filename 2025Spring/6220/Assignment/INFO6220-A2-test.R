# Install and load required package
install.packages("matchingMarkets")
library(matchingMarkets)

# Set seed for reproducibility
set.seed(123)

# Define simulation parameters
n_schools <- 4
n_students <- 60
school_capacities <- c(5, 40, 15, 10) # Capacities for schools 1, 2, 3, 4
n_simulations <- 5000
preference_weights <- c(5, 1, 2, 3) # Weights for student preferences

# Initialize matrices to store results
stb_results <- matrix(0, nrow = n_simulations, ncol = 3)
mtb_results <- matrix(0, nrow = n_simulations, ncol = 3)
stb_least <- numeric(n_simulations)
mtb_least <- numeric(n_simulations)

# Create school priority matrix (rows = students, columns = schools)
school_priorities <- matrix(NA, nrow = n_students, ncol = n_schools)
# School 1: Students 1-15 (1), 16-30 (2), 31-45 (3), 46-60 (4)
school_priorities[1:15, 1] <- 1; school_priorities[16:30, 1] <- 2
school_priorities[31:45, 1] <- 3; school_priorities[46:60, 1] <- 4
# School 2: Students 46-60 (1), 1-15 (2), 16-30 (3), 31-45 (4)
school_priorities[46:60, 2] <- 1; school_priorities[1:15, 2] <- 2
school_priorities[16:30, 2] <- 3; school_priorities[31:45, 2] <- 4
# School 3: Students 31-45 (1), 46-60 (2), 1-15 (3), 16-30 (4)
school_priorities[31:45, 3] <- 1; school_priorities[46:60, 3] <- 2
school_priorities[1:15, 3] <- 3; school_priorities[16:30, 3] <- 4
# School 4: Students 16-30 (1), 31-45 (2), 46-60 (3), 1-15 (4)
school_priorities[16:30, 4] <- 1; school_priorities[31:45, 4] <- 2
school_priorities[46:60, 4] <- 3; school_priorities[1:15, 4] <- 4

# Custom Deferred Acceptance function (student-proposing, uses school_priorities)
deferred_acceptance <- function(student_prefs, school_prefs, capacities) {
  # Initialize assignments: NA means unassigned
  student_assignments <- rep(NA, n_students)
  school_assignments <- vector("list", n_schools)
  for (s in 1:n_schools) {
    school_assignments[[s]] <- numeric(0) # Empty list of students per school
  }
  
  # Track which schools each student has proposed to
  proposed_to <- matrix(FALSE, nrow = n_students, ncol = n_schools)
  
  # Continue until all students are assigned or have exhausted preferences
  while (any(is.na(student_assignments))) {
    # For each unassigned student
    for (student in 1:n_students) {
      if (!is.na(student_assignments[student])) next # Skip if already assigned
      
      # Find the next school to propose to
      for (rank in 1:n_schools) {
        school <- student_prefs[rank, student]
        if (!proposed_to[student, school]) {
          proposed_to[student, school] <- TRUE
          break
        }
      }
      
      # If no more schools to propose to, student remains unassigned (shouldn't happen with enough capacity)
      if (rank > n_schools) next
      
      # School decides whether to accept the student
      current_students <- school_assignments[[school]]
      if (length(current_students) < capacities[school]) {
        # School has space, accept the student
        school_assignments[[school]] <- c(current_students, student)
        student_assignments[student] <- school
      } else {
        # School is full, compare priorities using school_prefs (school_priorities with tie-breaking)
        current_priorities <- school_prefs[current_students, school]
        new_priority <- school_prefs[student, school]
        worst_priority <- max(current_priorities)
        worst_student_idx <- which.max(current_priorities)
        
        if (new_priority < worst_priority) { # Lower priority value = higher priority
          # Reject the worst student, accept the new student
          worst_student <- current_students[worst_student_idx]
          school_assignments[[school]] <- c(current_students[-worst_student_idx], student)
          student_assignments[worst_student] <- NA
          student_assignments[student] <- school
        }
      }
    }
  }
  
  return(student_assignments)
}

# Simulation loop
for (i in 1:n_simulations) {
  # Create student preference matrix (rows = schools, columns = students)
  student_prefs <- matrix(NA, nrow = n_schools, ncol = n_students)
  for (j in 1:n_students) {
    student_prefs[, j] <- sample(1:n_schools, size = n_schools, replace = FALSE, prob = preference_weights)
  }
  
  # Single Tie-Breaking (STB): One centralized lottery
  stb_lottery <- sample(1:n_students)
  stb_priorities <- matrix(NA, nrow = n_students, ncol = n_schools)
  for (s in 1:n_schools) {
    stb_priorities[, s] <- school_priorities[, s] + (stb_lottery / (n_students + 1))
  }
  
  # Run custom DA with STB
  stb_assignments <- deferred_acceptance(student_prefs, stb_priorities, school_capacities)
  
  # Count preferences
  for (j in 1:n_students) {
    assigned_school <- stb_assignments[j]
    if (is.na(assigned_school)) next
    rank <- which(student_prefs[, j] == assigned_school)
    if (length(rank) == 0) next
    if (rank == 1) stb_results[i, 1] <- stb_results[i, 1] + 1
    else if (rank == 2) stb_results[i, 2] <- stb_results[i, 2] + 1
    else if (rank == 3) stb_results[i, 3] <- stb_results[i, 3] + 1
    else if (rank == 4) stb_least[i] <- stb_least[i] + 1
  }
  
  # Multiple Tie-Breaking (MTB): Separate lottery per school
  mtb_priorities <- matrix(NA, nrow = n_students, ncol = n_schools)
  for (s in 1:n_schools) {
    mtb_lottery <- sample(1:n_students)
    mtb_priorities[, s] <- school_priorities[, s] + (mtb_lottery / (n_students + 1))
  }
  
  # Run custom DA with MTB
  mtb_assignments <- deferred_acceptance(student_prefs, mtb_priorities, school_capacities)
  
  # Count preferences
  for (j in 1:n_students) {
    assigned_school <- mtb_assignments[j]
    if (is.na(assigned_school)) next
    rank <- which(student_prefs[, j] == assigned_school)
    if (length(rank) == 0) next
    if (rank == 1) mtb_results[i, 1] <- mtb_results[i, 1] + 1
    else if (rank == 2) mtb_results[i, 2] <- mtb_results[i, 2] + 1
    else if (rank == 3) mtb_results[i, 3] <- mtb_results[i, 3] + 1
    else if (rank == 4) mtb_least[i] <- mtb_least[i] + 1
  }
}

# Compute average results
stb_avg <- colMeans(stb_results)
mtb_avg <- colMeans(mtb_results)
stb_least_avg <- mean(stb_least)
mtb_least_avg <- mean(mtb_least)

# Print results in table format
print_table <- function(stb_avg, mtb_avg, stb_least_avg, mtb_least_avg) {
  cat("\nSimulation Results with Customized DA \n")
  cat("| Preference | STB (Average) | MTB (Average) |\n")
  cat("|------------|---------------|---------------|\n")
  cat(sprintf("| 1st        | %.4f         | %.4f         |\n", stb_avg[1], mtb_avg[1]))
  cat(sprintf("| 2nd        | %.4f         | %.4f         |\n", stb_avg[2], mtb_avg[2]))
  cat(sprintf("| 3rd        | %.4f         | %.4f         |\n", stb_avg[3], mtb_avg[3]))
  cat(sprintf("| 4th        | %.4f         | %.4f         |\n", stb_least_avg, mtb_least_avg))
  cat("\n")
}

# Print results
print_table(stb_avg, mtb_avg, stb_least_avg, mtb_least_avg)

