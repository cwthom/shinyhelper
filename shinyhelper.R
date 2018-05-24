# =========================================================================== #
# Functions for adding helpfiles to shiny apps                                #
# =========================================================================== #

# TODO: Turn this into a package


# Packages ----------------------------------------------------------------

library(shiny)
library(shinyjs)
library(markdown)


# Functions ---------------------------------------------------------------

# helper function to extract the id from a shiny tag
get_id <- function(shiny.tag){
  
  flat_tag <- unlist(shiny.tag)
  id <- flat_tag[grepl("\\.id$", names(flat_tag))]
  id <- unname(as.character(id))
  return(id)
  
}

# core function for augmenting a shiny tag with an action button
helper <- function(shiny.tag){
  
  id <- get_id(shiny.tag)
  
  res <- div(shiny.tag, 
             actionButton(inputId = paste0(id, "-msg"), 
                          label = NULL,
                          icon = icon("question-circle-o"),
                          class = "helper"),
             style = "position: relative;"
  )
}

# function for producing a help message when the question mark is clicked
help_message <- function(id, help_dir){
  
  file <- paste0(help_dir, "/", gsub("-msg$", "", id), ".md")
  
  if (file.exists(file)) {
    content <- includeMarkdown(file)
    title <- NULL
  } else {
    content <- "We're sorry, there doesn't seem to be a helpfile for this yet!"
    title <- strong("Helpfile Not Found")
  }
  
  onclick(id = id, 
          expr = {
            showModal(
              modalDialog(content, 
                          title = title,
                          footer = modalButton("Okay"),
                          size = "m")
            )
          }
  )
  
}

# helper function to go in server.R to use the help messages
use_helpers <- function(input, output, help_dir = "helpfiles") {
  
  if (!dir.exists(help_dir)) {
    message(paste0("Creating empty help directory called ", help_dir, "..."))
    message("TODO: populate the folder with .md files!")
    dir.create(help_dir)
  }
  
  observe({
    
    input_questions  <- names(input)[grepl("-msg$", names(input))]
    output_questions <- names(output)[grepl("-msg$", names(output))]
    questions <- c(input_questions, output_questions)
    
    lapply(questions, help_message, help_dir = help_dir)
    
  })
  
}
