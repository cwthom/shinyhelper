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
help_message <- function(id){
  
  
  if (file.exists(paste0("helpfiles/", gsub("-msg$", "", id), ".md"))) {
    content <- includeMarkdown(paste0("helpfiles/", gsub("-msg$", "", id), ".md"))
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
use_helpers <- function(input, output) {
  
  observe({
    
    input_questions  <- names(input)[grepl("-msg$", names(input))]
    output_questions <- names(output)[grepl("-msg$", names(output))]
    questions <- c(input_questions, output_questions)
    
    lapply(questions, help_message)
    
  })
  
}
