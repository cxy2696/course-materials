# Shared setup for the R scripts in this folder.
# Resolves the repository root, then loads R/course_utils.R.
COURSE_DIR <- tryCatch(
  dirname(normalizePath(sys.frame(1)$ofile)),
  error = function(e) getwd()
)
if (is.null(COURSE_DIR) || !nzchar(COURSE_DIR)) {
  COURSE_DIR <- getwd()
}

.find_repo_root <- function(path) {
  repeat {
    if (file.exists(file.path(path, "R", "course_utils.R"))) {
      return(path)
    }
    parent <- dirname(path)
    if (identical(parent, path)) {
      return(NULL)
    }
    path <- parent
  }
}

.REPO_ROOT <- .find_repo_root(COURSE_DIR)
if (is.null(.REPO_ROOT)) {
  stop("Could not locate R/course_utils.R above ", COURSE_DIR, call. = FALSE)
}
source(file.path(.REPO_ROOT, "R", "course_utils.R"))
