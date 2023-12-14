USE DATABASE FEATURESTORE_DB; -- noqa: PRS
USE SCHEMA FEATURESTORE_SCHEMA;
USE ROLE FEATURESTORE_ROLE;

CREATE OR REPLACE TABLE FEATURESTORE_DB.FEATURESTORE_SCHEMA.PARAMETERS(
    PARAM_1 VARCHAR NULL
);

INSERT INTO FEATURESTORE_DB.FEATURESTORE_SCHEMA.PARAMETERS (PARAM_1) VALUES ('ALL');

CREATE OR REPLACE TASK FEATURESTORE_DB.FEATURESTORE_SCHEMA.LOAD_INIT
    warehouse='FEATURESTORE_WH'
    schedule='1 MINUTES'
AS
CALL SP_INIT();

ALTER TASK FEATURESTORE_DB.FEATURESTORE_SCHEMA.LOAD_INIT RESUME;
