% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utility_functions.R
\name{clean_titles}
\alias{clean_titles}
\title{Clean Title Names}
\usage{
clean_titles(data, col = "title")
}
\arguments{
\item{data}{data frame}

\item{col}{text column in the data frame to clean up. "title" by default.}
}
\value{
Character vector of cleaned text.
}
\description{
Clean up text for use as file names. Converts all characters to lowercase, removes  punctuation and extra whitespace, replaces spaces between words with underscores, and adds ".pdf" to the end of the title.
}
\examples{
df <- data.frame(title = c("Paper Title: Subtitle", "O Rly? A Study"), pages = c(20, 40))
df$cleaned <- clean_titles(df)


}
