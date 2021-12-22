
## Packages -----
# cran packages ----- 
# If any of these are not already installed, use install.packages
# For example, for devtools: install.packages("devtools")
library(devtools)
library(dplyr)
library(ggplot2)
library(SqlRender)
library(DatabaseConnector)
library(parallel)
library(rJava)

# github packages -----
#please install the following versions of packages to enures consistency if not already installed
#install_github("OHDSI/FeatureExtraction@v3.1.0", force=TRUE)
#install_github("OHDSI/Andromeda@v0.4.0", force=TRUE)
#install_github("OHDSI/OhdsiSharing@v0.2.2", force=TRUE)
library(FeatureExtraction)
library(Andromeda)
library(OhdsiSharing)

#download the study package
#install_github("edward-burn/CohortDiagnostics", branch = "DiagAi", force=TRUE)
library(CohortDiagnostics)

# Load the study package ----- 
# First, make sure you are currently inside the DiagAi.Rproj - you can see this at the top left
# Then navigate to Build in the top right panel, and click "Install and Restart" and build the package
library(MSKAI)

# Specify an andromedaTempFolder -----
# this is where temporary objects will be created
options(andromedaTempFolder = "D:/OHDSI/KS/")

# Maximum number of cores to be used ----
maxCores <- detectCores()

# Details for connecting to the server:
dbms = "sql server"#Sys.getenv("DBMS")
server = "vhacdwdwhdbs101"#Sys.getenv("DB_SERVER")
pathToDriver <- "d:/JDBC/sqljdbc_6.0/enu/jre8"#if (Sys.getenv("PATH_TO_DRIVER") == "") NULL else Sys.getenv("PATH_TO_DRIVER")

# Details for connecting to your server  ----
# Details for connecting to your server  ----
connectionDetails <- createConnectionDetails(dbms = dbms,
                                             server = server,
                                             pathToDriver = pathToDriver)

# Details specific to the database ----
cdmDatabaseSchema <- "CDW_OMOP_Staging.scratch_matheny" #The name of the schema that contains your cdm
cohortDatabaseSchema <- "VINCI_OMOP.OHDSI_MSKAI_TVHS" #The name of the schema where you want to create the results table
cohortTable <- "MSKAI_Cohort" # the name of the results table that will go in your results schema- we have used "MSKAI"
databaseId <- "TVHS_OMOP"  # A short name for your database
databaseName <- "TVHS_OMOP" # A name for your database (can be the same as databaseId)
databaseDescription <- "TVHS subset of the VA OMOP database." # A brief description of your database (i.e. one or two sentences)

# For Oracle: define a schema that can be used to emulate temp tables  
oracleTempSchema <- NULL #if not oracle, leave as NULL

# Specify your output folder ----
# A path to a folder where your results will be saved 
# The results to share will be stored in the diagnosticsExport subfolder of the outputFolder. 
outputFolder <- "D:/OHDSI/KS/output/MSKAI_TVHS"

# Run -----
# Run the study 
MSKAI::runCohortDiagnostics(connectionDetails = connectionDetails,
                             cdmDatabaseSchema = cdmDatabaseSchema,
                             cohortDatabaseSchema = cohortDatabaseSchema,
                             cohortTable = cohortTable,
                             oracleTempSchema = oracleTempSchema,
                             outputFolder = outputFolder,
                             databaseId = databaseId,
                             databaseName = databaseName,
                             databaseDescription = databaseDescription,
                             createCohorts = TRUE,
                             runInclusionStatistics = TRUE,
                             runIncludedSourceConcepts = TRUE,
                             runOrphanConcepts = TRUE,
                             runTimeDistributions = TRUE,
                             runBreakdownIndexEvents = TRUE,
                             runIncidenceRates = TRUE,
                             runCohortOverlap = TRUE,
                             runCohortCharacterization = TRUE,
                             runTemporalCohortCharacterization = TRUE,
                             minCellCount = 5)

# To view your results -----
# merge and then view
CohortDiagnostics::preMergeDiagnosticsFiles(file.path(outputFolder, "diagnosticsExport"))
CohortDiagnostics::launchDiagnosticsExplorer(file.path(outputFolder, "diagnosticsExport"))

# To share your results -----
# To share your results to the sftp server, you will need to have the study-data-site-ndorms.dat file
# specify the path to that file here (eg "C:/study-data-site-ndorms.dat")
file.path.private.key<-""   

# please run the below without changing the userName or remoteFolder 
# this will share the diagnosticsExport zip folder in your output folder
OhdsiSharing::sftpUploadFile(privateKeyFileName = file.path.private.key,
         userName = "study-data-site-ndorms",
         remoteFolder = "AiEstimation/AiEstimationCohortDiagnostics",
         fileName = file.path(outputFolder, "diagnosticsExport") )
