# shinyhelper <img src="man/figures/logo.png" align="right"/>


[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/shinyhelper)](https://cran.r-project.org/package=shinyhelper)
[![CRAN_Downloads](https://cranlogs.r-pkg.org/badges/shinyhelper)](https://cran.r-project.org/package=shinyhelper)
[![Travis-CI Build Status](https://travis-ci.org/cwthom/shinyhelper.svg?branch=master)](https://travis-ci.org/cwthom/shinyhelper)


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
All you need now is a markdown helpfile named with your `inputId` or `outputId`.
For example, if you have a `sliderInput()` with `inputId = "nclusters"`, its helpfile should be called *nclusters.md*, unless you wish to change this using the `filename` argument - see below.

## Installation

**shinyhelper 0.2.0 now on CRAN!** Go to: [https://cran.r-project.org/package=shinyhelper](https://cran.r-project.org/package=shinyhelper) 
You can install the package with:
```
install.packages("shinyhelper")
```

To get the latest development version, you can use the `devtools` package to install from GitHub directly:
```
devtools::install_github("cwthom/shinyhelper")
```

In both cases, then load the package in with:
```
library(shinyhelper)
```

Note: the errors showing on CRAN for Windows binaries for R 3.4 and 3.5 may be safely ignored - they are to do with the CRAN build environment rather than the package itself.

## Demo

To run a demo of the functionality this brings, install the package and then use:
```
library(shinyhelper)

shinyhelperDemo()
```

## Changing the Icon Appearance

### Icon

The icons are `shiny::icon("question-mark-o")` icons by default, but you can change them individually using the `icon` argument of `helper()`:

```
plotOutput(outputId = "plot") %>% helper(icon = shiny::icon("exclamation"))
```

### Colour

You can change the icon colour with the `icon_colour` argument. Pass it any valid CSS colour as a character string.

```
plotOutput(outputId = "plot") %>% helper(icon_colour = "green")
```

### Other CSS

By default, the icons have a custom CSS class, `shiny-helper-question` - you can override this with the `class` argument to helper and provider your own CSS class. You can also pass a `style` argument to modify CSS in-line:
```
plotOutput(outputId = "plot") %>% helper(style = "color: red;")
```
Note: Passing a colour in a `style` argument will override `icon_colour`.

## Changing the Help Page Size

By default, all help files are medium sized `modalDialog()` boxes (`size = "m"`). You can change each one though, by passing the `size` argument to `helper()`:

```
plotOutput(outputId = "plot") %>% helper(size = "l")
```

## Naming your Help Files

By default, shinyhelper will look for help files in a folder called "helpfiles", with the same names as your shiny `inputId`s and `outputId`s. To use custom names for your help pages, pass the `filename` argument to `helper()`:

```
plotOutput(outputId = "plot") %>% helper(filename = "MyAwesomeHelpPage")
```

Note: you don't need to put ".md" on your filename. If you do it will be ignored.

## Creating your Help Files

There is a helper function, `create_help_files()` to quickly create a directory of helpfiles from a vector of names. 

```
# Run this interactively, not in a shiny app
create_help_files(ids = c("Clusters", "Columns", "PlotHelp"), 
                  help_dir = "helpfiles")
```

***

## Credits

Obviously, this package would not be possible (or indeed meaningful) without the incredible [shiny](https://github.com/rstudio/shiny) and [shinyjs](https://github.com/daattali/shinyjs) packages. Full credit to them for all the actual work!

Many thanks also to [Guangchang Yu](https://github.com/GuangchuangYu) for the wonderful [hexSticker](https://github.com/GuangchuangYu/hexSticker) package!

