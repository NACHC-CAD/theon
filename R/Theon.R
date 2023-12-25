# ---
#
# A class to encapsulate basic library/package related functionality
#
# ---

library(R6)

Theon = R6Class(

    classname = "Theon",

    public = list (

      # ---
      #
      # tests and checks
      #
      # ---

      test = function() {
        print("Test worked.")
      },

      checkPackageVersion = function(packageName) {
        available_packages <- available.packages()
        latest_keyring_version <- available_packages[packageName, "Version"]
        print(latest_keyring_version)
      },

      packageVersionExists = function (pkgName, pkgVersion) {
        tryCatch (
          {
            return(packageVersion(pkgName) == pkgVersion)
          },
          error = function(e) {
            return(FALSE)
          }
        )
      },

      # ---
      #
      # installs
      #
      # ---

      installFromCran = function(pkgName, pkgVersion, lib = NA) {
        if (requireNamespace(pkgName, quietly = TRUE) == TRUE && self$packageVersionExists(pkgName, pkgVersion)) {
          print(paste("Correct version of package already installed: ", pkgName, pkgVersion, sep = " "))
        } else {
          print(paste("* * * Installing from CRAN:", pkgName, pkgVersion, sep = " "))
          if(pkgName == "remotes") {
            if(is.na(lib)) {
              install.packages("remotes", INSTALL_opts = "--no-multiarch")
            } else {
              install.packages("remotes", INSTALL_opts = "--no-multiarch", lib = lib)
            }
          } else {
            if(is.na(lib)) {
              remotes::install_version(pkgName, version = pkgVersion, upgrade = FALSE, force = TRUE, INSTALL_opts = "--no-multiarch")
            } else {
              remotes::install_version(pkgName, version = pkgVersion, upgrade = FALSE, force = TRUE, INSTALL_opts = "--no-multiarch", lib = lib)
            }
          }
        }
      },

      installFromGithub = function(pkgName, pkgVersion, lib = NA) {
        if (requireNamespace(pkgName, quietly = TRUE) == TRUE && self$packageVersionExists(pkgName, pkgVersion)) {
          print(paste("Correct version of package already installed: ", pkgName, pkgVersion, sep = " "))
        } else {
          print(paste("* * * Installing from GitHub:", pkgName, pkgVersion, sep = " "))
          if(is.na(lib)) {
            remotes::install_github(pkgName, ref=pkgVersion, upgrade = FALSE, force = TRUE, INSTALL_opts = "--no-multiarch")
          } else {
            remotes::install_github(pkgName, ref=pkgVersion, upgrade = FALSE, force = TRUE, INSTALL_opts = "--no-multiarch", lib = lib)
          }
        }
      },

      # ---
      #
      # removes
      #
      # ---

      removePackage = function(pkgName, lib = NA) {
        required <- requireNamespace(pkgName, quietly = TRUE)
        print(paste(pkgName, required, sep = ": "))
        if (required) {
          remove.packages(pkgName, lib = lib)
        }
      },

      forceRemovePackage = function(pkgName, lib = NA) {
        writeLines("* * * START FORCE REMOVE * * *")
        writeLines("The remove functions in R tend to throw exceptions for things like trying to remove a package that already has been removed.")
        writeLines("Generally these errors can be ignored.")
        writeLines("Check to see that the package was actually removed after running this function.")
        writeLines("(Use theon::getPackageDetails(pkgName))")
        tryCatch({
          devtools::unload(pkgname)
        }, error = function(e) {
          writeLines(paste0("The unload method skipped: ", pkgName))
        })
        tryCatch({
          remove.packages(pkgName)
        }, error = function(e) {
          writeLines(paste0("Remove of package skipped: ", pkgName))
        })
        tryCatch({
          # remove
          self$removePackage(pkgName, lib = lib)
        }, error = function(e) {
          writeLines(paste0("Remove of required package skipped: ", pkgName))
        })
      },

      removeForeign = function(pkgName, lib) {
        dirPath = paste0(lib, "/", pkgName)
        if (file.exists(dirPath)) {
          unlink(dirPath, recursive = TRUE)
          cat("Directory", dirPath, "removed successfully.\n")
        } else {
          cat("Directory", dirPath, "does not exist.\n")
        }
        writeLines("* * * END FORCE REMOVE * * *")
      },

      getPackageDetails = function(pkgName) {
        pkgDf <- installed.packages()
        pkgDf <- as.data.frame(pkgDf)
        if (pkgName %in% pkgDf$Package) {
          packageDetails <- pkgDf[pkgDf$Package == pkgName, ]
          packageList <- as.data.frame(packageDetails)
          return(packageList)
        } else {
          return(NA)
        }
      },

      getPackageDetailsAsList = function(pkgName) {
        pkgDf <- installed.packages()
        pkgDf <- as.data.frame(pkgDf)
        if (pkgName %in% pkgDf$Package) {
          packageDetails <- pkgDf[pkgDf$Package == pkgName, ]
          packageList <- as.list(packageDetails)
          return(packageList)
        } else {
          return(NA)
        }
      },

      getPackageVersion = function(pkgName) {
        deets <- self$getPackageDetails(pkgName)
        if(is.data.frame(deets) == TRUE && nrow(deets) > 0) {
          rtn <- deets$Version
          return(rtn)
        } else {
          return(NA)
        }
      }

    )

)




