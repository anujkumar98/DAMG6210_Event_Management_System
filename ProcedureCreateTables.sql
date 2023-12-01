SET SERVEROUTPUT ON;
-- Create tables 
-- Check if the table 'attendee' exists in the user's schema
DECLARE
    V_TABLE_EXISTS VARCHAR(1) := 'N';
    V_CREATE_TABLE VARCHAR(2500);
BEGIN
SELECT 'Y'
    INTO V_TABLE_EXISTS
    FROM USER_TABLES
  WHERE TABLE_NAME = 'ATTENDEE';
EXCEPTION
WHEN NO_DATA_FOUND THEN
    V_CREATE_TABLE := '
    CREATE TABLE ATTENDEE (
    attendee_username  VARCHAR2(25 CHAR) NOT NULL,
    attendee_id        INTEGER NOT NULL,
    attendee_firstname VARCHAR2(45 CHAR) NOT NULL,
    attendee_lastname  VARCHAR2(45 CHAR),
    attendee_email     VARCHAR2(45 CHAR) NOT NULL,
    attendee_mobile_no  VARCHAR2(45 CHAR) NOT NULL,
    attendee_age       INTEGER NOT NULL,
    attendee_gender    VARCHAR2(10 CHAR),
    attendee_created_at TIMESTAMP DEFAULT systimestamp
    )';  
     EXECUTE IMMEDIATE V_CREATE_TABLE;
     EXECUTE IMMEDIATE 'ALTER TABLE ATTENDEE ADD CONSTRAINT attendee_pk PRIMARY KEY (attendee_id)';
    EXECUTE IMMEDIATE 'ALTER TABLE ATTENDEE  ADD CONSTRAINT unique_attendee_username UNIQUE (attendee_username)';
END;
/
-- Check if the table 'event_type' exists in the user's schema
DECLARE
    V_TABLE_EXISTS VARCHAR(1) := 'N';
    V_CREATE_TABLE VARCHAR(2500);
BEGIN
SELECT 'Y'
    INTO V_TABLE_EXISTS
    FROM USER_TABLES
  WHERE TABLE_NAME = 'EVENT_TYPE';
     -- If the table 'event_type' doesn't exist, create it
EXCEPTION
WHEN NO_DATA_FOUND THEN
    V_CREATE_TABLE := '
    CREATE TABLE EVENT_TYPE(
        event_type_id             INTEGER NOT NULL,
        event_type_category       VARCHAR2(45 CHAR) NOT NULL ,
        event_type_description    VARCHAR2(255 CHAR),
        event_type_age_restiricted NUMBER NOT NULL,
        event_type_created_at TIMESTAMP DEFAULT systimestamp
        )';  
     EXECUTE IMMEDIATE V_CREATE_TABLE;
     
     EXECUTE IMMEDIATE 'ALTER TABLE EVENT_TYPE ADD CONSTRAINT eventtype_pk PRIMARY KEY ( event_type_id )';
     EXECUTE IMMEDIATE 'ALTER TABLE EVENT_TYPE ADD CONSTRAINT unique_eventtypecategory UNIQUE (event_type_category)';
     
END;
/
-- Check if the table 'venue' exists in the user's schema
DECLARE
    V_TABLE_EXISTS VARCHAR(1) := 'N';
    V_CREATE_TABLE VARCHAR(2500);
BEGIN
SELECT 'Y'
    INTO V_TABLE_EXISTS
    FROM USER_TABLES
  WHERE TABLE_NAME = 'VENUE';
     -- If the table 'venue' doesn't exist, create it
EXCEPTION
WHEN NO_DATA_FOUND THEN
    V_CREATE_TABLE := '
    CREATE TABLE VENUE(
        venue_id            INTEGER NOT NULL,
        venue_name          VARCHAR2(255 CHAR) NOT NULL,
        venue_address       VARCHAR2(255 CHAR),
        venue_total_capacity INTEGER NOT NULL,
        venue_email         VARCHAR2(45 CHAR),
        venue_created_at    TIMESTAMP DEFAULT SYSTIMESTAMP
        )';  
     EXECUTE IMMEDIATE V_CREATE_TABLE;
     EXECUTE IMMEDIATE 'ALTER TABLE VENUE ADD CONSTRAINT venue_pk PRIMARY KEY ( venue_id )';
END;
/

-- Check if the table 'events' exists in the user's schema
DECLARE
    V_TABLE_EXISTS VARCHAR(1) := 'N';
    V_CREATE_TABLE VARCHAR(2500);
