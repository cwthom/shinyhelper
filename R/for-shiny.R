#' Observe Helper Action Buttons
#' 
#' Function to create a family of \code{shinyjs::onclick} event handlers, observing 
#' clicks on the \code{\link{helper}} action buttons.
#' 
#' @export
#' @param input The input object in your shiny app
#' @param output The output object in your shiny app
#' @param help_dir A character string of the directory containing your helpfiles
#' @param sizes An optional named list of sizes for the input/output ids
#' @param default_size A default size to be passed to show_help_message, one of "s", "m", "l"
#' 
#' @examples
#' server <- function(input, output, session){
#' 
#'   # use anywhere in your server.R script
#'   observe_helpers(input, output, sizes = list(xcol = "s", plot1 = "l"))
#'   
#'   # rest of server.R
#'   # ...
#'   # ...
#' }
#' 
observe_helpers <- function(input, output, help_dir = "helpfiles", sizes = "m",
                            default_size = "m") {
  
  shiny::observe({
    
    input_questions  <- names(input)[grepl("-shinyhelper-msg$", names(input))]
    output_questions <- names(output)[grepl("-shinyhelper-msg$", names(output))]
    questions <- c(input_questions, output_questions)
    
    lapply(questions, show_help_message, help_dir = help_dir, sizes = sizes,
           default_size = default_size)
    
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
