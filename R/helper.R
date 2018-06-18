#' Augment a shiny.tag with a question mark helper button
#' 
#' Add an action button to your shiny UI with a question mark help icon (by default).
#' In combination with \code{\link{observe_helpers}} this action button will produce
#' a \code{shiny::modalDialog} containing a markdown help file (of name \code{filename}).
#' 
#' @export
#' 
#' @param shiny_tag A shiny input or output object
#' @param icon A character string of the name of the fa-icon to display
#' @param colour Any valid CSS colour for the icon
#' @param type Either 'markdown' to include a helpfile, or 'inline' to specify text
#' @param title If \code{type = "inline"}, the title of the \code{modalDialog} - otherwise
#'   this will be ignored, and you should use a heading in your markdown file.
#' @param content If \code{type = "markdown"}, the name of your markdown file; if
#'   \code{type = "inline"}, a character vector of text to include. This will be pasted 
#'   together with line breaks.
#' @param size Either 's', 'm' or 'l' - the size of the modal dialog to display
#' @param ... Other arguments to pass to the \code{div} containing the icon
#' 
helper <- function(shiny_tag, 
                   icon = "question-circle",
                   colour = NULL,
                   type = "markdown",
                   title = "",
                   content = "",
                   size = "m",
                   ...){
  
  if (!(type %in% c("inline", "markdown"))) {
    stop("type must be 'inline' or 'markdown'")
  }

  if (!(size %in% c("s", "m", "l"))) {
    stop("size must be in c('s', 'm', 'l')")
  }
  
  if (type == "inline") {
    content <- paste(content, sep = "", collapse = "\n")
  } else {
    content <- paste(content, ".md", sep = "")
  }
  
  if (!is.null(colour)) {
    colour <- paste0("color: ", colour, ";")
  }
  
  help_icon <- shiny::icon(name = icon, class = "shinyhelper-icon")
  
  help_icon <- shiny::tagAppendAttributes(tag = help_icon,
                                          "data-modal-size" = size,
                                          "data-modal-type" = type,
                                          "data-modal-title" = title,
                                          "data-modal-content" = content)
  
  help_icon <- shiny::div(help_icon,
                          class = "shinyhelper-container",
                          style = colour,
                          ...)
  
  shiny::addResourcePath(prefix = "shinyhelper",
                         directoryPath = system.file("assets", package = "shinyhelper"))
  
  shiny::tagList(
    shiny::singleton(
      shiny::tags$head(
        shiny::tags$link(rel = "stylesheet",
                         href = "shinyhelper/shinyhelper.css"),
        shiny::tags$script(src = "shinyhelper/shinyhelper.js"))
    ),
    shiny::div(shiny_tag, help_icon, class = "shinyhelper-wrapper")
  )
}
