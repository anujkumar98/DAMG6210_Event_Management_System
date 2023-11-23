-- Procedure to add attendee
CREATE OR REPLACE PROCEDURE ADD_ATTENDEE(
    PI_ATTENDEE_USERNAME  attendee.attendee_username%TYPE,
    PI_ATTENDEE_FIRSTNAME attendee.attendee_firstname%TYPE,
    PI_ATTENDEE_LASTNAME  attendee.attendee_lastname%TYPE,
    PI_ATTENDEE_EMAIL     attendee.attendee_email%TYPE,
    PI_ATTENDEE_MOBILE_NO  attendee.attendee_mobile_no%TYPE,
    PI_ATTENDEE_AGE       attendee.attendee_age%TYPE,
    PI_ATTENDEE_GENDER    attendee.attendee_gender%TYPE
)
AS
    E_INVALID_MOBILE EXCEPTION;
    E_INVALID_AGE EXCEPTION;
    E_INVALID_EMAIL EXCEPTION;
    E_INVALID_GENDER EXCEPTION;
    E_USERNAME_EXISTS EXCEPTION;
    v_username_count NUMBER;
BEGIN
    -- Check if the username already exists
    SELECT COUNT(*)
    INTO v_username_count
    FROM attendee
    WHERE attendee_username = PI_ATTENDEE_USERNAME;

    IF v_username_count > 0
    THEN
        RAISE E_USERNAME_EXISTS;
    END IF;
    
    -- Validity checks
    IF PI_ATTENDEE_MOBILE_NO IS NULL OR LENGTH(PI_ATTENDEE_MOBILE_NO) <> 10 OR NOT REGEXP_LIKE(PI_ATTENDEE_MOBILE_NO, '^[0-9]+$')
    THEN
        RAISE E_INVALID_MOBILE;
    END IF;

    IF PI_ATTENDEE_AGE < 0
    THEN
        RAISE E_INVALID_AGE;
    END IF;

    IF PI_ATTENDEE_GENDER NOT IN ('Male', 'Female', 'Other')
    THEN
        RAISE E_INVALID_GENDER;
    END IF;

    -- Basic email format validation
    IF PI_ATTENDEE_EMAIL IS NOT NULL AND NOT REGEXP_LIKE(PI_ATTENDEE_EMAIL, '^[A-Za-z0-9._-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,4}$')
    THEN
        RAISE E_INVALID_EMAIL;
    END IF;

    -- Insert into the attendee table
    INSERT INTO attendee (
        attendee_id,
        attendee_username,
        attendee_firstname,
        attendee_lastname,
        attendee_email,
        attendee_mobile_no,
        attendee_age,
        attendee_gender
    ) VALUES (
        SEQ_ATTENDEE.NEXTVAL,
        PI_ATTENDEE_USERNAME,
        PI_ATTENDEE_FIRSTNAME,
        PI_ATTENDEE_LASTNAME,
        PI_ATTENDEE_EMAIL,
        PI_ATTENDEE_MOBILE_NO,
        PI_ATTENDEE_AGE,
        PI_ATTENDEE_GENDER
    );
    COMMIT;

EXCEPTION
    WHEN E_USERNAME_EXISTS THEN
        DBMS_OUTPUT.PUT_LINE('PLEASE ENTER DIFFERENT USERNAME. USERNAME ALREADY IN USE');
    WHEN E_INVALID_MOBILE THEN
        DBMS_OUTPUT.PUT_LINE('PLEASE ENTER A VALID MOBILE NUMBER FOR THE ATTENDEE');
    WHEN E_INVALID_AGE THEN
        DBMS_OUTPUT.PUT_LINE('ATTENDEE AGE MUST BE GREATER THAN 0');
    WHEN E_INVALID_GENDER THEN
        DBMS_OUTPUT.PUT_LINE('INVALID GENDER');
    WHEN E_INVALID_EMAIL THEN
        DBMS_OUTPUT.PUT_LINE('INVALID EMAIL FORMAT');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END ADD_ATTENDEE;
/



