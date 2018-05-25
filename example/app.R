# =========================================================================== #
# Demo App for the shinyhelper functions                                      #
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
        helper(icon = icon("question")),
      
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


# Server Instructions -----------------------------------------------------

server <- function(input, output, session) {
  
  # use helpfiles
  observe_helpers(input = input, output = output,
                  help_dir = "helpfiles", sizes = list(kmeans = "l", ycol = "s"))
  
  # demo app for kmeans clustering taken from 
  # https://shiny.rstudio.com/gallery/kmeans-example.html
  
  # Combine the selected variables into a new data frame
  selectedData <- reactive({
    iris[, c(input$xcol, input$ycol)]
  })
  
  clusters <- reactive({
    kmeans(selectedData(), input$clusters)
  })
  
  output$kmeans <- renderPlot({
    palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
              "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))
    
    par(mar = c(5.1, 4.1, 0, 1))
    plot(selectedData(),
         col = clusters()$cluster,
         pch = 20, cex = 3)
    points(clusters()$centers, pch = 4, cex = 4, lwd = 4)
  })
}

# Run the App -------------------------------------------------------------

shinyApp(ui, server)
