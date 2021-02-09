

CREATE OR REPLACE VIEW  SURVEY.VIEW_NLP_DETAILS AS 
SELECT DISTINCT
    S.ANSWERID AS ANSWERID,
    --SPLIT(ADJECTIVES_NOUNS,',')
    TO_VARCHAR(TRIM(C.value)) AS ADJECTIVES_NOUNS,
    TO_VARCHAR(TRIM(K.value)) AS KEYWORDS,
    COUNT(*) AS COUNT
FROM
    SURVEYS_NLP S,
    LATERAL FLATTEN(input=>SPLIT(ADJECTIVES_NOUNS,',')) C,
    LATERAL FLATTEN(input=>SPLIT(KEYWORDS,',')) K
//   ATERAL FLATTEN(input=>split(children, ',')) C;

//WHERE
//	((S."ADJECTIVES_NOUNS") = 'pitkä jonotus#aika, epä#selvä aika#taulu, turha info, yksinkertainen tieto')
GROUP BY 
    1,2,3;

GRANT REFERENCES ON TABLE SURVEY.VIEW_NLP_DETAILS TO ROLE SYSADMIN;
GRANT UPDATE ON TABLE SURVEY.VIEW_NLP_DETAILS TO ROLE SYSADMIN;
GRANT REBUILD ON TABLE SURVEY.VIEW_NLP_DETAILS TO ROLE SYSADMIN;
GRANT SELECT ON TABLE SURVEY.VIEW_NLP_DETAILS TO ROLE LOOKER_SURVEYPAL;
GRANT DELETE ON TABLE SURVEY.VIEW_NLP_DETAILS TO ROLE SYSADMIN;
GRANT INSERT ON TABLE SURVEY.VIEW_NLP_DETAILS TO ROLE SYSADMIN;
GRANT SELECT ON TABLE SURVEY.VIEW_NLP_DETAILS TO ROLE SYSADMIN;
GRANT TRUNCATE ON TABLE SURVEY.VIEW_NLP_DETAILS TO ROLE SYSADMIN;
GRANT OWNERSHIP ON TABLE SURVEY.VIEW_NLP_DETAILS TO ROLE SYSADMIN;
