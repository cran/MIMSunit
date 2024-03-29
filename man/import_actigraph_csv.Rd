% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/import_data.R
\name{import_actigraph_csv}
\alias{import_actigraph_csv}
\title{Import raw multi-channel accelerometer data stored in Actigraph raw csv
format}
\usage{
import_actigraph_csv(
  filepath,
  in_voltage = FALSE,
  has_ts = TRUE,
  header = TRUE
)
}
\arguments{
\item{filepath}{string. The filepath of the input data. The first column of
the input data should always include timestamps.}

\item{in_voltage}{set as TRUE only when the input Actigraph csv file is in
analog quantized format and need to be converted into g value}

\item{has_ts}{boolean. If TRUE, the input csv file will have a timestamp column.}

\item{header}{boolean. If TRUE, the input csv file will have column names in
the first row.}
}
\value{
dataframe. The imported multi-channel accelerometer signal, with the
  first column being the timestamps in POSXlct format, and the rest columns
  being accelerometer values in \eqn{g} unit.
}
\description{
\code{import_actigraph_csv} imports the raw multi-channel accelerometer data
stored in Actigraph raw csv format. It supports files from the following
devices: GT3X, GT3X+, GT3X+BT, GT9X, and GT9X-IMU.
}
\details{
For old device (GT3X) that stores accelerometer values as digital voltage.
The function will convert the values to \eqn{g} unit using the following
equation.

\deqn{x_g = \frac{x_{voltage}r}{(2 ^ r) - \frac{v}{2}}}

Where \eqn{v} is the max voltage corresponding to the max accelerometer value
that can be found in the meta section in the csv file; \eqn{r} is the
resolution level which is the number of bits used to store the voltage
values. \eqn{r} can also be found in the meta section in the csv file.
}
\section{How is it used in MIMS-unit algorithm?}{
 This function is a File IO
  function that is used to import data from Actigraph devices during
  algorithm validation.
}

\examples{
  default_ops = options()
  options(digits.secs=3)

  # Use the sample actigraph csv file provided by the package
  filepath = system.file('extdata', 'actigraph_timestamped.csv', package='MIMSunit')

  # Check file format
  readLines(filepath)[1:15]

  # Load the file with timestamp column
  df = import_actigraph_csv(filepath)

  # Check loaded file
  head(df)

  # Check more
  summary(df)

  # Use the sample actigraph csv file without timestamp
  filepath = system.file('extdata', 'actigraph_no_timestamp.csv', package='MIMSunit')

  # Check file format
  readLines(filepath)[1:15]

  # Load the file without timestamp column
  df = import_actigraph_csv(filepath, has_ts = FALSE)

  # Check loaded file
  head(df)

  # Check more
  summary(df)

  # Restore default options
  options(default_ops)
}
\seealso{
Other File I/O functions: 
\code{\link{export_to_actilife}()},
\code{\link{import_actigraph_count_csv}()},
\code{\link{import_actigraph_csv_chunked}()},
\code{\link{import_actigraph_meta}()},
\code{\link{import_activpal3_csv}()},
\code{\link{import_enmo_csv}()},
\code{\link{import_mhealth_csv_chunked}()},
\code{\link{import_mhealth_csv}()}
}
\concept{File I/O functions}
