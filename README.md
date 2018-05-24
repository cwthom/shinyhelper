# shinyhelper

Easily add help documentation to shiny inputs and outputs, using markdown files.

The advantages of using this package are:

* add help files with a single extra function call
* leverage the formatting power of markdown to go beyond simple tooltips
* additional function to quickly create a suitable directory of markdown files

You can add help files to any shiny input or output, with a simple call to `helper()`:
```
# load the package
library(shinyhelper)

...

helper(plotOutput(outputId = "plot"))
# if you have %>% loaded, you can do plotOutput(outputId = "plot") %>% helper()

...
```
## Installation

Until the package becomes available on CRAN, you can use the `devtools` package to install from GitHub directly:
```
devtools::install_github('cwthom/shinyhelper')
```
