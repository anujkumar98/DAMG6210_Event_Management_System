/* 
    Functions for getting querying data
    THIS SCRIPT SHOULD BE RUN BY EVENT_APP_ADMIN.
*/
------------------ALL Events with a start date between the given dates--------------------
DECLARE
    v_type_count NUMBER;
BEGIN
    -- Check if EventInfoType exists
    BEGIN
        SELECT COUNT(*)
        INTO v_type_count
        FROM ALL_TYPES
        WHERE TYPE_NAME = 'EVENTINFOTYPE';

        IF v_type_count = 0 THEN
            EXECUTE IMMEDIATE 'CREATE OR REPLACE TYPE EventInfoType AS OBJECT (
                EVENT_NAME VARCHAR2(100),
                EVENT_START_DATE TIMESTAMP,
                EVENT_END_DATE TIMESTAMP,
                EVENT_CATEGORY VARCHAR2(100),
                VENUE_NAME VARCHAR2(100)
            )';
            DBMS_OUTPUT.PUT_LINE('Event Info Type created');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Event Info Type already exists.');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END;

    -- Check if EventInfoTableType exists
    BEGIN
        SELECT COUNT(*)
        INTO v_type_count
        FROM ALL_TYPES
        WHERE TYPE_NAME = 'EVENTINFOTABLETYPE';

        IF v_type_count = 0 THEN
            EXECUTE IMMEDIATE 'CREATE OR REPLACE TYPE EventInfoTableType AS TABLE OF EventInfoType';
            DBMS_OUTPUT.PUT_LINE('Event Info Table Type already created.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Event Info Table Type already exists.');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END;
END;
/

CREATE OR REPLACE FUNCTION GetEventsInTimeRange(
    start_time IN TIMESTAMP,
    end_time IN TIMESTAMP
) RETURN EventInfoTableType PIPELINED
IS
BEGIN
    FOR event_rec IN (
        SELECT
            e.EVENT_NAME "EVENT NAME",
            e.EVENT_STARTTIME "EVENT START DATE",
            e.EVENT_ENDTIME "EVENT END DATE",
            et.event_type_category "EVENT CATEGORY",
            v.venue_name "VENUE NAME"
        FROM EVENTS e
        LEFT JOIN EVENT_TYPE et ON et.EVENT_TYPE_ID = e.EVENT_TYPE_ID
        LEFT JOIN VENUE v ON e.EVENT_VENUE_ID = v.Venue_ID
        WHERE e.EVENT_STARTTIME BETWEEN start_time AND end_time
        ORDER BY e.EVENT_STARTTIME
    ) 
    LOOP
        PIPE ROW(EventInfoType(
            event_rec."EVENT NAME",
            event_rec."EVENT START DATE",
            event_rec."EVENT END DATE",
            event_rec."EVENT CATEGORY",
            event_rec."VENUE NAME"
        ));
    END LOOP;

    RETURN;
END GetEventsInTimeRange;
/

/*
--Sample code to run
SELECT * FROM TABLE(GetEventsInTimeRange(
    TO_TIMESTAMP('2023-11-30 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
    TO_TIMESTAMP('2023-12-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
));
*/

------------------ALL Events with a particular event category--------------------


-- Procedure to create EventCategory types
DECLARE
    v_type_count NUMBER;
BEGIN
    -- Check if EventCategoryType exists
    BEGIN
        SELECT COUNT(*)
        INTO v_type_count
        FROM ALL_TYPES
        WHERE TYPE_NAME = 'EVENTCATEGORYTYPE';

        IF v_type_count = 0 THEN
            EXECUTE IMMEDIATE 'CREATE OR REPLACE TYPE EventCategoryType AS OBJECT (
                EVENT_NAME VARCHAR2(100),
                EVENT_CATEGORY VARCHAR2(100),
                EVENT_STATUS VARCHAR2(100)
            )';
            DBMS_OUTPUT.PUT_LINE('Event Category Type created.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Event Category Type already exists.');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END;

    -- Check if EventCategoryTableType exists
    BEGIN
        SELECT COUNT(*)
        INTO v_type_count
        FROM ALL_TYPES
        WHERE TYPE_NAME = 'EVENTCATEGORYTABLETYPE';

        IF v_type_count = 0 THEN
            EXECUTE IMMEDIATE 'CREATE OR REPLACE TYPE EventCategoryTableType AS TABLE OF EventCategoryType';
            DBMS_OUTPUT.PUT_LINE('Event Category Table Type CREATED');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Event Category Table Type already exists.');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END;
