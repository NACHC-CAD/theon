# ---
#
# Script to test OhdsiLibUtil functionality.
#
# ---

# libraries
library(testthat)
library(R6)

# clear the environment
rm(list = ls())

# imports
source("./R/LibraryUtilities.R")

# ---
#
# tests
#
# ---

test_that(
  "The test function works.",
  {
    writeLines(getwd())
    expect_true(1 == 1)
    libUtil <- getNewOhdsiLibUtil()
    libUtil$test()
  }
)

test_that(
  "The checkPackageVersion function works.",
  {
    writeLines(getwd())
    expect_true(1 == 1)
    libUtil <- getNewOhdsiLibUtil()
    libUtil$checkPackageVersion("dummy")
  }
)

test_that(
  "The packageVersionExists function works.",
  {
    writeLines(getwd())
    expect_true(1 == 1)
    libUtil <- getNewOhdsiLibUtil()
    libUtil$packageVersionExists("dummy", "0.1.3")
  }
)

test_that(
  "The installFromCran function works with specified target dir.",
  {
    writeLines(getwd())
    expect_true(1 == 1)
    libUtil <- getNewOhdsiLibUtil()
    libUtil$forceRemovePackage("dummy")
    libUtil$installFromCran("dummy", "0.1.3", "C:/temp")
  }
)

test_that(
  "The installFromCran function works.",
  {
    writeLines(getwd())
    expect_true(1 == 1)
    libUtil <- getNewOhdsiLibUtil()
    libUtil$forceRemovePackage("dummy")
    libUtil$installFromCran("dummy", "0.1.3")
    library(dummy)
  }
)

test_that(
  "The installFromGithub function works with specified target dir.",
  {
    writeLines(getwd())
    expect_true(1 == 1)
    libUtil <- getNewOhdsiLibUtil()
    libUtil$forceRemovePackage("CohortGenerator")
    libUtil$installFromGithub("OHDSI/CohortGenerator", "v0.8.0", "C:/temp")
  }
)

test_that(
  "The installFromGithub function works.",
  {
    writeLines(getwd())
    expect_true(1 == 1)
    libUtil <- getNewOhdsiLibUtil()
    libUtil$forceRemovePackage("CohortGenerator")
    libUtil$installFromGithub("OHDSI/CohortGenerator", "v0.8.0")
    library(CohortGenerator)
  }
)





