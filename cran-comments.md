## Release summary
This is the second re-submission of our initial CRAN submission. At the reviewer's request, the title in the `DESCRIPTION` file was shortened and a citation for the equations used was added in the `Description` field. The prior resubmission made the following change: at the reviewer's request, `+ file LICENSE` was removed from the `DESCRIPTION` and the `LICENSE` file was added to `.Rbuildignore`.

## Test environments
* local macOS install, R 3.4.3
* ubuntu 14.04 (on Travis CI), R-release, R-oldrel, R-devel
* macOS (on Travis CI), R-release, R-oldrel
* windows (on Appveyor), R-release, R-oldrel
* winbuilder, R-devel

## R CMD check results
There were no ERRORs, WARNINGs, or NOTEs with local checks or on Travis CI/Appveyor.

On devtools::release()'s R CMD check we get one NOTE:

* checking CRAN incoming feasibility ... NOTE

  This notes that the package is a new submission. 

On winbuilder, we get one NOTE:

* checking CRAN incoming feasibility ... NOTE

  This notes that the package is a new submission. It also suggests that there may 
  be some mis-spelled words in DESCRIPTION. We have checked these and they are all
  abbreviations that are spelled correctly.

## Reverse dependencies
Not applicable.