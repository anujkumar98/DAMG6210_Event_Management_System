/* 
    Code  for inserting data into event manager package
    THIS SCRIPT SHOULD BE RUN BY EVENT_APP_ADMIN.
*/
set serveroutput on;
alter session set nls_timestamp_format = 'DD-MON-RR HH.MI';
CREATE OR REPLACE PACKAGE pkg_event_manager AS
        PROCEDURE ADD_EVENT(
    PI_EVENT_NAME EVENTS.event_name%type,
    PI_EVENT_DESCRIPTION EVENTS.event_description%type,
    PI_EVENT_STATUS EVENTS.event_description%type,
    PI_EVENT_STARTTIME EVENTS.event_starttime%type,
    PI_EVENT_ENDTIME EVENTS.event_endtime%type,
    PI_EVENT_TYPE_NAME EVENT_TYPE.event_type_category%type,
    PI_EVENT_VENUE_NAME VENUE.venue_name%type
);
PROCEDURE ADD_TICKET(
    PI_TICKET_CATEGORY_NAME TICKET.ticket_category_name%type,
    PI_TICKET_PRICE TICKET.ticket_price%type,
    PI_TICKET_SEATS TICKET.ticket_seats%type,
    PI_MAX_BOOKING_COUNT_PER_USER TICKET.ticket_max_booking_count_per_user%type,
    PI_EVENT_NAME EVENTS.event_name%type
);

PROCEDURE ADD_PROMOTION(
    PI_PROMOTION_CODE PROMOTIONS.promotion_code%type,
    PI_PROMOTION_STARTDATE PROMOTIONS.promotion_startdate%type,
    PI_PROMOTION_ENDDATE PROMOTIONS.promotion_enddate%type,
    PI_PROMOTION_DISCOUNT PROMOTIONS.promotion_discount%type,
    PI_PROMOTION_MAX_COUNT PROMOTIONS.promotion_max_count%type,
    PI_EVENT_NAME EVENTS.event_name%type
);
    
END pkg_event_manager;
/

CREATE OR REPLACE PACKAGE BODY pkg_event_manager AS

   PROCEDURE ADD_EVENT(
    PI_EVENT_NAME EVENTS.event_name%type,
    PI_EVENT_DESCRIPTION EVENTS.event_description%type,
    PI_EVENT_STATUS EVENTS.event_description%type,
    PI_EVENT_STARTTIME EVENTS.event_starttime%type,
    PI_EVENT_ENDTIME EVENTS.event_endtime%type,
    PI_EVENT_TYPE_NAME EVENT_TYPE.event_type_category%type,
    PI_EVENT_VENUE_NAME VENUE.venue_name%type
)
AS
    E_EVENT_TYPE_NOT_FOUND EXCEPTION;
    E_VENUE_NOT_FOUND EXCEPTION;
    E_INVALID_EVENT_TIME EXCEPTION;
    E_VENUE_NOT_AVAILABLE EXCEPTION;
    E_EVENT_ALREADY_EXISTS EXCEPTION;
    v_event_type_id EVENT_TYPE.event_type_id%TYPE;
    v_event_venue_id VENUE.venue_id%TYPE;
    v_venue_count NUMBER;
    v_event_count NUMBER;
        
BEGIN
    -- Get event type id based on event type name
    BEGIN
    SELECT event_type_id
    INTO v_event_type_id
    FROM event_type
    WHERE event_type_category = PI_EVENT_TYPE_NAME;
    EXCEPTION 
        WHEN NO_DATA_FOUND THEN
        RAISE E_EVENT_TYPE_NOT_FOUND;
    END;
    -- Check if event type exists
    IF v_event_type_id IS NULL THEN
        RAISE E_EVENT_TYPE_NOT_FOUND;
    END IF;
    
    -- Get venue id based on venue name
    BEGIN
    SELECT venue_id
    INTO v_event_venue_id
    FROM venue
    WHERE venue_name = PI_EVENT_VENUE_NAME;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
          RAISE E_VENUE_NOT_FOUND;
    END;
    -- Check if venue exists
    IF v_event_venue_id IS NULL THEN
        RAISE E_VENUE_NOT_FOUND;
    END IF;
    
    -- Check if PI_EVENT_STARTTIME is greater than PI_EVENT_ENDTIME
    IF PI_EVENT_STARTTIME > PI_EVENT_ENDTIME THEN
        RAISE E_INVALID_EVENT_TIME;
    END IF;
    
    IF PI_EVENT_STARTTIME < systimestamp OR PI_EVENT_ENDTIME<systimestamp THEN 
        RAISE E_INVALID_EVENT_TIME;
    END IF;
    
    -- Check if the event name already exists
    SELECT COUNT(*)
    INTO v_event_count
    FROM events
    WHERE event_name = PI_EVENT_NAME;

    IF v_event_count > 0 THEN
        RAISE E_EVENT_ALREADY_EXISTS;
    END IF;

    SELECT COUNT(*) 
    INTO v_venue_count
    FROM venue_availability
    WHERE VENUE_ID = v_event_venue_id
    AND (
        PI_EVENT_STARTTIME >= EVENT_ENDTIME
        OR PI_EVENT_ENDTIME <= EVENT_STARTTIME
    );
    IF v_venue_count = 0 THEN 
        RAISE E_VENUE_NOT_AVAILABLE;
    END IF;
    -- Insert into EVENTS table
    INSERT INTO EVENTS (
        event_id,
        event_name,
        event_description,
        event_status,
        event_starttime,
        event_endtime,
        event_type_id,
        event_venue_id
    ) VALUES (
        SEQ_EVENT.NEXTVAL,
        PI_EVENT_NAME,
        PI_EVENT_DESCRIPTION,
        PI_EVENT_STATUS,
        PI_EVENT_STARTTIME,
        PI_EVENT_ENDTIME,
        v_event_type_id,
        v_event_venue_id
    );
    COMMIT;

