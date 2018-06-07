#' Get Shiny Tag ID
#' 
#' Helper function to extract the id of a shiny element as a character string
#' 
#' @param shiny.tag A shiny input or output object
#' 
get_id <- function(shiny.tag){
  
  flat_tag <- unlist(shiny.tag)
  id <- flat_tag[grepl("\\.id$", names(flat_tag))][1]
  id <- unname(as.character(id))
  return(id)
  
}


#' Show Help Message
#' 
#' Function for adding a \code{shinyjs::onclick} event to each \code{\link{helper}},
#' opening up a \code{shiny::modalDialog} containing a markdown file.
#' 
#' @param id The id of the shinyhelper helper icon this help applies to
#' @param help_dir The directory in which to look for help files
#' 
show_help_message <- function(id, help_dir = "helpfiles"){
  
  components <- unlist(strsplit(id, split = "---"))
  filename <- components[2]
  size <- components[3]
  
  file <- paste0(help_dir, "/", filename, ".md")
  
  if (file.exists(file)) {
    content <- shiny::includeMarkdown(file)
    title <- NULL
  } else {
    content <- shiny::tags$p("We're sorry, there doesn't seem to be a helpfile 
                             for this yet! Looking for a helpfile called:",
                             shiny::tags$strong(file))
    title <- shiny::tags$strong("Helpfile Not Found")
  }
  
  shinyjs::onclick(id = id, expr = {
    shiny::showModal(
      shiny::modalDialog(content, 
                         title = title,
                         footer = shiny::modalButton("Okay"),
                         size = size)
    )
  }
  )
}
