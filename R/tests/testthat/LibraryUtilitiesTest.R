# ---
#
# Script to test OhdsiLibUtil functionality.
#
# ---

library(testthat)
library(R6)

script_dir <- dirname(sys.frame(1)$ofile)

source("./R/LibraryUtilities.R")

test_that(
  "LibraryUtilities returns OhdsiLibUtil instance",
  {
    writeLines(getwd())
    expect_true(1 == 1)
    libUtil <- getNewOhdsiLibUtil()
    libUtil$test()
  }
)




