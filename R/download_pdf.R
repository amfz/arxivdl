#' Download PDFs
#'
#' Takes the results of an arxiv API query and downloads papers to disk by default. Saving to an AWS S3 bucket is also supported, though credentials should be set as environment variables prior to using `download_pdf` (see example).
#' Papers are saved with their arXiv id by default, e.g. "2001.12345v1.pdf"
#'
#' @param data data frame of arXiv records.
#' @param links name of column containing the PDF locations. `link_pdf` by default.
#' @param fnames name of column whose values should be used for saved file names. `id` by default.
#' @param dir directory to download files to. Current working directory by default.
#' @param bucket name of AWS S3 bucket to save files to.
#'
#' @return None -- files are saved to the specified location
#'
#' @examples
#' # get paper metadata, then download it to working directory
#' #ml <- get_records("cs.LG", "20200801 TO 20200802", 1)
#' #download_pdf(ml)
#'
#' # set up S3 credentials, then download to bucket
#' #Sys.setenv("AWS_ACCESS_KEY_ID" = "key")
#' #Sys.setenv("AWS_SECRET_ACCESS_KEY" = "secretkey")
#' #Sys.setenv("AWS_DEFAULT_REGION" = "us-east-2")
#' #download_pdf(ml, bucket="mybucket")
#'
#' @export
download_pdf <- function(data, links = "link_pdf", fnames = "id", dir = ".", bucket = NULL) {
  for (i in 1:nrow(data)) {
    # make sure the link ends with ".pdf"
    if (!endsWith(data[i, links], ".pdf")) {
      url <- paste0(data[i, links], ".pdf")
    } else {
      url <- data[i, links]
    }

    # ditto the file name
    if (!endsWith(data[i, fnames], ".pdf")) {
      file_name <- paste0(data[i, fnames], ".pdf")
    } else {
      file_name <- data[i, fnames]
    }
    print(file_name)

    # if no bucket is specified, save to disk
    if (is.null(bucket)) {
      save_path <- file.path(dir, file_name)
      utils::download.file(url, save_path, mode = "wb")
    } else {
      # check system environment for s3 credentials
      if (nchar(Sys.getenv("AWS_ACCESS_KEY_ID")) < 16) {
        warning('AWS_ACCESS_KEY_ID environment variable not set. Use Sys.setenv("AWS_ACCESS_KEY_ID" = "your-key-here") to set the key ID.')
      }
      if (nchar(Sys.getenv("AWS_SECRET_ACCESS_KEY")) < 16) {
        warning('AWS_SECRET_ACCESS_KEY environment variable not set. Use Sys.setenv("AWS_SECRET_ACCESS_KEY" = "your-secret-key") to set the secret key.')
      }
      if(nchar(Sys.getenv("AWS_DEFAULT_REGION")) < 2) {
        warning('AWS_DEFAULT_REGION environment variable not set. Use Sys.setenv("AWS_DEFAULT_REGION" = "aws-region-name") to set the region.')
      }
      # write to s3 bucket
      aws.s3::s3write_using(url,
                            FUN = utils::download.file,
                            mode = "wb",
                            bucket = bucket,
                            object = file_name)
    }
    # pause before downloading the next paper
    Sys.sleep(5)
  }
}
