/* 
    Code  for inserting data into event_app_admin package
    THIS SCRIPT SHOULD BE RUN BY EVENT_APP_ADMIN.
*/
set serveroutput on;
alter session set nls_timestamp_format = 'DD-MON-RR HH.MI';

CREATE OR REPLACE PACKAGE pkg_app_admin AS
    PROCEDURE ADD_EVENT_TYPE(
    PI_EVENT_TYPE_CATEGORY event_type.event_type_category%TYPE,
    PI_EVENT_TYPE_DESCRIPTION event_type.event_type_description%TYPE,
    PI_EVENT_TYPE_AGE_RESTRICTED event_type.event_type_age_restiricted%TYPE
);
PROCEDURE ADD_VENUE(
    PI_VENUE_NAME VENUE.venue_name%TYPE,
    PI_VENUE_ADDRESS VENUE.venue_address%TYPE,
    PI_VENUE_TOTAL_CAPACITY VENUE.venue_total_capacity%TYPE,
    PI_VENUE_EMAIL VENUE.venue_email%TYPE
);
    
END pkg_app_admin;
/

CREATE OR REPLACE PACKAGE BODY pkg_app_admin AS

    PROCEDURE ADD_EVENT_TYPE(
    PI_EVENT_TYPE_CATEGORY event_type.event_type_category%TYPE,
    PI_EVENT_TYPE_DESCRIPTION event_type.event_type_description%TYPE,
    PI_EVENT_TYPE_AGE_RESTRICTED event_type.event_type_age_restiricted%TYPE
)
AS
    E_INVALID_CATEGORY EXCEPTION;
    E_CATEGORY_EXISTS  EXCEPTION;
    E_EVENT_TYPE_AGE_RESTRICTED EXCEPTION;
    v_evnet_type_count NUMBER;
        
    BEGIN
  -- Check if the username already exists
    SELECT COUNT(*)
    INTO v_evnet_type_count
    FROM event_type
    WHERE event_type_category = PI_EVENT_TYPE_CATEGORY;

    IF v_evnet_type_count > 0
    THEN
        RAISE E_CATEGORY_EXISTS;
    END IF;
    -- Check for valid event type category
    IF PI_EVENT_TYPE_CATEGORY IS NULL
    THEN
        RAISE E_INVALID_CATEGORY;
    END IF;
    
    IF PI_EVENT_TYPE_AGE_RESTRICTED IS NOT NULL AND PI_EVENT_TYPE_AGE_RESTRICTED < 0
    THEN 
        RAISE E_EVENT_TYPE_AGE_RESTRICTED;
    END IF;
    

    -- Insert into EVENT_TYPE table
    INSERT INTO EVENT_TYPE (
        event_type_id,
        event_type_category,
        event_type_description,
        event_type_age_restiricted
    ) VALUES (
        SEQ_EVENT_TYPE.NEXTVAL,
        PI_EVENT_TYPE_CATEGORY,
        PI_EVENT_TYPE_DESCRIPTION,
        PI_EVENT_TYPE_AGE_RESTRICTED
    );
    COMMIT;

EXCEPTION
    WHEN E_INVALID_CATEGORY THEN
        DBMS_OUTPUT.PUT_LINE('PLEASE ENTER A VALID EVENT TYPE CATEGORY.');
    WHEN E_CATEGORY_EXISTS THEN
        DBMS_OUTPUT.PUT_LINE('EVENT CATEGORY ALREADY EXISTS');  
    WHEN E_EVENT_TYPE_AGE_RESTRICTED THEN
        DBMS_OUTPUT.PUT_LINE('EVENT AGE RESTRICTED COLUMN NOT VALID');  
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END ;

PROCEDURE ADD_VENUE(
    PI_VENUE_NAME VENUE.venue_name%TYPE,
    PI_VENUE_ADDRESS VENUE.venue_address%TYPE,
    PI_VENUE_TOTAL_CAPACITY VENUE.venue_total_capacity%TYPE,
    PI_VENUE_EMAIL VENUE.venue_email%TYPE
)
AS
    E_INVALID_CAPACITY EXCEPTION;
    E_INVALID_EMAIL EXCEPTION;
    E_VENUE_ALREADY_EXISTS EXCEPTION;
        
BEGIN
    IF PI_VENUE_TOTAL_CAPACITY <= 0
    THEN
        RAISE E_INVALID_CAPACITY;
    END IF;

    -- Check if the email follows a basic format
    IF REGEXP_LIKE(PI_VENUE_EMAIL, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,4}$') = FALSE
    THEN
        RAISE E_INVALID_EMAIL;
    END IF;
    
    FOR existing_venue IN (
    SELECT 1
    FROM VENUE
    WHERE VENUE_NAME = PI_VENUE_NAME
      AND VENUE_EMAIL = PI_VENUE_EMAIL
    )
    LOOP
        RAISE E_VENUE_ALREADY_EXISTS;
    END LOOP;

    INSERT INTO VENUE(venue_id, venue_name, venue_address, venue_total_capacity, venue_email)
    VALUES (SEQ_VENUE.NEXTVAL, PI_VENUE_NAME, PI_VENUE_ADDRESS, PI_VENUE_TOTAL_CAPACITY, PI_VENUE_EMAIL);
    COMMIT;

EXCEPTION
    WHEN E_INVALID_CAPACITY THEN
        DBMS_OUTPUT.PUT_LINE('TOTAL CAPACITY SHOULD BE GREATER THAN ZERO');
    WHEN E_INVALID_EMAIL THEN
        DBMS_OUTPUT.PUT_LINE('INVALID EMAIL FORMAT');
    WHEN E_VENUE_ALREADY_EXISTS THEN
        DBMS_OUTPUT.PUT_LINE('VENUE ALREADY EXISTS');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

END pkg_app_admin;
/