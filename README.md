
<!-- README.md is generated from README.Rmd. Please edit that file -->
driftR <img src="man/figures/logo.png" align="right" />
=======================================================

[![Travis-CI Build Status](https://travis-ci.org/shaughnessyar/driftR.svg?branch=master)](https://travis-ci.org/shaughnessyar/driftR) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/shaughnessyar/driftR?branch=master&svg=true)](https://ci.appveyor.com/project/shaughnessyar/driftR) [![codecov](https://codecov.io/gh/shaughnessyar/driftR/branch/master/graph/badge.svg)](https://codecov.io/gh/shaughnessyar/driftR) [![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/driftR)](https://cran.r-project.org/package=driftR)

There are many sources of water-quality data including instruments (ex: YSI instruments) and open source data sets (ex: USGS and NDBC), all of which are susceptible to errors/inaccuracies due to drift. `driftR` provides a grammar for cleaning and correcting these data in a "tidy", reproducible manner.

Installation
------------

`driftR` is not available from CRAN yet. In the meantime, you can install the development version of `driftR` from Github with `devtools`:

``` r
# install.packages("devtools")
devtools::install_github("shaughnessyar/driftR")
```

Background
----------

The `driftR` package implements a series of equations used in [Dr. Elizabeth Hasenmueller's](https://hasenmuellerlab.weebly.com) hydrology and geochemistry research. These equations correct continuous water-quality monitoring data for incremental drift that occurs over time. There are two forms of corrections included in the package - a one-point calibration and a two-point calibration. One-point and two-point calibration values are suited for different types of measurements. The package is currently written for the easiest use with YSI Sonde products.

The figure below illustrates the difference in `pH` values between the raw data and the same data with the drift corrections implemented by `driftR` applied. There is a notable difference in the trend line between the raw data and the corrected data, which illustrates the importance of accounting for incremental drift.

![](man/figures/pH_noDrop.png)

The plot above also illustrates the importance of removing both the initial and the trailing observations in a given series of data. In this case, the initial observations are inaccurate due to recent equilibration of the instrument. The last few observations are inaccurate due to the removal of the instrument from the water for data download and equilibration. The figure below illustrates the impact of removing these observations on the data:

![](man/figures/pH_Drop.png)

Usage
-----

As shown, continuous water-quality instrument drift over time, so it becomes necessary to correct the data to maintain accuracy. `driftR` provides four verbs for applying these corrections in a consistent, reproducible manner: *read*, *factor*, *correct*, and *drop*. These verbs are designed to be implemented in that order, though there may be multiple applications of *correct* for a given data set. All of the core functions for `driftR` have the `dr_` prefix, making it easy to use them interactively in RStudio.

### Basic Use

The following example shows a simple workflow for applying these verbs to some hypothetical data:

``` r
# load the driftR package
library(driftR)

# import data exported from a Sonde 
df <- dr_readSonde(file = "data.csv", define = TRUE)

# calculate correction factor
# results stored in new vector corrFac
df <- dr_factor(df, corrFactor = corrFac, 
                dateVar = Date, 
                timeVar = Time, 
                format = "MDY")

# apply one-point calibration to SpCond;
# results stored in new vector SpConde_Corr
df <- dr_correctOne(df, sourceVar = SpCond, 
                    cleanVar = SpCond_Corr, 
                    calVal = 1.07, 
                    calStd = 1, 
                    factorVar = corrFac)

# apply two-point calibration to pH;
# results stored in new vector ph_Corr
df <- dr_correctTwo(df, sourceVar = pH, 
                    cleanVar = pH_Corr, 
                    calValLow = 7.01, 
                    calStdLow = 7,
                    calValHigh = 11.8, 
                    calStdHigh =  10, 
                    factorVar = corrFac)

# drop observations to account for instrument equilibration
df <- dr_drop(df, head=10, tail=5)
```

### Use with `%>%`

All of the core functions return tibbles (or data frames) and make use of the tidy evaluation pronoun `.data`, so using them in concert with the pipe (`%>%`) is straightforward:

``` r
# load the driftR package
library(driftR)

# import data exported from a Sonde 
df <- dr_readSonde(file = "data.csv", define = TRUE)

# caclulate correction factors, apply corrections, and drop observations
df <- df %>%
  dr_factor(corrFactor = corrFac, 
            dateVar = Date, 
            timeVar = Time, 
            format = "MDY") %>%
  dr_correctOne(sourceVar = SpCond, 
                cleanVar = SpCond_Corr, 
                calVal = 1.07, 
                calStd = 1, 
                factorVar = corrFac) %>%
  dr_correctTwo(sourceVar = pH, 
                cleanVar = pH_Corr, 
                calValLow = 7.01, 
                calStdLow = 7,
                calValHigh = 11.8, 
                calStdHigh =  10, 
                factorVar = corrFac)%>%
  dr_drop(head=10, tail=5)
```

Additional Documentation
------------------------

See the [package website](https://shaughnessyar.github.io/driftR/) for details on these functions and a [detailed vignette](https://shaughnessyar.github.io/driftR/articles/driftR.html) describing how to get started with `driftR`.

An [additional vignette](https://shaughnessyar.github.io/driftR/articles/TidyEval.html) describes `driftR`'s use of tidy evaluation and how to implement pipes into data cleaning in greater detail. Building on that article, we also [provide some introductory examples](https://shaughnessyar.github.io/driftR/articles/ExploringData.html) for how to use [`tidyr`](http://tidyr.tidyverse.org), [`ggplot2`](http://ggplot2.tidyverse.org), and several other `R` packages to conduct some initial exploratory data analysis of `driftR` output. Finally, we provide a [fourth vignette](https://shaughnessyar.github.io/driftR/articles/OtherData.html) designed for users of non-YSI Sonde instruments who wish to use `driftR` with their data.

You can also view the help files from within R:

``` r
?dr_readSonde
```

Want to Contribute?
-------------------

### Have a Concern?

If `driftR` does not seem to be working as advertised, please help us creating a reproducible example, or [`reprex`](https://github.com/tidyverse/reprex), that makes it easy to [get help](https://www.tidyverse.org/help/).

``` r
install.packages("reprex")
library("reprex")
```

After loading the `reprex` package, copy some code to your clipboard that includes the `library()` functions, the process you used to get you to where you are at (ideally simplified), and the functions that are creating issues. Once it is copied, you can use `reprex()` to format your example:

``` r
reprex()
```

Your clipboard will now contain a nicely formatted set of output that you can copy and paste into a GitHub [Issue](https://github.com/shaughnessyar/driftR/issues) that describes your problem.

### Adding `dr_read` Functions

We are interested in expanding the built-in capabilities of `driftR` to read in water-quality data from other sources. We are currently working on a function for YSI Exo output. If you have some sample data (~500 observations are ideal) from another type or brand of instrument and are willing to share it, please reach out to one of the package authors or, better yet, open an [Issue](https://github.com/shaughnessyar/driftR/issues). If you have some `R` skills and want to write the function yourself, feel free to [fork](https://help.github.com/articles/fork-a-repo/) `driftR`, make your edits, and then open a [pull request](https://help.github.com/articles/about-pull-requests/).

### Contributor Code of Conduct

Please note that this project is released with a [Contributor Code of Conduct](https://github.com/shaughnessyar/driftR/blob/master/CONDUCT.md). By participating in this project you agree to abide by its terms.

About the Authors
-----------------

Andrew Shaughnessy led the development of this package. He is a senior at [Saint Louis University](https://www.slu.edu) studying Chemistry and Environmental Science.

[Christopher Prener, Ph.D.](https://chris-prener.github.io) assisted in the development of this package. He is an Assistant Professor in the Department of Sociology and Anthropology at [Saint Louis University](https://www.slu.edu). He has a broad interest in computational social science as well as the development of `R` packages to make research more reproducible and to generalize research code.

[Elizabeth Hasenmueller, Ph.D.](https://hasenmuellerlab.weebly.com) developed the original equations that this package implements and provided the example data. She is an Assistant Professor in the Department of Earth and Atmospheric Science at [Saint Louis University](https://www.slu.edu).
