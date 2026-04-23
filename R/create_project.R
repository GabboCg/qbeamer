#' Create a new qbeamer presentation project
#'
#' RStudio project template binding. Called by RStudio when a user creates
#' a new project from the qbeamer template. Can also be called directly.
#'
#' @param path Path to the new project directory.
#' @param title Presentation title. Used by RStudio project wizard.
#' @param ... Additional arguments passed by RStudio (ignored).
#'
#' @return Invisibly returns the project path.
#' @export
create_project <- function(path, title = "Untitled Presentation", ...) {
  fs::dir_create(path)

  # Copy skeleton QMD and substitute title
  skeleton <- system.file("rstudio", "templates", "project", "skeleton",
                           "skeleton.qmd", package = "qbeamer", mustWork = TRUE)
  content <- readLines(skeleton, encoding = "UTF-8")
  content <- gsub("Untitled Presentation", title, content, fixed = TRUE)
  writeLines(content, fs::path(path, "skeleton.qmd"), useBytes = TRUE)

  # Install the Quarto extension
  install_extension(path = path)

  invisible(path)
}
