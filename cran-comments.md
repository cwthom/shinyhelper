## Resubmission - shinyhelper 0.1.1
This is a resubmission. In this version I have:

* Unwrapped the first example in create_help_files.Rd, and omitted the second.

## Resubmission - shinyhelper 0.1.1
This is a resubmission. In this version I have:

* Put software and package names in Title and Description in 'single quotes'
* Unwrapped examples in Rd files
* Removed examples from un-exported functions
* Removed `%>%` from examples
* Stopped writing to user's home filespace - the user must now specify a directory. Examples to be tested use `tempdir()`

## R CMD Check
There are no new ERRORs, WARNINGs or NOTEs in this resubmission.

## shinyhelper 0.1.1
This is the first submission of this package.

## Test environments
* local Windows 10, R 3.4.2, R 3.5.0
* Ubuntu Trusty 14.04 (travis-ci): oldrel, release, devel
* win-builder: devel

## R CMD check results
There were no ERRORs, WARNINGs.

There were 2 NOTES:

* This is a new package
* Can't check README.md or NEWS.md without 'pandoc' installed. 

Tried installing pandoc, but 'pandoc is not available for R version 3.5.0'.
This NOTE does not appear when checking from R 3.4.2, with pandoc installed.
