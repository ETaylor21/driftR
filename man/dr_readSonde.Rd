% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dr_readSonde.R
\name{dr_readSonde}
\alias{dr_readSonde}
\title{Import raw data from a YSI Multivariable V2 Sonde}
\usage{
dr_readSonde(file, defineVar = TRUE)
}
\arguments{
\item{file}{The name of the file which the data are to be read from. Each row of the table appears
as one line of the file. If it does not contain an absolute path, the file name is relative to
the current working directory.}

\item{defineVar}{Logical scalar that determines if the units of measurement are included in the first
observation. If they are included, all vectors will be read in as character.}
}
\value{
A tibble with the formatted data and the variable types defined if \code{defineVar = TRUE}
}
\description{
This function imports the raw data from a YSI Sonde and formats the data set as a tibble.
    If \code{defineVar} is set to \code{TRUE} (the default option), units of measurement will not be
    included in the first observation.
}
\examples{
\dontrun{
dr_readSonde("data.csv")
dr_readSonde("data.csv", defineVar = TRUE)
}

}
