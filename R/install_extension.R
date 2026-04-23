#' Install the qbeamer Quarto extension
#'
#' Copies the qbeamer Quarto extension files into a project directory,
#' making the `qbeamer-beamer` format available for use.
#'
#' @param path Path to the project directory. Defaults to the current
#'   working directory.
#' @param overwrite If `TRUE`, overwrite existing extension files.
#'   Defaults to `FALSE`.
#'
#' @return Invisibly returns the path to the installed extension directory.
#' @export
install_extension <- function(path = ".", overwrite = FALSE) {
  target <- fs::path(path, "_extensions", "qbeamer")

  if (fs::dir_exists(target) && !overwrite) {
    message("qbeamer extension already installed at '", target, "'. ",
            "Use overwrite = TRUE to reinstall.")
    return(invisible(target))
  }

  source <- system.file("extdata", "_extensions", "qbeamer",
                         package = "qbeamer", mustWork = TRUE)

  fs::dir_create(fs::path(path, "_extensions"))
  fs::dir_copy(source, target, overwrite = overwrite)

  message("qbeamer extension installed to '", target, "'.")
  invisible(target)
}
