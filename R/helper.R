#' Augment a shiny.tag with a question mark helper button
#' 
#' Add an action button to your shiny UI with a question mark help icon (by default).
#' In combination with \code{\link{observe_helpers}} this icon will produce a modal
#' dialog box in the app, with content and title as specified. You may pass inline content
#' for the modal, or else specify the name of a markdown file to include.
#' 
#' @export
#' 
#' @param shiny_tag A shiny element, such as an input or output (but any shiny tag will do).
#' @param icon A character string of the name of the icon to display (font awesome).
#' @param colour Any valid CSS colour for the icon.
#' @param type Either 'markdown' to include a helpfile, or 'inline' to specify text.
#' @param title The title to use for your modal. Leave as "" to have no title (for example,
#'   if your markdown document has a header you wish to use instead).
#' @param content If \code{type = "markdown"}, the name of your markdown file; if
#'   \code{type = "inline"}, a character vector of text/HTML to include. This will be pasted 
#'   together with line breaks. You need not add '.md' to the markdown filename.
#' @param size Either 's', 'm' or 'l' - the size of the modal dialog to display.
#' @param buttonLabel The text for the modal button - "Ok" by default.
#' @param easyClose Whether the modal can be dismissed by pressing Escape, or clicking
#'   outside the modal. Defaults to \code{TRUE}.
#' @param fade Whether the modal has a fade in animation. Defaults to \code{FALSE}.
#' @param ... Other arguments to pass to the \code{div} containing the icon.
#' 
#' @examples
#' helper(shiny::actionButton("go", "click me!"),
#'        icon = "exclamation",
#'        colour = "red",
#'        type = "markdown",
#'        content = "ClickHelp")  # looks for 'helpfiles/ClickHelp.md'
#'        
helper <- function(shiny_tag, 
                   icon = "circle-question",
                   colour = NULL,
                   type = "markdown",
                   title = "",
                   content = "",
                   size = "m",
                   buttonLabel = "Okay",
                   easyClose = TRUE,
                   fade = FALSE,
                   ...){
  
  if (!(type %in% c("inline", "markdown"))) {
    stop("type must be 'inline' or 'markdown'")
  }

  if (!(size %in% c("s", "m", "l"))) {
    stop("size must be in c('s', 'm', 'l')")
  }
  
  if (type == "inline") {
    content <- paste(content, sep = "", collapse = "<br>")
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
                                          "data-modal-content" = content,
                                          "data-modal-label" = buttonLabel,
                                          "data-modal-easyclose" = easyClose,
                                          "data-modal-fade" = fade)
  
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
