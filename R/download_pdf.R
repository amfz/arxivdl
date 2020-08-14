#' Download PDFs
#'
#' Takes the results of an arxiv API query and downloads papers to disk.
#' Papers are saved with their arXiv id, e.g. "2001.12345v1.pdf"
#'
#' @param data data frame of arXiv records
#' @param link_col name of column containing the PDF locations. `link_pdf` by default.
#' @param directory directory to download files to. Current working directory by default.
#'
#' @return None
#'
#' @examples
#' # get records of papers, then download them
#' # ml <- get_records("cs.LG", "20200801 TO 20200802", 100)
#' # download_pdf(ml)
#'
#' @export
download_pdf <- function(data, link_col="link_pdf", directory=".") {
  for (i in 1:nrow(data)) {
    url <- paste0(data[i, link_col], ".pdf")
    file_name <- paste0(data[i, "id"], ".pdf")
    print(file_name)
    save_path <- file.path(directory, file_name)
    utils::download.file(url, save_path, mode = "wb")
    Sys.sleep(5)
  }
}
