# ---
#
# A class to encapsulate basic library/package related functionality
#
# ---

library(R6)

OhdsiLibUtil = R6Class(

    classname = "OhdsiLibUtil",

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

      installFromCran = function(pkgName, pkgVersion) {
        if (requireNamespace(pkgName, quietly = TRUE) == TRUE && self$packageVersionExists(pkgName, pkgVersion)) {
          print(paste("Correct version of package already installed: ", pkgName, pkgVersion, sep = " "))
        } else {
          print(paste("* * * Installing from CRAN:", pkgName, pkgVersion, sep = " "))
          if(pkgName == "remotes") {
            install.packages("remotes", INSTALL_opts = "--no-multiarch")
          } else {
            remotes::install_version(pkgName, version = pkgVersion, upgrade = FALSE, INSTALL_opts = "--no-multiarch", )
          }
        }
      },

      installFromGithub = function(pkgName, pkgVersion) {
        if (requireNamespace(pkgName, quietly = TRUE) == TRUE && self$packageVersionExists(pkgName, pkgVersion)) {
          print(paste("Correct version of package already installed: ", pkgName, pkgVersion, sep = " "))
        } else {
          print(paste("* * * Installing from GitHub:", pkgName, pkgVersion, sep = " "))
          remotes::install_github(pkgName, ref=pkgVersion, upgrade = FALSE, INSTALL_opts = "--no-multiarch")
        }
      },

      # ---
      #
      # removes
      #
      # ---

      removePackage = function(pkgName) {
        required <- requireNamespace(pkgName, quietly = TRUE)
        print(paste(pkgName, required, sep = ": "))
        if (required) {
          remove.packages(pkgName)
        }
      },

      forceRemovePackage = function(pkgName) {
        tryCatch({
          devtools::unload(pkgname)
        }, error = function(e) {
          writeLines(paste0("COULD NOT UNLOAD PACKAGE: ", pkgName))
        })
        tryCatch({
          self$removePackage(pkgName)
        }, error = function(e) {
          writeLines(paste0("COULD NOT REMOVE PACKAGE: ", pkgName))
        })
      }

    )
)