-------------------------------------------EVENTTYPE------------------------------
CREATE OR REPLACE PROCEDURE ADD_EVENT_TYPE(
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
END ADD_EVENT_TYPE;
/

-------------------------------------------VENUE------------------------------

CREATE OR REPLACE PROCEDURE ADD_VENUE(
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
END ADD_VENUE;
/

----------------------------------EVENTS---------------------------------------




CREATE OR REPLACE PROCEDURE ADD_EVENT(
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
    SELECT event_type_id
    INTO v_event_type_id
    FROM event_type
    WHERE event_type_category = PI_EVENT_TYPE_NAME;
    
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
        DBMS_OUTPUT.PUT_LINE('');
    END;
    -- Check if venue exists
    IF v_event_venue_id IS NULL THEN
        RAISE E_VENUE_NOT_FOUND;
    END IF;
    
    -- Check if PI_EVENT_STARTTIME is greater than PI_EVENT_ENDTIME
    IF PI_EVENT_STARTTIME > PI_EVENT_ENDTIME THEN
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

    SELECT COUNT(*) INTO v_venue_count
    FROM venue_availability
    WHERE VENUE_ID = v_event_venue_id
    AND (
        TO_TIMESTAMP(PI_EVENT_STARTTIME, 'YYYY-MM-DD HH24:MI') >= EVENT_ENDTIME
        OR TO_TIMESTAMP(PI_EVENT_ENDTIME, 'YYYY-MM-DD HH24:MI') <= EVENT_STARTTIME
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
        DBMS_OUTPUT.PUT_LINE('Invalid event time: Start time must be before end time.');
    WHEN E_VENUE_NOT_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Venue not found.');
    WHEN E_VENUE_NOT_AVAILABLE THEN
        DBMS_OUTPUT.PUT_LINE('Venue not available during the specified time.');
    WHEN E_EVENT_ALREADY_EXISTS THEN
        DBMS_OUTPUT.PUT_LINE('Event with the same name already exists.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END ADD_EVENT;
/


----------------Tickets -----------------------

CREATE OR REPLACE PROCEDURE ADD_TICKET(
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
END ADD_TICKET;
/


---------------------PROMOTIONS-------

CREATE OR REPLACE PROCEDURE ADD_PROMOTION(
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
    -- Get event id based on event name
    BEGIN
    SELECT event_id
    INTO V_EVENT_ID
    FROM EVENTS
    WHERE event_name = PI_EVENT_NAME;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('');
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
END ADD_PROMOTION;
/



--------BOOKING------

CREATE OR REPLACE PROCEDURE ADD_BOOKING(
    PI_BOOKING_TICKET_COUNT BOOKING.booking_ticket_count%type,
    PI_ATTENDEE_USERNAME attendee.attendee_username%TYPE,
    PI_PROMOTION_CODE PROMOTIONS.promotion_code%type,
    PI_TICKET_CATEGORY_NAME TICKET.ticket_category_name%type,
    PI_EVENT_NAME EVENTS.event_name%type
)
AS
    E_INVALID_TICKET_COUNT EXCEPTION;
    E_INVALID_AMOUNT EXCEPTION;
    E_ATTENDEE_NOT_FOUND EXCEPTION;
    E_PROMOTION_NOT_FOUND EXCEPTION;
    E_TICKET_NOT_FOUND EXCEPTION;
    E_INVALID_EVENT_NAME EXCEPTION;
    E_EVENT_NOT_FOUND EXCEPTION;
    E_TICKET_COUNT_INVALID EXCEPTION;
    V_ATTENDEE_ID ATTENDEE.attendee_id%TYPE;
    V_PROMOTION_ID PROMOTIONS.promotion_id%TYPE;
    V_TICKET_ID TICKET.ticket_id%TYPE;
    v_ticket_category_count NUMBER;
    V_EVENT_ID NUMBER;
    v_booking_amout BOOKING.booking_amount%type;
    v_discount_code PROMOTIONS.promotion_discount%type;
    v_ticket_max_booking_count_per_user TICKET.ticket_max_booking_count_per_user%type;
    v_promotion_enddate PROMOTIONS.promotion_enddate%type;
    v_promition_no_used NUMBER;
    v_promotion_max_count PROMOTIONS.promotion_max_count%type;
    
    BEGIN

    -- Get attendee id based on mobile number
    BEGIN 
    SELECT attendee_id
    INTO V_ATTENDEE_ID
    FROM ATTENDEE
    WHERE attendee_username = PI_ATTENDEE_USERNAME;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('');
    END;
    -- Check if the attendee exists
    IF V_ATTENDEE_ID IS NULL THEN
        RAISE E_ATTENDEE_NOT_FOUND;
    END IF;
    BEGIN
    SELECT event_id
    INTO V_EVENT_ID
    FROM EVENTS
    WHERE event_name = PI_EVENT_NAME;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('');
    END;
    -- Check if the event exists
    IF V_EVENT_ID IS NULL THEN
        RAISE E_EVENT_NOT_FOUND;
    END IF;
    
    -- Get ticket id based on ticket category name
    BEGIN
    SELECT ticket_id,ticket_max_booking_count_per_user
    INTO V_TICKET_ID,v_ticket_max_booking_count_per_user
    FROM TICKET
    WHERE ticket_category_name = PI_TICKET_CATEGORY_NAME and event_id=V_EVENT_ID;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('');
    END;
    -- Check if the ticket exists
    IF V_TICKET_ID IS NULL THEN
        RAISE E_TICKET_NOT_FOUND;
    END IF;

    
    
    IF PI_PROMOTION_CODE IS NULL THEN
        v_discount_code:=0;
        V_PROMOTION_ID:=-1;
        v_promotion_enddate:=TO_DATE('2099-02-28', 'YYYY-MM-DD');
    ELSE 
    -- Get promotion id based on promotion code
    SELECT promotion_id,promotion_discount,promotion_enddate
    INTO V_PROMOTION_ID, v_discount_code,v_promotion_enddate
    FROM PROMOTIONS
    WHERE promotion_code = PI_PROMOTION_CODE AND event_id=V_EVENT_ID;
    SELECT COUNT(booking_id),nvl(promotion_max_count,0)
    INTO v_promition_no_used ,v_promotion_max_count
    FROM PROMOTIONS P 
    FULL JOIN BOOKING B ON B.PROMOTION_ID= P.PROMOTION_ID
    WHERE P.PROMOTION_ID = V_PROMOTION_ID
    GROUP BY promotion_max_count;
    
    END IF;
    -- Check if the promotion exists
    IF v_promotion_max_count < v_promition_no_used AND v_promotion_max_count IS NOT NULL THEN 
        RAISE E_PROMOTION_NOT_FOUND;
    END IF;
    IF V_PROMOTION_ID IS NULL THEN
        RAISE E_PROMOTION_NOT_FOUND;
    END IF;
    
    IF v_promotion_enddate < SYSTIMESTAMP THEN
        RAISE E_PROMOTION_NOT_FOUND;
    END IF;
    
    -- Validate booking ticket count
    IF PI_BOOKING_TICKET_COUNT <= 0 OR v_ticket_max_booking_count_per_user < PI_BOOKING_TICKET_COUNT THEN
        RAISE E_INVALID_TICKET_COUNT;
    END IF;
    

    SELECT remaining_seats into v_ticket_category_count
    FROM TicketCategoryAvailability 
    WHERE event_id = V_EVENT_ID AND ticket_id = V_TICKET_ID;
    
    IF v_ticket_category_count < 0 OR PI_BOOKING_TICKET_COUNT > v_ticket_category_count THEN
    RAISE E_TICKET_COUNT_INVALID;
    END IF;
    
    SELECT (ticket_price* PI_BOOKING_TICKET_COUNT) - (ticket_price * PI_BOOKING_TICKET_COUNT * (v_discount_code / 100)) into v_booking_amout
    FROM TicketCategoryAvailability WHERE event_id = V_EVENT_ID AND ticket_id = V_TICKET_ID;
    
    
    -- Insert into BOOKING table
    INSERT INTO BOOKING (
        booking_id,
        booking_ticket_count,
        booking_status,
        booking_amount,
        booking_date,
        attendee_id,
        promotion_id,
        ticket_id
    ) VALUES (
        SEQ_BOOKING.NEXTVAL,
        PI_BOOKING_TICKET_COUNT,
        'Confirmed',
        v_booking_amout,
        systimestamp,
        V_ATTENDEE_ID,
        V_PROMOTION_ID,
        V_TICKET_ID
    );
    COMMIT;

EXCEPTION
    WHEN E_INVALID_TICKET_COUNT THEN
        DBMS_OUTPUT.PUT_LINE('Invalid booking ticket count. Count should be greater than 0.');
    WHEN E_INVALID_AMOUNT THEN
        DBMS_OUTPUT.PUT_LINE('Invalid booking amount. Amount should be 0 or greater.');
    WHEN E_ATTENDEE_NOT_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Attendee not found.');
    WHEN E_PROMOTION_NOT_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Promotion not found or invalid');
    WHEN E_TICKET_NOT_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Ticket not found.');
    WHEN E_EVENT_NOT_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Event not found.');
    WHEN E_TICKET_COUNT_INVALID THEN
        DBMS_OUTPUT.PUT_LINE('Ticket capacity limit exceded');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END ADD_BOOKING;
/

------------------ REVIEWS ---------------

CREATE OR REPLACE PROCEDURE ADD_REVIEW(
    PI_REVIEW_DESCRIPTION REVIEWS.review_description%type,
    PI_EVENT_NAME EVENTS.event_name%type,
    PI_ATTENDEE_USERNAME attendee.attendee_username%TYPE
)
AS
    E_EVENT_NOT_FOUND EXCEPTION;
    E_ATTENDEE_NOT_FOUND EXCEPTION;
    E_EVENT_NOT_COMPLETED EXCEPTION;
    v_attendee_ID ATTENDEE.attendee_id%TYPE;
    V_EVENT_ID EVENTS.event_id%TYPE;
    V_EVENT_ENDTIME TIMESTAMP;
BEGIN
    -- Get event id and end time based on event name
    BEGIN
        SELECT event_id, event_endtime
        INTO V_EVENT_ID, V_EVENT_ENDTIME
        FROM EVENTS
        WHERE event_name = PI_EVENT_NAME;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('');
    END;
    -- Check if the event exists
    IF V_EVENT_ID IS NULL THEN
        RAISE E_EVENT_NOT_FOUND;
    END IF;

    -- Check if the event is completed
    IF V_EVENT_ENDTIME > SYSTIMESTAMP THEN
        RAISE E_EVENT_NOT_COMPLETED;
    END IF;

    -- Check if the attendee exists (if provided)
    IF PI_ATTENDEE_USERNAME IS NOT NULL THEN
        SELECT 1
        INTO v_attendee_ID
        FROM ATTENDEE
        WHERE attendee_username = PI_ATTENDEE_USERNAME;

        IF v_attendee_ID IS NULL THEN
            RAISE E_ATTENDEE_NOT_FOUND;
        END IF;
    END IF;

    -- Insert into REVIEWS table
    INSERT INTO REVIEWS (
        review_id,
        review_description,
        event_id,
        attendee_id
    ) VALUES (
        SEQ_REVIEWS.NEXTVAL,
        PI_REVIEW_DESCRIPTION,
        V_EVENT_ID,
        v_attendee_ID
    );
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Review created');
EXCEPTION
    WHEN E_EVENT_NOT_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Event not found.');
    WHEN E_ATTENDEE_NOT_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Attendee not found.');
    WHEN E_EVENT_NOT_COMPLETED THEN
        DBMS_OUTPUT.PUT_LINE('Reviews can only be given after the event.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END ADD_REVIEW;
/


------------------------TICKET CANCEL---------------------

CREATE OR REPLACE PROCEDURE CANCEL_BOOKING(
    PI_BOOKING_ID BOOKING.booking_id%TYPE
)
AS
    E_BOOKING_NOT_FOUND EXCEPTION;
    E_EVENT_ALREADY_STARTED EXCEPTION;
    E_TICKET_CANCELD EXCEPTION;
    v_event_starttime EVENTS.event_starttime%TYPE;
    v_event_cancel VARCHAR(1) := 'N';
    v_booking_status BOOKING.booking_status%type;
BEGIN
    SELECT 'Y' INTO v_event_cancel 
    FROM BOOKING WHERE booking_id=PI_BOOKING_ID;
    IF v_event_cancel = 'N' THEN
        RAISE E_BOOKING_NOT_FOUND;
    END IF;
    SELECT booking_status INTO v_booking_status FROM BOOKING 
    WHERE booking_id = PI_BOOKING_ID;
    IF v_booking_status = 'Cancel' THEN
        RAISE E_TICKET_CANCELD;
    END IF;
    -- Check if booking exists
    SELECT e.event_starttime
    INTO v_event_starttime
    FROM BOOKING b
    LEFT JOIN TICKET t ON b.ticket_id = t.ticket_id
    LEFT JOIN EVENTS e ON t.event_id = e.event_id
    WHERE b.booking_id = PI_BOOKING_ID ;

    IF v_event_starttime <= SYSTIMESTAMP THEN
        RAISE E_EVENT_ALREADY_STARTED;
    END IF;

    -- Update booking status to 'Cancel'
    UPDATE BOOKING
    SET booking_status = 'Cancel'
    WHERE booking_id = PI_BOOKING_ID;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Booking canceled');
EXCEPTION
    WHEN E_BOOKING_NOT_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Booking does not exists');
    WHEN E_TICKET_CANCELD THEN
        DBMS_OUTPUT.PUT_LINE('Booking is already cancled');
    WHEN E_EVENT_ALREADY_STARTED THEN
        DBMS_OUTPUT.PUT_LINE('Cannot cancel booking after the event has started.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END CANCEL_BOOKING;
/


