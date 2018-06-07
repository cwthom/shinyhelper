#' Observe Helper Action Buttons
#' 
#' Function to create a family of \code{shinyjs::onclick} event handlers, observing 
#' clicks on the \code{\link{helper}} action buttons.
#' 
#' @export
#' @param input The input object in your shiny app
#' @param output The output object in your shiny app
#' @param help_dir A character string of the directory containing your helpfiles
#' @param sizes Deprecated - set sizes in \code{\link{helper}} instead
#' @param default_size Deprecated - set sizes in \code{\link{helper}} instead
#' 
#' @examples
#' server <- function(input, output, session){
#' 
#'   # use anywhere in your server.R script
#'   observe_helpers(input, output)
#'   
#'   # rest of server.R
#'   # ...
#'   # ...
#' }
#' 
observe_helpers <- function(input, output,
                            help_dir = "helpfiles", 
                            sizes = NULL,
                            default_size = NULL) {
  
  if (!is.null(sizes)) 
    message("'sizes' has been deprecated, please set sizes in calls to 'helper'")
  
  if (!is.null(default_size))
    message("'default_size' has been deprecated, please set sizes in calls to 'helper'")
  
  shiny::observe({
    
    input_questions  <- names(input)[grepl("---shinyhelper$", names(input))]
    output_questions <- names(output)[grepl("---shinyhelper$", names(output))]
    questions <- c(input_questions, output_questions)
    
    lapply(questions, show_help_message, help_dir = help_dir)
    
  })
  
}

#' Function to go in ui.R to use the package - wrapper round shinyjs::useShinyjs()
#' @export
#' @param ... options to pass to shinyjs::useShinyjs
#' @examples
#' ui <- shiny::fluidPage(
#' 
#'   # use at top level in your ui script
#'   use_shinyhelper()
#'   
#'   # rest of ui.R
#'   # ...
#'   # ...
#' )
use_shinyhelper <- function(...){
  shinyjs::useShinyjs(...)
}
