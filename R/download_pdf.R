#' Download PDFs
#'
#' Takes the results of an arxiv API query and downloads papers to disk by default. Saving to an AWS S3 bucket is also supported, though credentials must be set as environment variables prior to using `download_pdf` (see example).
#' Papers are saved with their arXiv id, e.g. "2001.12345v1.pdf"
#'
#' @param data data frame of arXiv records
#' @param link_col name of column containing the PDF locations. `link_pdf` by default.
#' @param directory directory to download files to. Current working directory by default.
#' @param bucket name of AWS S3 bucket to save files to.
#'
#' @return None
#'
#' @examples
#' # get paper metadata, then download it to working directory
#' # ml <- get_records("cs.LG", "20200801 TO 20200802", 1)
#' # download_pdf(ml)
#'
#' # set up S3 credentials, then download to bucket
#' # Sys.setenv("AWS_ACCESS_KEY_ID" = "key")
#' # Sys.setenv("AWS_SECRET_ACCESS_KEY" = "secretkey")
#' # Sys.setenv("AWS_DEFAULT_REGION" = "us-east-2")
#' # download_pdf(ml, bucket="mybucket")
#'
#' @export
download_pdf <- function(data, link_col = "link_pdf", directory = ".", bucket = NULL) {
  for (i in 1:nrow(data)) {
    url <- paste0(data[i, link_col], ".pdf")
    file_name <- paste0(data[i, "id"], ".pdf")
    print(file_name)
    if (is.null(bucket)) {
      save_path <- file.path(directory, file_name)
      utils::download.file(url, save_path, mode = "wb")
    } else {
      if (nchar(Sys.getenv("AWS_ACCESS_KEY_ID")) < 16) {
        warning("AWS_ACCESS_KEY_ID environment variable not set")
      }
      if (nchar(Sys.getenv("AWS_SECRET_ACCESS_KEY")) < 16) {
        warning("AWS_SECRET_ACCESS_KEY environment variable not set")
      }
      if(nchar(Sys.getenv("AWS_DEFAULT_REGION")) < 2) {
        warning("AWS_DEFAULT_REGION environment variable not set")
      }
      aws.s3::s3write_using(url,
                            FUN = utils::download.file,
                            mode = "wb",
                            bucket = bucket,
                            object = file_name)
    }
    Sys.sleep(5)
  }
}
