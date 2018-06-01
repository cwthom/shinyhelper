# shinyhelper

[![Travis-CI Build Status](https://travis-ci.org/cwthom/shinyhelper.svg?branch=master)](https://travis-ci.org/cwthom/shinyhelper)
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/shinyhelper)](https://cran.r-project.org/package=shinyhelper)

Easily add help documentation to shiny inputs and outputs, using markdown files.

The advantages of using this package are:

* add help files with a single extra function call
* leverage the formatting power of markdown to go beyond simple tooltips
* customise the appearance and positioning of the help icons, and the size of help pages
* additional function to quickly create a suitable directory of markdown files

You can add help files to any shiny input or output, with a simple call to `helper()`:
```
# load the package
library(shinyhelper)

...
# In your UI script, include:
use_shinyhelper()
# this is a wrapper round shinyjs::useShinyjs

...
helper(plotOutput(outputId = "plot"))
# if you have %>% loaded, you can do plotOutput(outputId = "plot") %>% helper()

...
# In your server script, include:
observe_helpers(input, output, ...)
# this allows the help buttons to work properly

```
## Installation

**shinyhelper 0.1.1 now on CRAN!** Go to: [https://cran.r-project.org/package=shinyhelper](https://cran.r-project.org/package=shinyhelper) 
You can install the package with:
```
install.packages("shinyhelper")
```

To get the latest development version, you can use the `devtools` package to install from GitHub directly:
```
devtools::install_github('cwthom/shinyhelper')
```

In both cases, then load the package in with:
```
library(shinyhelper)
```
## Demo

To run a demo of the functionality this brings, install the package and then use:
```
shiny::runGitHub(repo = "cwthom/shinyhelper", subdir = "example")
```

## Changing the Icon Appearance

The icons are `shiny::icon("question-mark-o")` icons by default, but you can change them individually using the `icon` argument of `helper()`:
```
plotOutput(outputId = "plot") %>% helper(icon = shiny::icon("exclamation"))
```
By default, the icons have a custom CSS class, `shiny-helper-question` - you can override this with the `class` argument to helper and provider your own CSS class. You can also pass a `style` argument to modify CSS in-line:
```
plotOutput(outputId = "plot") %>% helper(style = "color: red;")
```

## Changing the Help Page Size

By default, all help files are medium sized `modalDialog()` boxes (`size = "m"`). You can pass a named list of `sizes` to `watch_helpers()` to customise this. Any you do not provide will be the size given by `default_size`.
```
observe_helpers(input, output, sizes = list(xcol = "s", plot1 = "l"), default_size = "m")
```

## Creating your Help Files

There is a helper function, `create_help_files()` to quickly create a directory of helpfiles from a vector of id names.
```
# Run this interactively, not in a shiny app
create_help_files(ids = c("xcol", "ycol", "clusters", "plot1"), 
                  help_dir = "helpfiles")
```
