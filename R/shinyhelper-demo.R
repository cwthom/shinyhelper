#' Launch the Example App
#' 
#' An example app demonstrating the use of the \code{shinyhelper} package.
#' 
#' @export
#' 
#' @examples 
#' \dontrun{
#' if (interactive()) {
#'   shinyhelperDemo()
#' }
#' }
#' 
shinyhelperDemo <- function() {
  
  if (!requireNamespace(package = "shinyhelper")) {
    message("Package 'shinyhelper' is required to run this function")
  }
  
  shiny::runApp(system.file("example", package = "shinyhelper", mustWork = TRUE))
}
