#' Augment a shiny.tag with a question mark helper button
#' @export
#' @param shiny.tag A shiny input or output object
#' @param icon An icon created with shiny::icon()
#' @param class A custom CSS class - defaults to shiny-helper-question
#' @param colour Any valid CSS colour for the icon (if you pass a colour as a 'style' argument, 'colour' will be overruled)
#' @param ... Other arguments to pass to shiny::actionButton
#' @examples 
#' helper(shiny::actionButton(inputId = "button1", label = "Click me!"))
#' helper(shiny::plotOutput(outputId = "plot1"))
helper <- function(shiny.tag, icon = shiny::icon("question-circle-o"),
                   class = "shiny-helper-question", 
                   colour = NULL,
                   ...){
  
  id <- get_id(shiny.tag)
  
  if (!is.null(colour)) colour <- paste0("color: ", colour, ";")
  
  shiny::tagList(
    shiny::singleton(
      shiny::tags$head(shiny::tags$link(rel="stylesheet", href = "css-helper/shinyhelper.css"))
    ),
    shiny::div(class = "shiny-helper-container",
               shiny.tag, 
               shiny::actionButton(inputId = paste0(id, "-shinyhelper-msg"), 
                                   label = NULL,
                                   icon = icon,
                                   class = class,
                                   style = colour,
                                   ...)
    )
  )
}
