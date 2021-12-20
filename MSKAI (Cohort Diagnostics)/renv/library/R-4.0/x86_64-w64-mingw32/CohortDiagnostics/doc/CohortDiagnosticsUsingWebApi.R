## ---- echo = FALSE, message = FALSE-------------------------------------------
library(SqlRender)
knitr::opts_chunk$set(
  cache = FALSE,
  comment = "#>",
  error = FALSE,
  tidy = FALSE)


## ----tidy=FALSE,eval=FALSE----------------------------------------------------
## library(CohortDiagnostics)
## cohortSetReference <- read.csv("cohortsToDiagnose.csv")
## 


## ----tidy=FALSE,eval=FALSE----------------------------------------------------
## connectionDetails <- createConnectionDetails(dbms = "postgresql",
##                                              server = "localhost/ohdsi",
##                                              user = "joe",
##                                              password = "supersecret")
## 
## cdmDatabaseSchema <- "my_cdm_data"
## oracleTempSchema <- NULL
## cohortDatabaseSchema <- "my_schema"
## cohortTable <- "my_cohort_table"


## ----tidy=FALSE,eval=FALSE----------------------------------------------------
## createCohortTable(connectionDetails = connectionDetails,
##                   cohortDatabaseSchema = cohortDatabaseSchema,
##                   cohortTable = cohortTable)


## ----tidy=FALSE,eval=FALSE----------------------------------------------------
## baseUrl <- "http://server.org:80/WebAPI"
## inclusionStatisticsFolder <- "c:/temp/incStats"
## 
## instantiateCohortSet(connectionDetails = connectionDetails,
##                      cdmDatabaseSchema = cdmDatabaseSchema,
##                      oracleTempSchema = oracleTempSchema,
##                      cohortDatabaseSchema = cohortDatabaseSchema,
##                      cohortTable = cohortTable,
##                      baseUrl = baseUrl,
##                      cohortSetReference = cohortSetReference,
##                      generateInclusionStats = TRUE,
##                      inclusionStatisticsFolder = inclusionStatisticsFolder)


## ----tidy=FALSE,eval=FALSE----------------------------------------------------
## databaseId <- "MyData"
## exportFolder <- "c:/temp/export"
## 
## runCohortDiagnostics(baseUrl = baseUrl,
##                      cohortSetReference = cohortSetReference,
##                      connectionDetails = connectionDetails,
##                      cdmDatabaseSchema = cdmDatabaseSchema,
##                      oracleTempSchema = oracleTempSchema,
##                      cohortDatabaseSchema = cohortDatabaseSchema,
##                      cohortTable = cohortTable,
##                      inclusionStatisticsFolder = inclusionStatisticsFolder,
##                      exportFolder = exportFolder,
##                      databaseId = databaseId,
##                      runInclusionStatistics = TRUE,
##                      runIncludedSourceConcepts = TRUE,
##                      runOrphanConcepts = TRUE,
##                      runTimeDistributions = TRUE,
##                      runBreakdownIndexEvents = TRUE,
##                      runIncidenceRate = TRUE,
##                      runCohortOverlap = TRUE,
##                      runCohortCharacterization = TRUE,
##                      minCellCount = 5)


## ----tidy=FALSE,eval=FALSE----------------------------------------------------
## preMergeDiagnosticsFiles("C:/temp/allZipFiles")


## ----tidy=FALSE,eval=FALSE----------------------------------------------------
## launchDiagnosticsExplorer("C:/temp/allZipFiles")

