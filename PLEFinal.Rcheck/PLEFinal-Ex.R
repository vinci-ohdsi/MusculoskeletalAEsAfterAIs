pkgname <- "PLEFinal"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
options(pager = "console")
base::assign(".ExTimings", "PLEFinal-Ex.timings", pos = 'CheckExEnv')
base::cat("name\tuser\tsystem\telapsed\n", file=base::get(".ExTimings", pos = 'CheckExEnv'))
base::assign(".format_ptime",
function(x) {
  if(!is.na(x[4L])) x[1L] <- x[1L] + x[4L]
  if(!is.na(x[5L])) x[2L] <- x[2L] + x[5L]
  options(OutDec = '.')
  format(x[1L:3L], digits = 7L)
},
pos = 'CheckExEnv')

### * </HEADER>
library('PLEFinal')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("execute")
### * execute

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: execute
### Title: Execute the Study
### Aliases: execute

### ** Examples

## Not run: 
##D connectionDetails <- createConnectionDetails(dbms = "postgresql",
##D                                              user = "joe",
##D                                              password = "secret",
##D                                              server = "myserver")
##D 
##D execute(connectionDetails,
##D         cdmDatabaseSchema = "cdm_data",
##D         cohortDatabaseSchema = "study_results",
##D         cohortTable = "cohort",
##D         oracleTempSchema = NULL,
##D         outputFolder = "c:/temp/study_results",
##D         maxCores = 4)
## End(Not run)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("execute", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("prepareForEvidenceExplorer")
### * prepareForEvidenceExplorer

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: prepareForEvidenceExplorer
### Title: Prepare results for the Evidence Explorer Shiny app.
### Aliases: prepareForEvidenceExplorer

### ** Examples


## Not run: 
##D # Add results from three databases to the Shiny app data folder:
##D prepareForEvidenceExplorer("ResultsMDCD.zip", "/shinyData")
##D prepareForEvidenceExplorer("ResultsMDCR.zip", "/shinyData")
##D prepareForEvidenceExplorer("ResultsCCAE.zip", "/shinyData")
##D 
##D # Launch the Shiny app:
##D launchEvidenceExplorer("/shinyData")
## End(Not run)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("prepareForEvidenceExplorer", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
