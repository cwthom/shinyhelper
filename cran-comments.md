# shinyhelper 0.3.2

## Test Environments
* local windows 10, R 3.6.1
* Ubuntu Xenial 16.04 (travis-ci): oldrel, release, devel
* win-builder: oldrel, release, devel

## R CMD Check Results
There were no ERRORs, WARNINGs or NOTEs locally or on Travis CI. The WinBuilder raised a NOTE about the shinyapps.io URL of a demo in one of the man pages - this URL is correct.

## Reverse Dependencies
There are no reverse dependencies at this time.

## Further Notes
This release adds in a couple of extra user options requested to customise the experience.

# shinyhelper 0.3.1

## Test Environments
* local Windows 10, R 3.5.0
* Ubuntu Trusty 14.04 (travis-ci): oldrel, release, devel
* win-builder: release, devel

## R CMD Check Results
There were no ERRORs, WARNINGs or NOTEs.

## Reverse Dependencies
There are no reverse dependencies at this time.

## Further Notes

This patch fixes two minor bugs in the previous release - the `helper` function now works with dynamically rendered UI, and inline HTML is now also supported.

# shinyhelper 0.3.0

## Test Environments
* local Windows 10, R 3.5.0
* Ubuntu Trusty 14.04 (travis-ci): oldrel, release, devel
* win-builder: release, devel

## R CMD Check Results
There were no ERRORs, WARNINGs or NOTEs.

## Reverse Dependencies
There are no reverse dependencies at this time.

# shinyhelper 0.2.0

## Test Environments
* local Windows 10, R 3.5.0
* Ubuntu Trusty 14.04 (travis-ci): oldrel, release, devel
* win-builder: devel

## R CMD Check results
There were no ERRORs, WARNINGs or NOTEs.

## Further notes
This is a new and updated version of the package, making it easier to use. Although it's only been 2 weeks since the first release, I wanted to build these features in to help the package take off quickly. I will stick to a slower release cycle for future releases.

Thanks for your help.

***

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
