#' Get paper metadata records
#'
#' Queries the arXiv API to get metadata for papers submitted to a given category during a specified date range. Records are ordered by earliest submitted.
#'
#' @param cat [arXiv category](https://arxiv.org/category_taxonomy) name(s) to retrieve papers for. Search for papers listed under multiple categories by using the pipe ("|") delimiter.
#' @param date_range Submission dates in "YYYYMMDD TO YYYYMMDD" format
#' @param lim Total number of records to retrieve. If the function is called interactively and no lim value is given, the function will check how many records the query will return and prompt the user to proceed.
#'
#' @return `data.frame` of metadata
#'
#' @examples
#' # Get the first 10 papers submitted to *both* math.CO and math.PR in 2019
#' # papers <- get_records("math.CO | math.PR", "2019 TO 2020", 10)
#'
#' @export
get_records <- function(cat, date_range, lim = NULL) {
  query <- paste0('cat:"', cat, '" AND submittedDate:[', date_range, "]")

  # if function is called in interactive mode without a specified limit,
  # check how many results there are
  if(is.null(lim) & interactive()) {
    # get number of results
    lim <- as.numeric(get_record_count(cat, date_range))
    # estimate how long the query will take
    est <- pmax(ceiling(lim/50) -1, 0) * 3
    # check if the user wants to proceed
    switch(utils::menu(c("Yes", "No"),
         title = paste0(lim,
                        " papers found. Estimated metadata retrieval time: ",
                        est,
                        " seconds. Proceed?")),
         TRUE,
         stop("Search cancelled; no results retrieved."))
  } else if(is.null(lim)) {
    stop("Please specify the maximum number of results to return. If you need help picking a maximum, use get_record_count() to find the expected number of results")
  }

  # if a limit is specified
  records <- aRxiv::arxiv_search(
    query,
    sort_by = "submitted",
    ascending = TRUE,
    limit = lim,
    batchsize = 50
  )
  return(records)
}