BEGIN
SELECT 'Y'
    INTO V_TABLE_EXISTS
    FROM USER_TABLES
  WHERE TABLE_NAME = 'EVENTS';
     -- If the table 'events' doesn't exist, create it
EXCEPTION
WHEN NO_DATA_FOUND THEN
    V_CREATE_TABLE := '
    CREATE TABLE EVENTS(
        event_id          INTEGER NOT NULL,
        event_name        VARCHAR2(45 CHAR) NOT NULL,
        event_description VARCHAR2(255 CHAR),
        event_status      VARCHAR2(45 CHAR) NOT NULL,
        event_starttime   TIMESTAMP NOT NULL,
        event_endtime     TIMESTAMP NOT NULL,
        event_type_id      INTEGER NOT NULL,
        event_venue_id     INTEGER NOT NULL,
        event_created_at   TIMESTAMP DEFAULT systimestamp
        )';  
     EXECUTE IMMEDIATE V_CREATE_TABLE;
     EXECUTE IMMEDIATE 'ALTER TABLE EVENTS ADD CONSTRAINT event_pk PRIMARY KEY ( event_id )';
     EXECUTE IMMEDIATE 'ALTER TABLE EVENTS ADD CONSTRAINT unique_event UNIQUE (event_name)';
END;
/



-- Check if the table 'promotions' exists in the user's schema
DECLARE
    V_TABLE_EXISTS VARCHAR(1) := 'N';
    V_CREATE_TABLE VARCHAR(2500);
BEGIN
SELECT 'Y'
    INTO V_TABLE_EXISTS
    FROM USER_TABLES
  WHERE TABLE_NAME = 'PROMOTIONS';
     -- If the table 'promotions' doesn't exist, create it
EXCEPTION
WHEN NO_DATA_FOUND THEN
    V_CREATE_TABLE := '
    CREATE TABLE PROMOTIONS(
       promotion_id        INTEGER NOT NULL,
        promotion_code      VARCHAR2(45 CHAR) NOT NULL,
        promotion_startdate TIMESTAMP NOT NULL,
        promotion_enddate   TIMESTAMP NOT NULL,
        promotion_discount  NUMBER(5, 2) NOT NULL,
        promotion_max_count  INTEGER NOT NULL,
        event_id            INTEGER NOT NULL,
        promotions_created_at TIMESTAMP DEFAULT systimestamp
        )';  
     EXECUTE IMMEDIATE V_CREATE_TABLE;
     EXECUTE IMMEDIATE 'ALTER TABLE PROMOTIONS ADD CONSTRAINT promotions_pk PRIMARY KEY ( promotion_id )';
END;
/


-- Check if the table 'reviews' exists in the user's schema
DECLARE
    V_TABLE_EXISTS VARCHAR(1) := 'N';
    V_CREATE_TABLE VARCHAR(2500);
BEGIN
SELECT 'Y'
    INTO V_TABLE_EXISTS
    FROM USER_TABLES
  WHERE TABLE_NAME = 'REVIEWS';
     -- If the table 'reviews' doesn't exist, create it
EXCEPTION
WHEN NO_DATA_FOUND THEN
    V_CREATE_TABLE := '
    CREATE TABLE REVIEWS(
        review_id          INTEGER NOT NULL,
        review_description VARCHAR2(5000 CHAR) NOT NULL,
        event_id           INTEGER NOT NULL,
        attendee_id        INTEGER NOT NULL,
        review_created_at  TIMESTAMP DEFAULT systimestamp
        )';  
     EXECUTE IMMEDIATE V_CREATE_TABLE;
     EXECUTE IMMEDIATE 'ALTER TABLE REVIEWS ADD CONSTRAINT reviews_pk PRIMARY KEY ( review_id )';
END;
/


-- Check if the table 'ticket' exists in the user's schema
DECLARE
    V_TABLE_EXISTS VARCHAR(1) := 'N';
    V_CREATE_TABLE VARCHAR(2500);
BEGIN
SELECT 'Y'
    INTO V_TABLE_EXISTS
    FROM USER_TABLES
  WHERE TABLE_NAME = 'TICKET';
     -- If the table 'ticket' doesn't exist, create it
