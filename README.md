# shinyhelper <img src="man/figures/logo.png" align="right"/>


[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/shinyhelper)](https://cran.r-project.org/package=shinyhelper)
[![CRAN_Downloads](https://cranlogs.r-pkg.org/badges/shinyhelper)](https://cran.r-project.org/package=shinyhelper)
[![Travis-CI Build Status](https://travis-ci.org/cwthom/shinyhelper.svg?branch=master)](https://travis-ci.org/cwthom/shinyhelper)


Easily add help documentation to shiny elements, using markdown files.

The advantages of using this package are:

* add help files with a single extra function call
* leverage the formatting power of markdown to go beyond simple tooltips
* customise the appearance and positioning of the help icons, and the size of help pages
* additional function to quickly create a suitable directory of markdown files


## Installation

**shinyhelper 0.3.0 now on CRAN!** Go to: [https://cran.r-project.org/package=shinyhelper](https://cran.r-project.org/package=shinyhelper) 
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

## Demo

There is a live demo hosted on shinyapps.io. [Click here to go to the demo!](https://cwthom94.shinyapps.io/shinyhelper-demo/)

Alternatively, run the demo locally with:

```
library(shinyhelper)

shinyhelper_demo()
```


## Usage

You can add help files to any shiny element, including all inputs and outputs, with a simple call to `helper()`:
```
# load the package
library(shinyhelper)

...
# For elements in your ui you wish to add a help icon to
helper(plotOutput(outputId = "plot"))

# if you have %>% loaded, you can do plotOutput(outputId = "plot") %>% helper()

...
# In your server script, include:
observe_helpers()

# this triggers the modal dialogs when the user clicks an icon
# specify the name of your directory of help markdown files here

# e.g. observe_helpers(help_dir = "help_mds") will look for a directory called help_mds

```
## Content

All you need now is some content for your help page. You can specify this in 2 ways:

### inline

To specify inline content, simply set `type = "inline"` in `helper`, and supply the `title` and `content` arguments. `content` can be a character vector, in which case each element will be a new line. E.g.

```
plotOutput(outputId = "plot") %>% helper(type = "inline",
                                         title = "Plot",
                                         content = "This is a plot.")
```

### markdown

To use markdown, set `type = "markdown"` in `helper`, and supply the name of your markdown file (without the .md) in the `content` argument. This file should be in the directory specified by the `help_dir` argument to `observe_helpers`. E.g.

```
plotOutput(outputId = "plot") %>% helper(type = "markdown",
                                         content = "Plot")

# this will search for 'Plot.md' in the directory given in observe_helpers
```

You can specify a `title` argument too, or leave it blank and use a `## Heading` in your markdown document.

## Changing the Icon Appearance

You can change the type of icon used and its colour, as well as passing CSS inline.

### Icon

The icons are `shiny::icon("question-circle")` icons by default, but you can change them individually using the `icon` argument of `helper()`:

```
plotOutput(outputId = "plot") %>% helper(icon = "exclamation")
```

Please see [Font Awesome](https://fontawesome.com/icons?d=gallery) for the available icons.

### Colour

You can change the icon colour with the `colour` argument. Pass it any valid CSS colour as a character string.

```
plotOutput(outputId = "plot") %>% helper(colour = "green")
```

### Inline CSS

You can pass a `style` argument to modify CSS inline. This applies to the `<div>` containing the icon.

```
plotOutput(outputId = "plot") %>% helper(style = "color: red;")
```

Note: Passing a colour in a `style` argument will override `colour`.

## Changing the Help Page Size

By default, all help files are medium sized `modalDialog()` boxes (`size = "m"`). You can change each one though, by passing the `size` argument to `helper()`:

```
plotOutput(outputId = "plot") %>% helper(size = "l")
```

## Creating your Help Files

There is also a function, `create_help_files()` to quickly create a directory of help files from a vector of names. 

```
# Run this interactively, not in a shiny app
create_help_files(files = c("Clusters", "Columns", "PlotHelp"), 
                  help_dir = "helpfiles")
```

The `help_dir` will be "helpfiles" by default.

## Credits

Obviously, this package would not be possible (or indeed meaningful) without the incredible [shiny](https://github.com/rstudio/shiny) package. Full credit to the authors of shiny for doing all of the actual work!

Many thanks also to [Guangchang Yu](https://github.com/GuangchuangYu) for the wonderful [hexSticker](https://github.com/GuangchuangYu/hexSticker) package!

