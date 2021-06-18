library(shiny)
library(shinyhelper)
library(shinybulma)
library(magrittr)

shinyApp(
  ui = bulmaPage(
    bulmaHero(
      fullheight = TRUE,
      color = "primary",
      bulmaHeroBody(
        bulmaContainer(
          bulmaTitle("Shiny meets Bulma!") %>% helper(type='markdown',content='Bulma'),
          bulmaSubtitle("A neat framework for your Shiny apps."),
          bulmaActionButton("show_modal", "Show modal")
        )
      )
    ),
    bulmaSection(
      bulmaTileAncestor(
        bulmaTileParent(
          vertical = TRUE,
          bulmaTileChild(
            bulmaTitle("Tile 1"),
            p("Put some data here"),
            color = "link"
          ),
          bulmaTileChild(
            bulmaTitle("Tile 2"),
            plotOutput("chart"),
            color = "danger"
          )
        ),
        bulmaTileParent(
          vertical = TRUE,
          bulmaTileChild(
            bulmaTitle("Tile 3"),
            p("Put some data here"),
            color = "warning"
          ),
          bulmaTileChild(
            bulmaTitle("Tile 3"),
            ("Put some data here"),
            color = "info"
          )
        )
      )
    )
  ),
  server = function(input, output) {
    observe_helpers(useTheme="bulma",withMathJax = T)
    observeEvent(input$show_modal,{
      withMathJax(bulmaModal(
             id = "mymodal", 
             list(
              title = "Modal title",
              body ='<h2>MARKDOWN HELPER WITH BULMA</h2><p>$$\\sqrt{2}$$</p>'
             )
            ))
    })
    output$chart <- renderPlot({
      plot(x = runif(20, 5, 10), y = runif(20, 10, 12))
    })
  }
)