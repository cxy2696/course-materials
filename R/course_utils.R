# =============================================================================
# course_utils.R -- shared R helpers for the course-material scripts
# =============================================================================
#
# This file is loaded by the small `_setup.R` wrappers that sit next to the
# course scripts.  It keeps the scripts reproducible without hard-coded paths:
#
#   read_data("snowPetrels.csv")     read a course CSV
#   read_external("sleep.txt")       read a cached public tab-separated file
#   require_packages(c("ggplot2"))   fail early with install instructions
#   robust_summary(model)            heteroskedasticity-robust coefficient table
#   read_env_data("VAR", "file.csv") read a user-supplied dataset
#
# Data lookup searches the folder that contains `_setup.R` (and its parents),
# looking in `csv files/`, `Data/`, `data/`, `data/external/`, `Project_3/`,
# and the other course data folders.  Run a script from its own folder, or use
# the wrapper as documented in the course README.
# =============================================================================

if (!exists("COURSE_DIR", inherits = FALSE)) {
  COURSE_DIR <- getwd()
}

.find_data_file <- function(filename) {
  filename <- sub("^[/\\\\]+", "", filename)
  start_dirs <- unique(c(COURSE_DIR, getwd(), dirname(getwd())))
  subdirs <- c(
    "", "csv files", "Data", "data", "data/external", "Project_3",
    file.path("..", "ECON284", "Data"),
    file.path("..", "Applied-Statistics", "csv files"),
    file.path("..", "Applied-Statistics", "data", "external")
  )

  candidates <- character()
  for (start in start_dirs) {
    folder <- normalizePath(start, mustWork = FALSE)
    for (level in 0:4) {
      candidates <- c(candidates, file.path(folder, subdirs, filename))
      folder <- dirname(folder)
    }
  }

  hits <- candidates[file.exists(candidates)]
  if (length(hits) == 0L) {
    stop(
      sprintf("Could not find the dataset %s.\n", sQuote(filename)),
      "Place it in 'csv files/', 'Data/', or 'data/' next to the script, ",
      "or set the corresponding environment variable.",
      call. = FALSE
    )
  }
  normalizePath(hits[[1L]])
}

#' Read a comma-separated dataset shipped with the course materials.
read_data <- function(filename, ...) {
  read.csv(.find_data_file(filename), header = TRUE, ...)
}

#' Read a tab-separated public dataset cached in `data/external/`.
read_external <- function(filename, ...) {
  read.table(.find_data_file(filename), header = TRUE, ...)
}

#' Read a dataset supplied by the user, e.g. one not redistributed here.
read_env_data <- function(env_var, default_filename, ...) {
  path <- Sys.getenv(env_var, unset = default_filename)
  if (!file.exists(path)) {
    stop(
      sprintf("Could not find %s.\n", sQuote(path)),
      sprintf("Set %s to the path of the dataset, or place it in the course folder.", env_var),
      call. = FALSE
    )
  }
  read.csv(path, header = TRUE, ...)
}

#' Stop with an actionable message when required packages are missing.
require_packages <- function(packages) {
  installed <- vapply(packages, requireNamespace, logical(1), quietly = TRUE)
  if (any(!installed)) {
    stop(
      "Missing R package(s): ", paste(packages[!installed], collapse = ", "),
      "\nInstall them with:\n  install.packages(c(",
      paste0('"', packages[!installed], '"', collapse = ", "), "))",
      call. = FALSE
    )
  }
  invisible(TRUE)
}

#' Heteroskedasticity-robust coefficient table (HC1 by default).
#'
#' The original coursework used a course-local `summary(..., robust = TRUE)`
#' helper.  Base R silently ignores that argument, so this function replaces it
#' with the standard lmtest + sandwich combination.
robust_summary <- function(model, type = "HC1", ...) {
  require_packages(c("lmtest", "sandwich"))
  if (inherits(model, "plm")) {
    return(lmtest::coeftest(model, vcov. = plm::vcovHC(model, ...)))
  }
  lmtest::coeftest(model, vcov. = sandwich::vcovHC(model, type = type, ...))
}
