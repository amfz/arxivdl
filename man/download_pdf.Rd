% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/download_pdf.R
\name{download_pdf}
\alias{download_pdf}
\title{Download PDFs}
\usage{
download_pdf(
  data,
  links = "link_pdf",
  fnames = "id",
  dir = ".",
  bucket = NULL,
  delay = 5
)
}
\arguments{
\item{data}{data frame of arXiv records.}

\item{links}{name of column containing the PDF locations. \code{link_pdf} by default.}

\item{fnames}{name of column whose values should be used for saved file names. \code{id} by default.}

\item{dir}{directory to download files to. Current working directory by default.}

\item{bucket}{name of AWS S3 bucket to save files to.}

\item{delay}{number of seconds to wait between paper downloads. Default (and minimum) is 5.}
}
\value{
None -- files are saved to the specified location
}
\description{
Takes the results of an arxiv API query and downloads papers to disk by default. Saving to an AWS S3 bucket is also supported, though credentials should be set as environment variables prior to using \code{download_pdf} (see example).
Papers are saved with their arXiv id by default, e.g. "2001.12345v1.pdf".
This function imposes a minimum five-second delay between PDF downlaods to avoid abusing shared web resources.
}
\examples{
\dontrun{
# get paper metadata, then download it to working directory
ml <- get_records("cs.LG", "20200801 TO 20200802", 1)
download_pdf(ml)

# set up S3 credentials, then download to bucket
Sys.setenv("AWS_ACCESS_KEY_ID" = "key")
Sys.setenv("AWS_SECRET_ACCESS_KEY" = "secretkey")
Sys.setenv("AWS_DEFAULT_REGION" = "us-east-2")
download_pdf(ml, bucket="mybucket")
}

}
