CREATE STAGE "SURVEY"."STAGE_SURVEY" 
SET STORAGE_INTEGRATION = AZURE_INT 
URL = 'azure://storagewbdltest.blob.core.windows.net/survey';