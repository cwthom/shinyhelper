.onLoad <- function(libname, pkgname) {
  shiny::addResourcePath(prefix = "css-helper",
                         directoryPath = system.file("css-helper",
                                                     package="shinyhelper"))
}