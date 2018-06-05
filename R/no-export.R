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
#' opening up a \code{shiny::modalDialog} containg a markdown file
#' 
#' @param id The id of the shiny.tag this help applies to
#' @param help_dir The directory in which to look for help files
#' @param sizes An optional named list of sizes for the different input and output ids
#' @param default_size An optional default size, if other than 'm'
#' 
show_help_message <- function(id, help_dir = "helpfiles", sizes = "m", 
                              default_size = "m"){
  
  if (!(default_size %in% c("s", "m", "l"))) {
    default_size <- "m"
    warning("Invalid default_size - defaulting to 'm'")
  }
  
  id_name <- gsub("-shinyhelper-msg$", "", id)
  
  if (is.list(sizes)) {
    if (id_name %in% names(sizes)) {
      size <- sizes[[id_name]]
      if (!(size %in% c("s", "m", "l"))) {
        warning(paste0("Sizes must be one of 's', 'm', 'l'; defaulting to '", 
                       default_size, "'."))
        size <- default_size
      }
    } else {
      size <- default_size
    }
  }
  
  file <- paste0(help_dir, "/", id_name, ".md")
  
  if (file.exists(file)) {
    content <- shiny::includeMarkdown(file)
    title <- NULL
  } else {
    content <- "We're sorry, there doesn't seem to be a helpfile for this yet!"
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
