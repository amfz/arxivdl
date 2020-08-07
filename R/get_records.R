#' Get paper metadata records
#'
#' Queries the arXiv API to get metadata for papers submitted to a given category during a stated date range.
#'
#' @param cat [arXiv category](https://arxiv.org/category_taxonomy) name
#' @param date_range Submission dates in "YYYYMMDD TO YYYYMMDD" format
#' @param lim Total number of records to retrieve
#'
#' @return `data.frame` of metadata
#'
#' @examples
#' # Get the count of papers submitted to cs.LG on August 1, 2020
#' ml <- get_records("cs.LG", "20200801 TO 20200805", 100)
#'
#' @export
get_records <- function(cat, date_range, lim) {
  query <- paste0('cat:"', cat, '" AND submittedDate:[', date_range, "]")
  records <- aRxiv::arxiv_search(
    query,
    sort_by = "updated",
    ascending = FALSE,
    limit = lim,
    batchsize = 50
  )
  return(records)
}
