#' Get paper metadata records
#'
#' Queries the arXiv API to get metadata for papers submitted to a given category during a stated date range. Records are ordered by earliest submitted.
#'
#' @param cat [arXiv category](https://arxiv.org/category_taxonomy) name(s). Search for multiple categories by using the pipe ("|") delimiter
#' @param date_range Submission dates in "YYYYMMDD TO YYYYMMDD" format
#' @param lim Total number of records to retrieve. If no value is given, the function will check how many records the query will return and prompt the user to proceed.
#'
#' @return `data.frame` of metadata
#'
#' @examples
#' # Get the count of papers submitted to cs.LG on August 1, 2020
#' # ml <- get_records("cs.LG", "20200801 TO 20200802")
#'
#' # Get the first 20 papers submitted to both math.CO and math.PR in 2019
#' # papers <- get_records("math.CO | math.PR", "2019 TO 2020", 20)
#'
#' @export
get_records <- function(cat, date_range, lim = NULL) {
  query <- paste0('cat:"', cat, '" AND submittedDate:[', date_range, "]")
  if(is.null(lim)) {
    lim <- as.numeric(get_record_count(cat, date_range))
    switch(utils::menu(c("Yes", "No"),
         title = paste0(lim, " papers found. Proceed?")),
         TRUE,
         return())
  }
  records <- aRxiv::arxiv_search(
    query,
    sort_by = "submitted",
    ascending = TRUE,
    limit = lim,
    batchsize = 50
  )
  return(records)
}