EXCEPTION
WHEN NO_DATA_FOUND THEN
    V_CREATE_TABLE := '
    CREATE TABLE TICKET(
        ticket_id                     INTEGER NOT NULL,
        ticket_category_name           VARCHAR2(20 CHAR) NOT NULL,
        ticket_price                  NUMBER(5, 2) NOT NULL,
        ticket_seats                  INTEGER NOT NULL,
        ticket_max_booking_count_per_user INTEGER NOT NULL,
        event_id                      INTEGER NOT NULL,
        ticket_created_at  TIMESTAMP DEFAULT systimestamp
        )';  
     EXECUTE IMMEDIATE V_CREATE_TABLE;
     EXECUTE IMMEDIATE 'ALTER TABLE TICKET ADD CONSTRAINT ticket_pk PRIMARY KEY ( ticket_id )';
END;
/
-- Check if the table 'booking' exists in the user's schema
DECLARE
    V_TABLE_EXISTS VARCHAR(1) := 'N';
    V_CREATE_TABLE VARCHAR(2500);
BEGIN
SELECT 'Y'
    INTO V_TABLE_EXISTS
    FROM USER_TABLES
  WHERE TABLE_NAME = 'BOOKING';
     -- If the table 'booking' doesn't exist, create it
EXCEPTION
WHEN NO_DATA_FOUND THEN
    V_CREATE_TABLE := '
    CREATE TABLE BOOKING(
       booking_id          INTEGER NOT NULL,
        booking_ticket_count INTEGER NOT NULL,
        booking_status      VARCHAR2(45 CHAR),
        booking_amount      NUMBER(5,2),
        booking_date        TIMESTAMP DEFAULT systimestamp,
        attendee_id         INTEGER NOT NULL,
        promotion_id        INTEGER NOT NULL,
        ticket_id           INTEGER NOT NULL
        )';  
     EXECUTE IMMEDIATE V_CREATE_TABLE;
     EXECUTE IMMEDIATE 'ALTER TABLE BOOKING ADD CONSTRAINT booking_pk PRIMARY KEY ( booking_id)';
END;
/


--Adding foreign key constraints
CREATE OR REPLACE PROCEDURE add_foreign_key_constraint (
    p_table_name        VARCHAR2,
    p_constraint_name   VARCHAR2,
    p_foreign_key       VARCHAR2,
    p_referenced_table  VARCHAR2,
    p_referenced_column VARCHAR2
) AS
    v_constraint_count NUMBER;
BEGIN
    -- Check if the foreign key constraint already exists
    SELECT
        COUNT(*)
    INTO v_constraint_count
    FROM
        user_constraints
    WHERE
            table_name = p_table_name AND constraint_name = p_constraint_name
        AND constraint_type = 'R';

    -- If the constraint doesn't exist, add it
    IF v_constraint_count = 0 THEN
        EXECUTE IMMEDIATE 'ALTER TABLE ' || p_table_name|| ' ADD CONSTRAINT ' || p_constraint_name|| ' FOREIGN KEY (' || p_foreign_key
                          || ')' || ' REFERENCES ' || p_referenced_table || '(' || p_referenced_column || ')';

    END IF;

END add_foreign_key_constraint;
/



-- Added attendee audit table to store the deleted user records
DECLARE
    V_TABLE_EXISTS VARCHAR(1) := 'N';
    V_CREATE_TABLE VARCHAR(2500);
BEGIN
SELECT 'Y'
    INTO V_TABLE_EXISTS
    FROM USER_TABLES
  WHERE TABLE_NAME = 'ATTENDEE_AUDIT';
EXCEPTION
WHEN NO_DATA_FOUND THEN
    V_CREATE_TABLE := '
    CREATE TABLE ATTENDEE_AUDIT (
        attendee_username VARCHAR2(25 CHAR) NOT NULL,
        attendee_id INTEGER NOT NULL,
        attendee_firstname VARCHAR2(45 CHAR) NOT NULL,
        attendee_lastname VARCHAR2(45 CHAR),
        attendee_email VARCHAR2(45 CHAR) NOT NULL,
        attendee_mobile_no VARCHAR2(45 CHAR) NOT NULL,
        attendee_age INTEGER NOT NULL ,
        attendee_gender VARCHAR2 ( 10 CHAR ),
        attendee_created_at TIMESTAMP,
        attendee_deleted_date TIMESTAMP DEFAULT SYSTIMESTAMP
    )';  
     EXECUTE IMMEDIATE V_CREATE_TABLE;
     EXECUTE IMMEDIATE 'ALTER TABLE ATTENDEE_AUDIT ADD CONSTRAINT attendee_audit_pk PRIMARY KEY (attendee_id)';
END;
/