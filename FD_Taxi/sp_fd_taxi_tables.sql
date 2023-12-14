USE DATABASE FEATURESTORE_DB; -- noqa: PRS
USE SCHEMA FEATURESTORE_SCHEMA;
USE ROLE FEATURESTORE_ROLE;

CREATE OR REPLACE PROCEDURE SP_FD_TAXI_TABLES(LAYER VARCHAR)
RETURNS VARCHAR(16777216)
LANGUAGE SQL
AS '
BEGIN
    IF (UPPER(LAYER) IN (''BRONZE'', ''ALL'')) THEN
        CREATE OR REPLACE TABLE BRONZE_FD_TAXI_RAW(
            TPEP_PICKUP_DATETIME TIMESTAMP_NTZ(9),
            TPEP_DROPOFF_DATETIME TIMESTAMP_NTZ(9),
            TRIP_DISTANCE FLOAT,
            PICKUP_ZIP NUMBER(38,0),
            DROPOFF_ZIP NUMBER(38,0),
            FARE_AMOUNT FLOAT
        );
    END IF;

    IF (UPPER(LAYER) IN (''SILVER'', ''ALL'')) THEN
        CREATE OR REPLACE TABLE SILVER_FD_TAXI_CLEAN(
            TPEP_PICKUP_DATETIME TIMESTAMP_NTZ(9),
            TPEP_DROPOFF_DATETIME TIMESTAMP_NTZ(9),
            TRIP_DISTANCE FLOAT,
            PICKUP_ZIP NUMBER(38,0),
            DROPOFF_ZIP NUMBER(38,0),
            FARE_AMOUNT FLOAT
        );
    END IF;

    IF (UPPER(LAYER) IN (''GOLD'', ''ALL'')) THEN
        CREATE OR REPLACE TABLE GOLD_FD_TAXI_DROPOFF(
            ZIP NUMBER(38,0),
            TS TIMESTAMP_NTZ(9),
            COUNT_TRIPS_WINDOW_30M_DROPOFF_ZIP NUMBER(38,0),
            DROPOFF_IS_WEEKEND NUMBER(38,0)
        );

        CREATE OR REPLACE TABLE GOLD_FD_TAXI_PICKUP(
            ZIP NUMBER(38,0),
            TS TIMESTAMP_NTZ(9),
            COUNT_TRIPS_WINDOW_1H_PICKUP_ZIP NUMBER(38,0),
            MEAN_FARE_WINDOW_1H_PICKUP_ZIP NUMBER(38,0)
        );
    END IF;
    RETURN CONCAT(''Created Tables for '', LAYER, '' LAYER(s)'');
END';