
# arxivdl

<!-- badges: start -->
<!-- badges: end -->

The goal of `arxivdl` is to make it easier to responsibly query and download papers from arXiv to disk or AWS S3 storage. This is particularly useful if you are trying to download several papers that match a specific query. `arxivdl` also includes supporting functions to retrieve papers by subject area and submission date and to give files more meaningful names.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("amfz/arxivdl")

```
## Usage

### Basic Use

The main function is `download_pdf()`, which takes the results of an arXiv API query and downloads the full paper PDFs.

```
library(arxivdl)

# see how many NE papers were submitted Jan 1, 2020 
count <- get_record_count("cs.NE", "20200101 TO 20200102")
# get paper records
papers <- get_records("cs.NE", "20200101 TO 20200102", count)

# download PDFs to the home directory with paper IDs as file names
download_pdf(papers, dir="~/")
```
### Saving to AWS S3

`download_pdf()` also supports saving files to an Amazon Web Service S3 bucket. S3 access credentials should be set up before calling `download_pdf()`; the easiest way to do this is by setting them with `Sys.setenv()`. See the [vignettename] for detailed instructions on setting up S3 storage and generating credentials.

```
# set up AWS credentials
Sys.setenv(
  "AWS_ACCESS_KEY_ID" = "your-key-here",
  "AWS_SECRET_ACCESS_KEY" = "your-secret-here",
  "AWS_DEFAULT_REGION" = "us-east-2" # replace region as appropriate
)

# get metadata for the first 20 graphics papers published in 2019
papers <- get_records("cs.GR","2019 TO 2020", lim = 20)

# create file names based on paper titles
papers$file_name <- clean_titles(papers)

# download files to s3 bucket
download_pdf(papers, fname = "file_name", bucket = "my-s3-bucket")
```