EXCEPTION
    WHEN E_EVENT_TYPE_NOT_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Event type not found.');
    WHEN E_INVALID_EVENT_TIME THEN
        DBMS_OUTPUT.PUT_LINE('Invalid event time');
    WHEN E_VENUE_NOT_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Venue not found.');
    WHEN E_VENUE_NOT_AVAILABLE THEN
        DBMS_OUTPUT.PUT_LINE('Venue not available during the specified time.');
    WHEN E_EVENT_ALREADY_EXISTS THEN
        DBMS_OUTPUT.PUT_LINE('Event with the same name already exists.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

PROCEDURE ADD_TICKET(
    PI_TICKET_CATEGORY_NAME TICKET.ticket_category_name%type,
    PI_TICKET_PRICE TICKET.ticket_price%type,
    PI_TICKET_SEATS TICKET.ticket_seats%type,
    PI_MAX_BOOKING_COUNT_PER_USER TICKET.ticket_max_booking_count_per_user%type,
    PI_EVENT_NAME EVENTS.event_name%type
)
AS
    E_INVALID_PRICE EXCEPTION;
    E_INVALID_SEATS EXCEPTION;
    E_INVALID_MAX_BOOKING_COUNT EXCEPTION;
    E_EVENT_NOT_FOUND EXCEPTION;
    E_INVALID_SEATS_CAPACITY EXCEPTION;
    E_CATEGORY_ALREADY_EXISTS EXCEPTION;
    v_event_id EVENTS.event_id%TYPE;
    v_remaining_seats NUMBER;
    v_category_count NUMBER;
        
    BEGIN
   -- Validate ticket price
    IF PI_TICKET_PRICE <= 0 THEN
        RAISE E_INVALID_PRICE;
    END IF;

    -- Validate ticket seats
    IF PI_TICKET_SEATS <= 0 THEN
        RAISE E_INVALID_SEATS;
    END IF;

    -- Validate max booking count per user
    IF PI_MAX_BOOKING_COUNT_PER_USER <= 0 THEN
        RAISE E_INVALID_MAX_BOOKING_COUNT;
    END IF;

    -- Get event id based on event name
    BEGIN
    SELECT event_id
    INTO v_event_id
    FROM EVENTS
    WHERE event_name = PI_EVENT_NAME;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('');
    END;
    -- Check if the event exists
    IF v_event_id IS NULL THEN
        RAISE E_EVENT_NOT_FOUND;
    END IF;
    
    -- Check if the category already exists for the same event
    SELECT COUNT(*)
    INTO v_category_count
    FROM TICKET
    WHERE event_id = v_event_id
      AND ticket_category_name = PI_TICKET_CATEGORY_NAME;

    IF v_category_count > 0 THEN
        RAISE E_CATEGORY_ALREADY_EXISTS;
    END IF;
    
    SELECT remaining_capacity INTO v_remaining_seats
    FROM EventSeatAvailability WHERE event_id=v_event_id;
    
    IF v_remaining_seats < 0 OR v_remaining_seats < PI_TICKET_SEATS THEN
        RAISE E_INVALID_SEATS_CAPACITY;
    END IF;

    -- Insert into TICKET table
    INSERT INTO TICKET (
        ticket_id,
        ticket_category_name,
        ticket_price,
        ticket_seats,
        ticket_max_booking_count_per_user,
        event_id
    ) VALUES (
        SEQ_TICKET.NEXTVAL,
        PI_TICKET_CATEGORY_NAME,
        PI_TICKET_PRICE,
        PI_TICKET_SEATS,
        PI_MAX_BOOKING_COUNT_PER_USER,
        v_event_id
    );
    COMMIT;

EXCEPTION
    WHEN E_INVALID_PRICE THEN
        DBMS_OUTPUT.PUT_LINE('Invalid ticket price. Price should be greater than 0.');
    WHEN E_INVALID_SEATS THEN
        DBMS_OUTPUT.PUT_LINE('Invalid number of seats. Seats should be greater than 0.');
    WHEN E_INVALID_MAX_BOOKING_COUNT THEN
        DBMS_OUTPUT.PUT_LINE('Invalid max booking count per user. Count should be greater than 0.');
    WHEN E_INVALID_SEATS_CAPACITY THEN
        DBMS_OUTPUT.PUT_LINE('Seat assigned cannot be more than the venue capacity');
    WHEN E_EVENT_NOT_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Event not found.');
    WHEN E_CATEGORY_ALREADY_EXISTS THEN
        DBMS_OUTPUT.PUT_LINE('Ticket category already exists for the given event.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

PROCEDURE ADD_PROMOTION(
    PI_PROMOTION_CODE PROMOTIONS.promotion_code%type,
    PI_PROMOTION_STARTDATE PROMOTIONS.promotion_startdate%type,
    PI_PROMOTION_ENDDATE PROMOTIONS.promotion_enddate%type,
    PI_PROMOTION_DISCOUNT PROMOTIONS.promotion_discount%type,
    PI_PROMOTION_MAX_COUNT PROMOTIONS.promotion_max_count%type,
    PI_EVENT_NAME EVENTS.event_name%type
)
AS
    E_EVENT_NOT_FOUND EXCEPTION;
    E_INVALID_PROMOTION_TIME EXCEPTION;
    E_INVALID_DISCOUNT EXCEPTION;
    E_DUPLICATE_PROMOTION_CODE EXCEPTION;
    E_INVALID_CODE_COUNT EXCEPTION;
    V_EVENT_ID EVENTS.event_id%TYPE;
    v_promotion_code_count NUMBER;
        
BEGIN
    -- Get event type id based on event type name
      BEGIN
    SELECT event_id
    INTO V_EVENT_ID
    FROM EVENTS
    WHERE event_name = PI_EVENT_NAME;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        RAISE E_EVENT_NOT_FOUND;
    END;
    -- Check if the event exists
    IF V_EVENT_ID IS NULL THEN
        RAISE E_EVENT_NOT_FOUND;
    END IF;
    
    -- Check if the promotion code already exists for the given event
    SELECT COUNT(*)
    INTO v_promotion_code_count
    FROM PROMOTIONS
    WHERE event_id = V_EVENT_ID
      AND promotion_code = PI_PROMOTION_CODE;

    IF v_promotion_code_count > 0 THEN
        RAISE E_DUPLICATE_PROMOTION_CODE;
    END IF;
    
    -- check if discount < 0 
    IF PI_PROMOTION_DISCOUNT < 0 THEN
        RAISE E_INVALID_DISCOUNT;
    END IF;
    
    -- check if count < 0 
    IF PI_PROMOTION_DISCOUNT < 0 THEN
        RAISE E_INVALID_CODE_COUNT;
    END IF;
    
    --Check if start date < end date
    IF PI_PROMOTION_STARTDATE > PI_PROMOTION_ENDDATE THEN
        RAISE E_INVALID_PROMOTION_TIME;
    END IF;

    -- Insert into PROMOTIONS table
    INSERT INTO PROMOTIONS (
        promotion_id,
        promotion_code,
        promotion_startdate,
        promotion_enddate,
        promotion_discount,
        promotion_max_count,
        event_id
    ) VALUES (
        SEQ_PROMOTIONS.NEXTVAL,
        PI_PROMOTION_CODE,
        PI_PROMOTION_STARTDATE,
        PI_PROMOTION_ENDDATE,
        cast (PI_PROMOTION_DISCOUNT as number(5,2)),
        PI_PROMOTION_MAX_COUNT,
        V_EVENT_ID
    );
    COMMIT;

EXCEPTION
    WHEN E_EVENT_NOT_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Event not found.');
    WHEN E_INVALID_DISCOUNT THEN
        DBMS_OUTPUT.PUT_LINE('Discount cannot be less than 0');
    WHEN E_DUPLICATE_PROMOTION_CODE THEN
        DBMS_OUTPUT.PUT_LINE('Promotion code already exists for the given event.');
    WHEN E_INVALID_CODE_COUNT THEN
        DBMS_OUTPUT.PUT_LINE('Promotion code cannot be less than 0');    
     WHEN E_INVALID_PROMOTION_TIME THEN
        DBMS_OUTPUT.PUT_LINE('Invalid promotion time: Start time must be before end time.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

END pkg_event_manager;
/