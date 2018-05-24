library(shiny)
library(magrittr)
library(shinyjs)
library(markdown)

get_id <- function(shiny.tag){

  flat_tag <- unlist(shiny.tag)
  id <- flat_tag[grepl("\\.id$", names(flat_tag))]
  id <- unname(as.character(id))
  return(id)
  
}

helper <- function(shiny.tag){
  
  id <- get_id(shiny.tag)
  
  res <- div(shiny.tag, 
             actionButton(inputId = paste0(id, "-msg"), 
                          label = NULL,
                          icon = icon("question"),
                          class = "helper"),
             style = "position: relative;"
  )
  
  
}

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
                          size = "l")
            )
          }
  )
  
}

ui <- fluidPage(
  
  useShinyjs(),
  includeCSS(path = "custom.css"),
  
  sidebarLayout(
    
    sidebarPanel = sidebarPanel(
      
      selectInput(inputId = "select", label = "Select Input", 
                  choices = LETTERS, selected = "A", width = NULL) %>% 
        helper(),
      
      sliderInput(inputId = "slider", label = "Slider Input", 
                  min = 1, max = 26, value = 1) %>% 
        helper()
      
    ),
    
    mainPanel = mainPanel()
  )

)

server <- function(input, output, session) {
  
  observe({
  
    questions <- names(input)[grepl("-msg$", names(input))]
    lapply(questions, help_message)
    
  })
  
}

shinyApp(ui, server)