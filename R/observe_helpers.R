#' Observe Helper Action Buttons
#' 
#' Function to show a modal dialog, observing each of the help icons in the app.
#' 
#' @export
#' @param input The input object in your shiny app
#' @param help_dir A character string of the directory containing your helpfiles
#' 
#' @examples
#' server <- function(input, output, session){
#' 
#'   # use anywhere in your server.R script
#'   observe_helpers(input)
#'   
#'   # rest of server.R
#'   # ...
#'   # ...
#' }
#' 
observe_helpers <- function(input, help_dir = "helpfiles") {
  
  shiny::observeEvent(
    
    eventExpr = input$`shinyhelper-modal_params`,
    
    handlerExpr = {
      
      params <- input$`shinyhelper-modal_params`
      
      type <- params$type
      size <- params$size
      
      if (type == "markdown") {
        
        file <- paste0(help_dir, "/", params$content, ".md")
        
        if (file.exists(file)) {
          
          content <- shiny::includeMarkdown(file)
          title <- NULL
          
        } else {
          
          content <- shiny::tags$p("We're sorry, there doesn't seem to be a helpfile 
                             for this yet!")
          title <- shiny::tags$strong("Helpfile Not Found")
          
        }
        
      } else {
        
        content <- params$content
        title <- params$title
        
      }
      
      modal <- shiny::modalDialog(
        content,
        title = title,
        size = size,
        easyClose = TRUE
      )
      
      shiny::showModal(modal)
        
    }
  )
  
}
