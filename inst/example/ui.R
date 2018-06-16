# =========================================================================== #
# Demo App for the shinyhelper functions - ui                                 #
# =========================================================================== #

# Packages ----------------------------------------------------------------

library(shiny)
library(magrittr)
library(shinyhelper)

# User Interface ----------------------------------------------------------

ui <- fluidPage(
  
  # title of demo app
  titlePanel(title = "ShinyHelper Demo"),
  
  # use a sidebar layout
  sidebarLayout(
    
    # sidebapanel with inputs for kmeans clustering of iris
    sidebarPanel = sidebarPanel(
      
      selectInput(inputId = "xcol", label = "X Variable",
                  choices = names(iris)) %>% 
        helper(icon = "question",
               colour = "green",
               type = "markdown",
               content = "Columns"),
      
      selectInput(inputId = "ycol", "Y Variable",
                  choices = names(iris),
                  selected = names(iris)[[2]]) %>% 
        helper(type = "inline",
               title = "Inline Help",
               content = "This helpfile is defined entirely in the UI!",
               size = "s"),
      
      sliderInput(inputId = "clusters", "Cluster count",
                  value = 3, min = 1, max = 9) %>% 
        helper(icon = "exclamation",
               colour = "red",
               content = "Clusters")
    ),
    
    # mainpanel with output plot
    mainPanel = mainPanel(
      
      plotOutput(outputId = "kmeans") %>% 
        helper(size = "l", 
               content = "PlotHelp")
      
    )
  )
)
