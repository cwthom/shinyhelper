#' Observe Helper Action Buttons
#' 
#' Function to show a modal dialog, observing each of the help icons in the app.
#' 
#' @export
#' @param session The session object in your shiny app.
#' @param help_dir A character string of the directory containing your helpfiles.
#' @param withMathJax If \code{TRUE} the MathJax library is added to allow for 
#'   math expressions in markdown content.
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
                            help_dir = "helpfiles",
                            withMathJax = FALSE,
                            useTheme = "shiny") {
  
  shiny::observeEvent(
    
    eventExpr = session$input$`shinyhelper-modal_params`,
    
    handlerExpr = {
      
      params <- session$input$`shinyhelper-modal_params`
      
      type <- params$type
      size <- params$size
      title <- params$title
      label <- params$label
      easyClose <- as.logical(params$easyClose)
      fade <- as.logical(params$fade)
      
      if (!(useTheme %in% c("shiny", "bulma"))) {
        stop("useTheme must be 'shiny' or 'bulma'")
      } else{ 
        this.theme = useTheme
      }
      
      if (title == "") title <- NULL
      
      if (type == "markdown") {
        
        file <- file.path(help_dir, params$content)
        
        if (file.exists(file)) {
          content <- shiny::includeMarkdown(file)
          if (withMathJax) {
            content <- shiny::withMathJax(content)
          }
        } else {
          title <- shiny::tags$strong("Helpfile Not Found")
          content <- "Sorry, there doesn't seem to be a helpfile for this yet!"
        }
        
      } else {
        content <- shiny::HTML(params$content)
      }
      if(this.theme == 'shiny'){
        modal <- shiny::modalDialog(
          content,
          title = title,
          size = size,
          easyClose = easyClose,
          fade = fade,
          footer = shiny::modalButton(label)
        )
      
        shiny::showModal(modal)
      } 
      else if(this.theme == 'bulma'){
        bulmaModal(
          id = paste0('helpmodal',round(as.numeric(Sys.time()),0)),
          list(
            title = title,
            body = as.character(content),
            buttons = list(label=label,classes=c('button','is-success'))
          )
        )
      }
        
    }
  )
  
}
