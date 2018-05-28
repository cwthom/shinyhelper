#' Helper function to be run interactively - it will initialise a directory of
#' help files (.md files) in help_dir, using the vector of ids. Pass it a vector
#' of ids corresponding to the inputId and outputId in your shiny app
#' @export
#' @param ids A character vector of ids to use
#' @param help_dir A character string of the directory to use for help files
#' @examples 
#' \dontshow{
#' create_help_files(ids = c("xcol", "plot1"), help_dir = tempdir())
#' }
#' \donttest{
#' create_help_files(ids = c("xcol", "plot1", help_dir = "helpfiles"))
#' }
create_help_files <- function(ids, help_dir) {
  
  if (!dir.exists(help_dir)) 
    stop(paste(help_dir, "does not appear to exist."))
  
  for (id in ids) {
    
    file <- paste0(help_dir, "/", id, ".md")
    
    if (!file.exists(file)) {
      file.create(file)
      writeLines(text = c(paste("###", id, "- Under Development \n"),
                          "*** \n",
                          "This helpfile is currently under development. \n"),
                 con = file)
    }
  }
}
