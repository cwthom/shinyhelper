# =========================================================================== #
# Demo App for the shinyhelper functions - server                             #
# =========================================================================== #

# Server Instructions -----------------------------------------------------

server <- function(input, output, session) {
  
  # uses 'helpfiles' directory by default
  # in this example, we use the withMathJax parameter to render formulae
  observe_helpers(withMathJax = TRUE)
  
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
  
  # demostrate helpers on dynamic UI
  output$dynamicUI <- renderUI({
    h4("Click the help icon for current details...") %>% 
      helper(icon = "question", 
             colour = "orange",
             size = "s",
             type = "inline",
             title = "Current Details",
             content = c(paste("<b>x-variable:</b>", input$xcol),
                         paste("<b>y-variable:</b>", input$ycol),
                         paste("<b>Clusters:</b>", input$clusters),
                         "</br>Note this help icon is rendered on the server!"))
  })
}
