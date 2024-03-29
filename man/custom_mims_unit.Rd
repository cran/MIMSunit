% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mims_unit.R
\name{custom_mims_unit}
\alias{custom_mims_unit}
\title{Compute both MIMS-unit and sensor orientations with custom settings}
\usage{
custom_mims_unit(
  df,
  epoch = "5 sec",
  dynamic_range,
  noise_level = 0.03,
  k = 0.05,
  spar = 0.6,
  filter_type = "butter",
  cutoffs = c(0.2, 5),
  axes = c(2, 3, 4),
  use_extrapolation = TRUE,
  use_filtering = TRUE,
  combination = "sum",
  allow_truncation = TRUE,
  output_mims_per_axis = FALSE,
  output_orientation_estimation = FALSE,
  epoch_for_orientation_estimation = NULL,
  before_df = NULL,
  after_df = NULL,
  use_gui_progress = FALSE,
  st = NULL,
  use_snapshot_to_check = FALSE
)
}
\arguments{
\item{df}{dataframe. Input multi-channel accelerometer signal.}

\item{epoch}{string. Any format that is acceptable by argument \code{breaks}
in method \code{\link[base]{cut.POSIXt}}.For example, "1 sec", "1 min", "5
sec", "10 min". Default is "5 sec".}

\item{dynamic_range}{numerical vector. The dynamic ranges of the input
signal. Should be a 2-element numerical vector. \code{c(low, high)}, where
\code{low} is the negative max value the device can reach and \code{high}
is the positive max value the device can reach.}

\item{noise_level}{number. The tolerable noise level in \eqn{g} unit, should
be between 0 and 1. Default is 0.03, which applies to most devices.}

\item{k}{number. Duration of neighborhood to be used in local spline
regression for each side, in seconds. Default is 0.05, as optimized by
MIMS-unit algorithm.}

\item{spar}{number. Between 0 and 1, to control how smooth we want to fit
local spline regression, 0 is linear and 1 matches all local points.
Default is 0.6, as optimized by MIMS-unit algorithm.}

\item{filter_type}{string. The type of filter to be applied. Could be
'butter' for butterworth bandpass filter, 'ellip' for elliptic bandpass
filter or 'bessel' for bessel lowpass filter + average removal highpass
filter. Default is "butter".}

\item{cutoffs}{numerical vector. Cut off frequencies to be used in filtering.
If \code{filter_type} is "bessel", the cut off frequency for lowpass filter
would be multiplied by 2 when being used. Default is 0.2Hz and 5Hz.}

\item{axes}{numerical vector. Indices of columns that specifies the axis
values of the input signal. Default is \code{c(2,3,4)}.}

\item{use_extrapolation}{logical. If it is TRUE, the function will apply
extrapolation algorithm to the input signal, otherwise it will skip
extrapolation but only linearly interpolate the signal to 100Hz. Default is
TRUE.}

\item{use_filtering}{logical. If it is TRUE, the function will apply bandpass
filtering to the input signal, otherwise it will skip the filtering.
Default is TRUE.}

\item{combination}{string. Method to combine MIMS-unit values for each axis.
Could be "sum" for \code{\link{sum_up}} or "vm" for
\code{\link{vector_magnitude}}.}

\item{allow_truncation}{logical. If it is TRUE, the algorithm will truncate
very small MIMS-unit values to zero. Default is TRUE.}

\item{output_mims_per_axis}{logical. If it is TRUE, the output MIMS-unit
dataframe will have MIMS-unit values for each axis from the third column.
Default is FALSE.}

\item{output_orientation_estimation}{logical. If it is TRUE, the function
will also estimate sensor orientations over each epoch. And the output will
be a list, with the first element being the MIMS-unit dataframe, and the
second element being the sensor orientation dataframe. Default is FALSE.}

\item{epoch_for_orientation_estimation}{string. string. Any format that is
acceptable by argument \code{breaks} in method
\code{\link[base]{cut.POSIXt}}.For example, "1 sec", "1 min", "5 sec", "10
min". Default is "5 sec". It is independent from \code{epoch} for
MIMS-unit.}

\item{before_df}{dataframe. The multi-channel accelerometer signal comes
before the input signal to be prepended to the input signal during
computation. This is used to eliminate the edge effect during extrapolation
and filtering. If it is \code{NULL}, algorithm will run directly on the
input signal. Default is NULL.}

\item{after_df}{dataframe. The multi-channel accelerometer signal comes after
the input signal to be append to the input signal. This is used to
eliminate the edge effect during extrapolation and filtering. If it is
\code{NULL}, algorithm will run directly on the input signal. Default is
NULL.}

\item{use_gui_progress}{logical. If it is TRUE, show GUI progress bar on
windows platform. Default is FALSE.}

\item{st}{character or POSIXct timestamp. An optional start time you can set to
force the epochs generated by referencing this start time. If it is NULL, the
function will use the first timestamp in the timestamp column as start time to
generate epochs. This is useful when you are processing a stream of data and
want to use a common start time for segmenting data. Default is NULL.}

\item{use_snapshot_to_check}{logical. If TRUE, the function will use the first
100 rows or 10% (whichever is smaller) to check timestamp duplications. Otherwise,
the algorithm will use all data to check timestamp duplications. Default is FALSE.}
}
\value{
dataframe or list. If \code{output_orientation_estimation} is TRUE,
  the output will be a list, otherwise the output will be the MIMS-unit
  dataframe.

  The first element will be the MIMS-unit dataframe, in which the first
  column is the start time of each epoch in POSIXct format, and the second
  column is the MIMS-unit value for the input signal, and the third column
  and on are the MIMS-unit values for each axis of the input signal if
  \code{output_mims_per_axis} is TRUE.

  The second element will be the orientation dataframe, in which the first
  column is the start time of each epoch in POSIXct format, and the second to
  fourth column is the estimated orientations for the input signal.
}
\description{
\code{custom_mims_unit} computes the Monitor Independent Motion Summary unit
and estimates the sensor orientations for the input multi-channel
accelerometer signal with custom settings. The input signal can be from
devices of any sampling rate and dynamic range. Please refer to the
manuscript for detailed description of the algorithm. Please refer to
functions for the intermediate steps: \code{\link{extrapolate}} for
extrapolation, \code{\link{iir}} for filtering,
\code{\link{aggregate_for_mims}} and \code{\link{aggregate_for_orientation}}
for aggregation.
}
\note{
This function allows you to run customized algorithm for MIMSunit and
  sensor orientations.

  \code{before_df} and \code{after_df} are often set when the accelerometer
  data are divided into files of smaller chunk.
}
\section{How is it used in MIMS-unit algorithm?}{
 This is the low-level entry
  of MIMS-unit and orientation estimation algorithm. \code{\link{mims_unit}}
  calls this function internally.
}

\examples{
  # Use sample data for testing
  df = sample_raw_accel_data

  # compute mims unit values with custom parameter
  output = custom_mims_unit(df, epoch = '1 sec', dynamic_range=c(-8, 8), spar=0.7)
  head(output)
}
\seealso{
Other Top level API functions: 
\code{\link{mims_unit}()},
\code{\link{sensor_orientations}()},
\code{\link{shiny_app}()}
}
\concept{Top level API functions}
