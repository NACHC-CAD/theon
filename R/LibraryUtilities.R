# ---
#
# Function to expose functionality related to R libraries and packages.
#
# ---

source("./R/OhdsiLibUtil.R")

getNewOhdsiLibUtil <- function() {
  rtn <- OhdsiLibUtil$new()
  return(rtn)
}