END CreateEventCategoryTypes;
/



CREATE OR REPLACE FUNCTION GetEventsInCategory(
    categoryname VARCHAR2
) RETURN EventCategoryTableType PIPELINED
IS
BEGIN
    FOR event_rec IN (
        SELECT
            e.EVENT_NAME "EVENT NAME",
            et.event_type_category "EVENT CATEGORY",
            CASE 
                WHEN e.EVENT_ENDTIME < SYSTIMESTAMP THEN 'Completed' 
                ELSE 'Upcoming' 
            END EVENT_STATUS
        FROM EVENTS e
        LEFT JOIN EVENT_TYPE et ON et.EVENT_TYPE_ID = e.EVENT_TYPE_ID
        WHERE et.event_type_category LIKE '%' || categoryname || '%'
    ) 
    LOOP
        PIPE ROW(EventCategoryType(
            event_rec."EVENT NAME",
            event_rec."EVENT CATEGORY",
            event_rec.EVENT_STATUS
        ));
    END LOOP;

    RETURN;
END GetEventsInCategory;
/

/*
-- Sample SELECT statement
SELECT * FROM TABLE(GetEventsInCategory('Hackathon'));
*/


------------------Attendee details given the event name--------------------
DECLARE
    v_type_count NUMBER;
BEGIN
    -- Check if EventCategoryType exists
    BEGIN
        SELECT COUNT(*)
        INTO v_type_count
        FROM ALL_TYPES
        WHERE TYPE_NAME = 'EVENTATTENDEETYPE';

        IF v_type_count = 0 THEN
            EXECUTE IMMEDIATE 'CREATE OR REPLACE TYPE EVENTATTENDEETYPE AS OBJECT (
                EVENT_NAME VARCHAR2(100),
                NO_OF_TICKETS NUMBER,
                FIRST_NAME VARCHAR2(45),
                LAST_NAME VARCHAR2(45),
                EMAIL VARCHAR2(45),
                AGE NUMBER,
                GENDER VARCHAR(15)
            )';
         DBMS_OUTPUT.PUT_LINE('EVENT ATTENDEE TYPE CREATED');
        ELSE
            DBMS_OUTPUT.PUT_LINE('EVENT ATTENDEE TYPE already exists.');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END;

    -- Check if EventCategoryTableType exists
    BEGIN
        SELECT COUNT(*)
        INTO v_type_count
        FROM ALL_TYPES
        WHERE TYPE_NAME = 'EVENTATTENDEETABLETYPE';

        IF v_type_count = 0 THEN
            EXECUTE IMMEDIATE 'CREATE OR REPLACE TYPE EVENTATTENDEETABLETYPE AS TABLE OF EVENTATTENDEETYPE';
            DBMS_OUTPUT.PUT_LINE('EVENT ATTENDEE TABLE TYPE CREATED');
        ELSE
            DBMS_OUTPUT.PUT_LINE('EVENT ATTENDEE TABLE TYPE already exists.');
        END IF; 
        
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END;
END CreateEventCategoryTypes;
/


CREATE OR REPLACE FUNCTION GetEventAttendees(
    eventname VARCHAR2
) RETURN EventAttendeeTableType PIPELINED
IS
BEGIN
    FOR attendee_rec IN (
        SELECT DISTINCT
            e.event_name "EVENT NAME",
            b.booking_ticket_count "NO OF TICKETS",
            a.attendee_firstname "FIRST NAME",
            a.attendee_lastname "LAST NAME",
            a.attendee_email "EMAIL",
            a.attendee_age "AGE",
            a.attendee_gender "GENDER"
        FROM BOOKING b
        LEFT JOIN TICKET t ON t.ticket_id = b.ticket_id
        LEFT JOIN EVENTS e ON e.event_id = t.event_id
        LEFT JOIN attendee a ON a.attendee_id = b.attendee_id
        WHERE e.event_name = eventname AND b.booking_status <> 'Cancel'
    )
    LOOP
        PIPE ROW(EventAttendeeType(
            attendee_rec."EVENT NAME",
            attendee_rec."NO OF TICKETS",
            attendee_rec."FIRST NAME",
            attendee_rec."LAST NAME",
            attendee_rec."EMAIL",
            attendee_rec."AGE",
            attendee_rec."GENDER"
        ));
    END LOOP;

    RETURN;
END GetEventAttendees;
/

/*
--Sample code to run
SELECT * FROM TABLE(GetEventAttendees('Networking Mixer'));
*/