#' Helper function to extract the id of a shiny element as a character string
#' @export
#' @param shiny.tag A shiny input or output object
#' @examples
#' \dontrun{get_id(shiny::actionButton(inputId = "button_id", label = "example"))}
get_id <- function(shiny.tag){
  
  flat_tag <- unlist(shiny.tag)
  id <- flat_tag[grepl("\\.id$", names(flat_tag))]
  id <- unname(as.character(id))
  return(id)
  
}

#' Augment a shiny.tag with a question mark helper button
#' @export
#' @param shiny.tag A shiny input or output object
#' @examples 
#' \dontrun{plotOutput(outputId = "plot") %>% helper()}
helper <- function(shiny.tag){
  
  id <- get_id(shiny.tag)
  
  shiny::tagList(
    shiny::singleton(
      shiny::tags$head(shiny::tags$link(rel="stylesheet", href = "css-helper/shinyhelper.css"))
    ),
    shiny::div(class = "shiny-helper-container",
               shiny.tag, 
               shiny::actionButton(inputId = paste0(id, "-msg"), 
                                   label = NULL,
                                   icon = shiny::icon("question-circle-o"),
                                   class = "shiny-helper-question")
    )
  )
}

#' Helper function to be run interactively - it will initialise a directory of
#' help files (.md files) in help_dir, using the vector of ids. Pass it a vector
#' of ids corresponding to the inputId and outputId in your shiny app
#' @export
#' @param ids A character vector of ids to use
#' @param help_dir A character string of the directory to use for help files
create_help_files <- function(ids, help_dir = "helpfiles") {
  
  for (id in ids) {
    
    file <- paste0(help_dir, "/", gsub("-msg$", "", id), ".md")
  
    if (!file.exists(file)) {
      file.create(file)
      writeLines(text = c(paste0("### ", gsub("-msg$", "", id), " - Under Development \n"),
                          "*** \n",
                          "This helpfile is currently under development. \n"),
                 con = file)
    }
  }
}


#' Function for adding an onclick event to each helper, using shinyjs
#' @param id The id of the shiny.tag this help applies to
#' @param help_dir The directory in which to look for help files
help_message <- function(id, help_dir){
  
  file <- paste0(help_dir, "/", gsub("-msg$", "", id), ".md")
  
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
                         size = "m")
      )
    }
  )
}

#' Function to go in server.R to use the help messages
#' @export
#' @param input The input object of your shiny app
#' @param output The output object of your shiny app
#' @param help_dir A character string of the directory containing your helpfiles
#' @examples 
#' \dontrun{watch_helpers(input, output, "helpfiles")}
watch_helpers <- function(input, output, help_dir = "helpfiles") {
  
  shiny::observe({
    
    input_questions  <- names(input)[grepl("-msg$", names(input))]
    output_questions <- names(output)[grepl("-msg$", names(output))]
    questions <- c(input_questions, output_questions)
    
    lapply(questions, help_message, help_dir = help_dir)
    
  })
  
}

#' Function to go in ui.R to use the package
#' @export
#' @param ... options to pass to shinyjs::useShinyjs
use_shinyhelper <- function(...){
  shinyjs::useShinyjs(...)
}
