# =========================================================================== #
# Demo App for the shinyhelper functions - ui                                 #
# =========================================================================== #

# Packages ----------------------------------------------------------------

library(shiny)
library(magrittr)
library(shinyhelper)

# User Interface ----------------------------------------------------------

ui <- fluidPage(
  
  # need to use Shinyjs
  use_shinyhelper(),
  
  # title of demo app
  titlePanel(title = "ShinyHelper Demo"),
  
  # use a sidebar layout
  sidebarLayout(
    
    # sidebapanel with inputs for kmeans clustering of iris
    sidebarPanel = sidebarPanel(
      
      selectInput(inputId = "xcol", label = "X Variable",
                  choices = names(iris)) %>% 
        helper(icon = icon("question"), colour = "green"),
      
      selectInput(inputId = "ycol", "Y Variable",
                  choices = names(iris),
                  selected = names(iris)[[2]]) %>% 
        helper(),
      
      sliderInput(inputId = "clusters", "Cluster count",
                  value = 3, min = 1, max = 9) %>% 
        helper(icon = icon("exclamation"), style = "color: red;")
      
    ),
    
    # mainpanel with output plot
    mainPanel = mainPanel(
      
      plotOutput(outputId = "kmeans") %>% 
        helper()
      
    )
  )
)
