#' Render a qbeamer presentation
#'
#' Wrapper around [quarto::quarto_render()] that checks the qbeamer extension
#' is installed before rendering.
#'
#' @param input Path to the `.qmd` file to render.
#' @param ... Additional arguments passed to [quarto::quarto_render()].
#'
#' @return The return value of [quarto::quarto_render()].
#' @export
qbeamer_render <- function(input, ...) {
  check_extension(input)
  if (!requireNamespace("quarto", quietly = TRUE)) {
    stop("Package 'quarto' is required. Install it with install.packages('quarto').",
         call. = FALSE)
  }
  quarto::quarto_render(input, ...)
}

#' Preview a qbeamer presentation
#'
#' Wrapper around [quarto::quarto_preview()] that checks the qbeamer extension
#' is installed before previewing.
#'
#' @param input Path to the `.qmd` file to preview.
#' @param ... Additional arguments passed to [quarto::quarto_preview()].
#'
#' @return The return value of [quarto::quarto_preview()].
#' @export
qbeamer_preview <- function(input, ...) {
  check_extension(input)
  if (!requireNamespace("quarto", quietly = TRUE)) {
    stop("Package 'quarto' is required. Install it with install.packages('quarto').",
         call. = FALSE)
  }
  quarto::quarto_preview(input, ...)
}

#' Check that the qbeamer extension is installed
#'
#' @param input Path to a `.qmd` file. The extension is checked relative to
#'   the file's parent directory.
#' @return `TRUE` invisibly if found; emits a message if not.
#' @noRd
check_extension <- function(input) {
  project_dir <- fs::path_dir(fs::path_abs(input))
  ext_dir <- fs::path(project_dir, "_extensions", "qbeamer")
  if (!fs::dir_exists(ext_dir)) {
    stop("qbeamer extension not found in '", project_dir, "'. ",
         "Run qbeamer::install_extension('", project_dir, "') first.",
         call. = FALSE)
  }
  invisible(TRUE)
}
