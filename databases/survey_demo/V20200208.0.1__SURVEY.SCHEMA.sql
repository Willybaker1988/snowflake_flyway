CREATE SCHEMA SURVEY;


GRANT CREATE PROCEDURE ON  SCHEMA SURVEY TO ROLE LOOKER_SURVEYPAL;
GRANT CREATE STAGE ON  SCHEMA SURVEY TO ROLE SYSADMIN;
GRANT CREATE TABLE ON  SCHEMA SURVEY TO ROLE SYSADMIN;
GRANT CREATE VIEW ON  SCHEMA SURVEY TO ROLE SYSADMIN;
GRANT USAGE ON  SCHEMA SURVEY TO ROLE SYSADMIN;