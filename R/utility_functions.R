#' Clean Title Names
#'
#' Standardize a text vector
#'
#' @param data data frame of arXiv records.
#' @param col text column in the data frame to clean up
#'
#' @return Character vector of cleaned text.
#'
#' @examples
#' df <- data.frame(title = c("Paper Title: Subtitle", "O Rly? A Study"), pages = c(20, 40))
#' df$cleaned <- clean_titles(df)
#'
#'
#' @export
clean_titles <- function(data, col = "title") {
  # make the titles all lowercase
  cleaned <- tolower(data[, col])
  # replace punctuation with spaces
  cleaned <- gsub("[[:punct:]]", " ", cleaned)
  # reduce multiple whitespace chars to one
  cleaned <- gsub("[[:space:]]{2,}", " ", cleaned)
  # replace spaces with underscores
  cleaned <- gsub("[[:space:]]", "_", cleaned)
  cleaned <- paste0(cleaned, ".pdf")
  cleaned
}
