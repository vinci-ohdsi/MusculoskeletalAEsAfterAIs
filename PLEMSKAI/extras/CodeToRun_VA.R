library(PLEFinal)

# Optional: specify where the temporary files (used by the Andromeda package) will be created:
options(andromedaTempFolder = "D:/OHDSI/KS/PLEMSKAI/")

# Maximum number of cores to be used:
maxCores <- parallel::detectCores()

# The folder where the study intermediate and result files will be written:
outputFolder <- "D:/OHDSI/KS/output/PLEFinal"

# Details for connecting to the server:
dbms = "sql server"#Sys.getenv("DBMS")
server = "vhacdwdwhdbs102"#Sys.getenv("DB_SERVER")
pathToDriver <- "d:/JDBC/sqljdbc_6.0/enu/jre8"#if (Sys.getenv("PATH_TO_DRIVER") == "") NULL else Sys.getenv("PATH_TO_DRIVER")

# Details for connecting to your server  ----
# Details for connecting to your server  ----
connectionDetails <- createConnectionDetails(dbms = dbms,
                                             server = server,
                                             pathToDriver = pathToDriver)

# The name of the database schema where the CDM data can be found:
cdmDatabaseSchema <- "CDW_OMOP_Staging.scratch_matheny"

# The name of the database schema and table where the study-specific cohorts will be instantiated:
cohortDatabaseSchema <- "VINCI_OMOP.OHDSI_MSKAI_TVHS"
cohortTable <- "PLEMSKAI_Cohort"

# Some meta-information that will be used by the export function:
databaseId <- "TVHS_OMOP"
databaseName <- "TVHS_OMOP"
databaseDescription <- "TVHS subset of the VA OMOP database."

# For Oracle: define a schema that can be used to emulate temp tables:
oracleTempSchema <- NULL

execute(connectionDetails = connectionDetails,
        cdmDatabaseSchema = cdmDatabaseSchema,
        cohortDatabaseSchema = cohortDatabaseSchema,
        cohortTable = cohortTable,
        oracleTempSchema = oracleTempSchema,
        outputFolder = outputFolder,
        databaseId = databaseId,
        databaseName = databaseName,
        databaseDescription = databaseDescription,
        createCohorts = TRUE,
        synthesizePositiveControls = FALSE,
        runAnalyses = TRUE,
        packageResults = TRUE,
        maxCores = maxCores)

resultsZipFile <- file.path(outputFolder, "export", paste0("Results_", databaseId, ".zip"))
dataFolder <- file.path(outputFolder, "shinyData")

# You can inspect the results if you want:
prepareForEvidenceExplorer(resultsZipFile = resultsZipFile, dataFolder = dataFolder)
launchEvidenceExplorer(dataFolder = dataFolder, blind = TRUE, launch.browser = FALSE)

# Upload the results to the OHDSI SFTP server: ideally please name the folder 'PLE-database-results' within AiEstimation
privateKeyFileName <- ""
userName <- ""
uploadResults(outputFolder, privateKeyFileName, userName)
