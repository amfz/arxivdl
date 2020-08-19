#' Get the number of papers
#'
#' Queries the arXiv API to get the count of papers submitted to a given category during a stated date range.
#'
#' @param cat [arXiv category](https://arxiv.org/category_taxonomy) name
#' @param date_range Submission dates in "YYYYMMDD TO YYYYMMDD" format
#'
#' @return `int` of papers meeting the criteria
#'
#' @examples
#' # Get the count of papers submitted to cs.LG on August 1, 2020
#' ml <- get_record_count("cs.LG", "20200801 TO 20200802")
#'
#' @export
get_record_count <- function(cat, date_range) {
  query <- paste0('cat:"', cat, '" AND submittedDate:[', date_range, "]")
  count <- aRxiv::arxiv_count(query)
  return(count)
}
