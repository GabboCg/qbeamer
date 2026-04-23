.onAttach <- function(libname, pkgname) {
  packageStartupMessage("qbeamer v", utils::packageVersion("qbeamer"))
}
