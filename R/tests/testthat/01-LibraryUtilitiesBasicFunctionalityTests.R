# ---
#
# Script to test Theon functionality.
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
  "The removeForeign function works.",
  {
    writeLines(getwd())
    expect_true(1 == 1)
    libUtil <- getTheon()
    lib <- "C:/temp"
    libUtil$removeForeign("CohortGenerator", lib)
    libUtil$installFromGithub("OHDSI/CohortGenerator", "v0.8.0", lib)
    libUtil$removeForeign("CohortGenerator", lib)
    libUtil$removeForeign("CohortGenerator", lib)
  }
)

test_that(
  "The test function works.",
  {
    writeLines(getwd())
    expect_true(1 == 1)
    libUtil <- getTheon()
    libUtil$test()
  }
)

test_that(
  "The checkPackageVersion function works.",
  {
    writeLines(getwd())
    expect_true(1 == 1)
    libUtil <- getTheon()
    libUtil$checkPackageVersion("dummy")
  }
)

test_that(
  "The packageVersionExists function works.",
  {
    writeLines(getwd())
    expect_true(1 == 1)
    libUtil <- getTheon()
    libUtil$packageVersionExists("dummy", "0.1.3")
  }
)

test_that(
  "The installFromCran function works with specified target dir.",
  {
    writeLines(getwd())
    expect_true(1 == 1)
    libUtil <- getTheon()
    libUtil$forceRemovePackage("dummy")
    libUtil$installFromCran("dummy", "0.1.3", "C:/temp")
  }
)

test_that(
  "The installFromCran function works.",
  {
    writeLines(getwd())
    expect_true(1 == 1)
    libUtil <- getTheon()
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
    libUtil <- getTheon()
    libUtil$forceRemovePackage("CohortGenerator")
    libUtil$installFromGithub("OHDSI/CohortGenerator", "v0.8.0", "C:/temp")
  }
)

test_that(
  "The installFromGithub function works.",
  {
    writeLines(getwd())
    expect_true(1 == 1)
    libUtil <- getTheon()
    libUtil$forceRemovePackage("CohortGenerator")
    libUtil$installFromGithub("OHDSI/CohortGenerator", "v0.8.0")
    library(CohortGenerator)
  }
)

test_that(
  "Get package details works.",
  {
    writeLines(getwd())
    expect_true(1 == 1)
    libUtil <- getTheon()
    deets <- libUtil$getPackageDetails("remotes")
    deets
  }
)

test_that(
  "Get package details works.",
  {
    writeLines(getwd())
    expect_true(1 == 1)
    libUtil <- getTheon()
    deets <- libUtil$getPackageDetailsAsList("remotes")
    deets
  }
)

test_that(
  "Get package version works for package that does not exist.",
  {
    writeLines(getwd())
    expect_true(1 == 1)
    libUtil <- getTheon()
    deets <- libUtil$getPackageVersion("thisPackageDoesNotExist")
    deets
  }
)

test_that(
  "Get package version works for package that does exist.",
  {
    writeLines(getwd())
    expect_true(1 == 1)
    libUtil <- getTheon()
    deets <- libUtil$getPackageVersion("remotes")
    deets
  }
)







