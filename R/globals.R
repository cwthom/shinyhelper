.onLoad <- function(libname, pkgname) {
  shiny::addResourcePath(prefix = "shinyhelper",
                         directoryPath = system.file("assets",
                                                     package = "shinyhelper"))
}