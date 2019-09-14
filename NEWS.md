# shinyhelper 0.3.2

* Add parameters for `fade`, `easyClose` and `buttonLabel`

# shinyhelper 0.3.1

Welcome to shinyhelper 0.3.1. This patch version introduces three new elements to the package, to fix bugs in 0.3.0.

New features:

* `helper` icons now work within dynamically rendered UI
* inline content now supports HTML strings for formatting
* mathematical formulae can be rendered in help files, using MathJax

Fixed bugs:

* help icons now no longer overlie drop down lists (lower z-index)

Thanks to GitHub user kornl for spotting and fixing the MathJax and z-index bugs.

### shinyhelper 0.3.0.9001

New features:

* helper icons now work in dynamically rendered UI

### shinyhelper 0.3.0.9000

New features:

Thanks to GitHub user kornl for both of the following:
* fix to `z-index` CSS parameter of help icons
* add withMathJax parameter to allow formulae to render
* support inline raw html


# shinyhelper 0.3.0

Welcome to shinyhelper 0.3.0 - this version of the package is a complete re-write of the previous version and is NOT BACKWARDS COMPATIBLE. This change has been to make the package less of a hack and more of a proper extension of `shiny`. It also brings in a smoother interface for app developers, with fewer function calls necessary for the package to work, and less intrusion into the workings of your apps.

**New features:**

* No longer dependent on package `shinyjs`
* No need for the `use_shinyhelper()` function - this has been removed
* Can now pass inline content as well as markdown files to your shiny app. This means that short help dialog boxes can be defined entirely within the UI of your app, where they should be. Just use the `type` argument to `helper()` with `type = "inline"`
* The modals created by `helper()` now have `easyClose = TRUE`, so can be shut by clicking anywhere or pressing ESC
* `observe_helpers()` now has no mandatory arguments; it can be called as-is
* Information such as the size and content of help pages is now stored in data-* attributes of the HTML tags created by `helper()` - previously it was bodged together in the ID.
* `create_help_files()` will create a directory called "helpfiles" by default.

**Non-backwards compatible changes:**

* Various arguments to `helper()` have been renamed or replaced.
* `observe_helpers()` now looks at the session object rather than `input` and `output` directly.
* `shinyhelperDemo()` has been renamed `shinyhelper_demo()` to match other `snake_case` naming convention throughout the package.

**Thanks:**

Thanks go to Dean Attali for his feedback on v0.2.0


### shinyhelper 0.2.0.9000

This will become v0.3.0 - it is a complete re-write internally, changing how the information to be displayed in the help box is conveyed from the browser to the server, and giving the user the option of specifying inline content.

The ui is also no longer cluttered with additional inputs.

New features:

* can now specify inline content, with `type = "inline"`
* no longer need to do `use_shinyhelper()` in UI
* removed dependency on `shinyjs` - this is now purely an extension of shiny
* modals now close by clicking anywhere, or pressing ESC
* no longer need to pass `input` to `observe_helpers`
* uses data-* attributes from HTML5 to store information, not non-standard attributes
* published demo to shinyapps.io


# shinyhelper 0.2.0

Welcome to shinyhelper v0.2.0 - this is an improved version on the original package, with greater freedom and ease for you to customise your app UI. 

**New Features:**

* dedicated `icon_colour` argument to `helper()` - no need to use `style = "color = ...;"` any more
* set size of each help page individually with the `size` argument to `helper()` - no more named lists!
* use a file name of your choice for your markdown help pages - no longer need to have the same as the shiny.tag input and output IDs
* new `shinyhelperDemo()` function, to run a demo app that comes installed with the package

**Deprecated Features:**

* the `sizes` and `default_size` arguments to `observe_helpers()` have been deprecated. They're still there, but will give a warning message if you try to use them.

I've also improved the documentation in the man pages.

### shinyhelper 0.1.1.9003

New features:

* can set sizes of help pages in `helper`, not named list in `observe_helpers()`
* can set custom filename for help pages - no longer need to use inputId and outputId although that's still the default.

Deprecated features:

* `sizes` and `default_size` arguments to `observe_helpers()`

### shinyhelper 0.1.1.9002

New features:

* example app installed with package
* better documentation of functions
* dedicated function `shinyhelperDemo` to run example app

### shinyhelper 0.1.1.9000

New features:

* Set colour of help icon with dedicated `colour` parameter.

# shinyhelper 0.1.1

This is the first version of the package.
