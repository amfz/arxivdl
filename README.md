
# dlarxiv

<!-- badges: start -->
<!-- badges: end -->

The goal of `dlarxiv` is to make it easier to responsibly query and download papers from arXiv to disk or AWS S3 storage. This is particularly useful if you are trying to download several papers that match a specific query. `dlarxiv` also includes supporting functions to retrieve papers by subject area and submission date and to give files more meaningful names.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("amfz/dlarxiv")

```
## Usage

### Basic Use

The main function is `download_pdf()`, which takes the results of an arXiv API query and downloads the full paper PDFs.

```
library(dlarxiv)

# see how many NE papers were submitted Jan 1, 2020 
count <- get_record_count("cs.NE", "20200101 TO 20200102")
# get paper records
papers <- get_records("cs.NE", "20200101 TO 20200102", count)

# download PDFs to the home directory with paper IDs as file names
download_pdf(papers, dir="~/")
```

