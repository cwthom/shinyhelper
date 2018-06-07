#' Augment a shiny.tag with a question mark helper button
#' 
#' Add an action button to your shiny UI with a question mark help icon (by default).
#' In combination with \code{\link{use_shinyhelper}} and \code{\link{observe_helpers}}
#' this action button will produce a \code{shiny::modalDialog} containing a markdown
#' help file (of name \code{filename}).
#' 
#' @export
#' 
#' @param shiny.tag A shiny input or output object
#' @param filename A character string of the name of the helpfile you want to display
#' @param size Either 's', 'm' or 'l' - the size of the modal dialog to display
#' @param icon An icon created with \code{shiny::icon()}
#' @param class A custom CSS class - defaults to shiny-helper-question
#' @param icon_colour Any valid CSS colour for the icon (if you pass a colour 
#'   as a \code{style} argument, \code{icon_colour} will be overruled)
#' @param ... Other arguments to pass to shiny::actionButton
#' 
#' @examples 
#' helper(shiny::actionButton(inputId = "button1", label = "Click me!"))
#' helper(shiny::plotOutput(outputId = "plot1"), size = "l", filename = "PlotHelp", 
#'        icon_colour = "green")
helper <- function(shiny.tag, 
                   filename = NULL,
                   size = "m",
                   icon = shiny::icon("question-circle-o"),
                   class = "shiny-helper-question", 
                   icon_colour = NULL,
                   ...){
  
  if (!(size %in% c("s", "m", "l")))
    stop("size must be in c('s', 'm', 'l')")
  
  id <- get_id(shiny.tag)
  
  if (is.null(filename)) filename <- id
  if (grepl("\\.md$", filename)) {
    filename <- sub("\\.md$", "", filename)
    message("No need to include '.md' in filenames")
  }
  
  if (!is.null(icon_colour)) icon_colour <- paste0("color: ", icon_colour, ";")
  
  shiny::tagList(
    shiny::singleton(
      shiny::tags$head(shiny::tags$link(rel="stylesheet", href = "css-helper/shinyhelper.css"))
    ),
    shiny::div(class = "shiny-helper-container",
               shiny.tag, 
               shiny::actionButton(inputId = paste(id, filename, size, 
                                                   "shinyhelper", sep = "---"), 
                                   label = NULL,
                                   icon = icon,
                                   class = class,
                                   style = icon_colour,
                                   ...)
    )
  )
}
