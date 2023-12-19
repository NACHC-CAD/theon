# ---
#
# Function to expose functionality related to R libraries and packages.
#
# ---

source("./R/Theon.R")

getTheon <- function() {
  rtn <- Theon$new()
  return(rtn)
}

