
<!-- README.md is generated from README.Rmd. Please edit that file -->
driftR <img src="man/figures/logo.png" align="right" />
=======================================================

[![Travis-CI Build Status](https://travis-ci.org/shaughnessyar/driftR.svg?branch=master)](https://travis-ci.org/shaughnessyar/driftR) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/shaughnessyar/driftR?branch=master&svg=true)](https://ci.appveyor.com/project/shaughnessyar/driftR) [![codecov](https://codecov.io/gh/shaughnessyar/driftR/branch/master/graph/badge.svg)](https://codecov.io/gh/shaughnessyar/driftR) [![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/driftR)](https://cran.r-project.org/package=driftR)

The goal of `driftR` is to correct continuous water-quality monitoring data for intramental drift.

Installation
------------

`driftR` is not available from CRAN yet. In the meantime, you can install the development version of `driftR` from Github with devtools:

``` r
# install.packages("devtools")
devtools::install_github("shaughnessyar/driftR")
```

Background
----------

The `driftR` package implements a series of equations used in [Dr. Elizabeth Hasenmueller's](https://hasenmuellerlab.weebly.com) hydrology and geochemistry research. These equations correct continuous water-quality monitoring data for incramental drift that occurs over time. There are two forms of corrections included in the package - a one-point calibration and a two-point calibration. One-point and two-point callibration values are suited for different types of measurements.

The package is currently written for the easiest use with YSI Sonde products. We will be adding a vignette in the future describing the application of this package to other brands of water monitoring sensors.

Usage
-----

As shown, continuous water-quality instrument drift over time, so it becomes necessary to correct the data to maintain accuracy. First, you start with importing the data with `dr_readSonde()`. Next, you apply a correction factor using `dr_correct()`. Then, utilizing the generated correction factors, you use either `dr_clean1()` or `dr_clean2()` to drift correct the data using 1 or 2 point calibrations respectively. Lastly, you would `dr_drop()` data to account for instrument equilibration.

``` r
# load the driftR package
library(driftR)

# import data exported from a Sonde 
dataFrame <- dr_readSonde("filePath/data.csv", define=TRUE)

# calculate correction factor
correct <- dr_correct(dataFrame, Date, Time, format = YMD)

# apply one-point calibration to SpConde
dataFrame$SpCond_clean <- dr_clean1(df, SpCond, 1.07, 1, correct)

# drop observations to account for instrument equilibration
dataFrame <- dr_drop(dataFrame, head=10, tail=5)
```

See the [package website](https://shaughnessyar.github.io/driftR/) for details on these functions and a [detailed vignette]() describing their use.

About the Authors
-----------------

Andrew Shaughnessy led the development of this package. He is a senior at [Saint Louis University](https://www.slu.edu) studying Chemistry and Environmental Science.

[Christopher Prener, Ph.D.](https://chris-prener.github.io) assisted in the development of this package. He is an Assistant Professor in the Department of Sociology and Anthropology at [Saint Louis University](https://www.slu.edu). He has a broad interest in computational social science as well as the development of `R` packages to make research more reproducibile and to generalize research code.

[Elizabeth Hasenmueller, Ph.D.](https://hasenmuellerlab.weebly.com) developed the original equations that this package implements and provided the example data. She is an Assistant Professor in the Department of Earth and Atmospheric Science at [Saint Louis University](https://www.slu.edu).

Contributor Code of Conduct
---------------------------

Please note that this project is released with a [Contributor Code of Conduct](https://github.com/shaughnessyar/driftR/blob/master/CONDUCT.md). By participating in this project you agree to abide by its terms.
