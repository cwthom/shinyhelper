#' Create Directory of Help Files
#' 
#' Helper function to be run interactively - it will initialise a directory of
#' help files (.md files) in help_dir, using the vector of ids. Pass it a vector
#' of ids corresponding to the inputId and outputId in your shiny app.
#' 
#' @export
#' 
#' @param files A character vector of names to use in creating help files.
#' @param help_dir A character string of the directory to use for help files.
#' 
#' @examples 
#' create_help_files(files = c("Clusters", "Columns", "PlotHelp"), 
#'                   help_dir = "helpfiles")
#' 
create_help_files <- function(files, help_dir = "helpfiles") {
  
  if (!interactive()) {
    message("Must be called from an interactive session")
    return(invisible(files))
  }
  
  if (!dir.exists(help_dir)){
    message("* Creating directory `", help_dir, "`.")
    dir.create(help_dir)
  }
  
  files <- file.path(help_dir, paste0(files, ".md"))
  
  new_file <- function(file) {
    
    if (!file.exists(file)){
      file.create(file)
      writeLines(text = c(paste("###", file, "- Under Development\n"),
                          "***\n\nThis helpfile is under not finished yet\n"),
                 con = file)
    } else {
      message("* `", file, "` already exists - not overwriting")
    }
    
  }
  
  lapply(files, new_file)
  return(invisible(files))
  
}
