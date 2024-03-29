% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{edge_case}
\alias{edge_case}
\title{A short snippet of raw accelerometer signal from a device that has ending data maxed out.}
\format{
A data frame with 20001 rows and 4 variables:
\describe{
  \item{HEADER_TIME_STAMP}{The timestamp of raw accelerometer data, in POSIXct}
  \item{X}{The x axis value of raw accelerometer data, in number}
  \item{Y}{The x axis value of raw accelerometer data, in number}
  \item{Z}{The x axis value of raw accelerometer data, in number}
}
}
\source{
\url{https://github.com/mHealthGroup/MIMSunit/}
}
\usage{
edge_case
}
\description{
The dataset includes accelerometer data sampled at 80Hz and 6g. This data is used to test the edge case.
}
\keyword{datasets}
