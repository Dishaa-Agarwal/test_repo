USE DATABASE FEATURESTORE_DB;
USE SCHEMA FEATURESTORE_SCHEMA;
USE ROLE FEATURESTORE_ROLE;

CALL COMMAND_CENTER_CREATE('FD_WINE', 'TABLES', 'ALL');
CALL COMMAND_CENTER_CREATE('FD_TAXI', 'TABLES', 'ALL');
CALL COMMAND_CENTER_CREATE('FD_SALES', 'TABLES', 'ALL');
CALL COMMAND_CENTER_CREATE('FD_PARAMETER', 'TABLES', 'ALL');

CALL COMMAND_CENTER_CREATE('FD_WINE', 'STAGES & PIPES', NULL);
CALL COMMAND_CENTER_CREATE('FD_TAXI', 'STAGES & PIPES', NULL);
CALL COMMAND_CENTER_CREATE('FD_SALES', 'STAGES & PIPES', NULL);

CALL SP_FD_WINE_REFRESH_TASKS();
CALL SP_FD_TAXI_REFRESH_TASKS();
CALL SP_FD_SALES_REFRESH_TASKS();
CALL SP_EMAIL_TASK();
CALL SP_FD_PARAMETER_REFRESH_TASKS();

ALTER TASK LOAD_FD_WINE_STAGE_INTO_BRONZE_RAW SUSPEND;
ALTER TASK LOAD_FD_WINE_BRONZE_RAW_INTO_SILVER_CLEAN SUSPEND;
ALTER TASK LOAD_FD_WINE_SILVER_CLEAN_INTO_GOLD_ACID SUSPEND;
ALTER TASK LOAD_FD_WINE_SILVER_CLEAN_INTO_GOLD_DIOXIDE SUSPEND;
ALTER TASK LOAD_FD_WINE_SILVER_CLEAN_INTO_GOLD_OTHER SUSPEND;
ALTER TASK LOAD_FD_TAXI_FEATURES SUSPEND;
ALTER TASK LOAD_FD_SALES_STAGE_INTO_BRONZE_RAW SUSPEND;
ALTER TASK LOAD_FD_SALES_BRONZE_RAW_INTO_SILVER_CLEAN SUSPEND;
ALTER TASK LOAD_FD_SALES_SILVER_CLEAN_INTO_GOLD SUSPEND;
ALTER TASK LOAD_INIT SUSPEND;
ALTER TASK LOAD_FD_PARAMETER_SILVER_CLEAN_INTO_GOLD_DIOXIDE SUSPEND;
ALTER TASK LOAD_FD_PARAMETER_SILVER_CLEAN_INTO_GOLD_OTHER SUSPEND;
ALTER TASK LOAD_FD_PARAMETER_SILVER_CLEAN_INTO_GOLD_OTHER SUSPEND;
ALTER TASK EMAIL SUSPEND;
