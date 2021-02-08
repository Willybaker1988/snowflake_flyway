
CREATE TABLE KAITO.SURVEYS_NLP (
	SURVEYID VARIANT,
	ANSWERID VARCHAR(16777216),
	SERVICEQUEUENAME VARCHAR(16777216),
	NAMEOFAGENT VARIANT,
	QUESTION1 VARCHAR(16777216),
	QUESTION2 VARIANT,
	QUESTION3 VARIANT,
	OPENTEXT VARIANT,
	QUESTION4ICON VARCHAR(16777216),
	NOUNS VARCHAR(16777216),
	VERBS VARCHAR(16777216),
	ADJECTIVES VARCHAR(16777216),
	ADJECTIVES_NOUNS VARCHAR(16777216),
	KEYWORDS VARCHAR(16777216),
	PCA VARCHAR(16777216),
	KMEANS VARIANT,
	"$1" VARIANT
);
GRANT SELECT ON TABLE KAITO.SURVEYS_NLP TO ROLE SYSADMIN;
GRANT OWNERSHIP ON TABLE KAITO.SURVEYS_NLP TO ROLE SYSADMIN;
GRANT SELECT ON TABLE KAITO.SURVEYS_NLP TO ROLE LOOKER_SURVEYPAL;
GRANT UPDATE ON TABLE KAITO.SURVEYS_NLP TO ROLE SYSADMIN;
GRANT DELETE ON TABLE KAITO.SURVEYS_NLP TO ROLE SYSADMIN;
GRANT REFERENCES ON TABLE KAITO.SURVEYS_NLP TO ROLE SYSADMIN;
GRANT INSERT ON TABLE KAITO.SURVEYS_NLP TO ROLE SYSADMIN;
GRANT REBUILD ON TABLE KAITO.SURVEYS_NLP TO ROLE SYSADMIN;
GRANT TRUNCATE ON TABLE KAITO.SURVEYS_NLP TO ROLE SYSADMIN;