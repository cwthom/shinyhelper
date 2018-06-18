#' Observe Helper Action Buttons
#' 
#' Function to show a modal dialog, observing each of the help icons in the app.
#' 
#' @export
#' @param session The session object in your shiny app
#' @param help_dir A character string of the directory containing your helpfiles
#' 
#' @examples
#' server <- function(input, output, session){
#' 
#'   # use anywhere in your server.R script
#'   observe_helpers()
#'   
#'   # rest of server.R
#'   # ...
#'   # ...
#' }
#' 
observe_helpers <- function(session = shiny::getDefaultReactiveDomain(),
                            help_dir = "helpfiles") {
  
  shiny::observeEvent(
    
    eventExpr = session$input$`shinyhelper-modal_params`,
    
    handlerExpr = {
      
      params <- session$input$`shinyhelper-modal_params`
      
      type <- params$type
      size <- params$size
      title <- params$title
      
      if (title == "") title <- NULL
      
      if (type == "markdown") {
        
        file <- file.path(help_dir, params$content)
        
        if (file.exists(file)) {
          content <- shiny::includeMarkdown(file)
        } else {
          title <- shiny::tags$strong("Helpfile Not Found")
          content <- "Sorry, there doesn't seem to be a helpfile for this yet!"
        }
        
      } else {
        content <- params$content
      }
      
      modal <- shiny::modalDialog(
        content,
        title = title,
        size = size,
        easyClose = TRUE,
        footer = shiny::modalButton("Okay")
      )
      
      shiny::showModal(modal)
        
    }
  )
  
}
