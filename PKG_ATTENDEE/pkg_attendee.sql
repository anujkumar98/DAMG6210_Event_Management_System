/* 
    Code  for inserting data into attendee package
    THIS SCRIPT SHOULD BE RUN BY EVENT_APP_ADMIN.
*/
set serveroutput on;
CREATE OR REPLACE PACKAGE pkg_attendee AS
    PROCEDURE ADD_ATTENDEE(
    PI_ATTENDEE_USERNAME  attendee.attendee_username%TYPE,
    PI_ATTENDEE_FIRSTNAME attendee.attendee_firstname%TYPE,
    PI_ATTENDEE_LASTNAME  attendee.attendee_lastname%TYPE,
    PI_ATTENDEE_EMAIL     attendee.attendee_email%TYPE,
    PI_ATTENDEE_MOBILE_NO  attendee.attendee_mobile_no%TYPE,
    PI_ATTENDEE_AGE       attendee.attendee_age%TYPE,
    PI_ATTENDEE_GENDER    attendee.attendee_gender%TYPE
);
PROCEDURE ADD_BOOKING(
    PI_BOOKING_TICKET_COUNT BOOKING.booking_ticket_count%type,
    PI_ATTENDEE_USERNAME attendee.attendee_username%TYPE,
    PI_PROMOTION_CODE PROMOTIONS.promotion_code%type,
    PI_TICKET_CATEGORY_NAME TICKET.ticket_category_name%type,
    PI_EVENT_NAME EVENTS.event_name%type
);

PROCEDURE ADD_REVIEW(
    PI_REVIEW_DESCRIPTION REVIEWS.review_description%type,
    PI_EVENT_NAME EVENTS.event_name%type,
    PI_ATTENDEE_USERNAME attendee.attendee_username%TYPE
);
    
PROCEDURE UPDATE_ATTENDEE(
    PI_ATTENDEE_USERNAME attendee.attendee_username%TYPE,
    PI_ATTENDEE_EMAIL attendee.attendee_email%TYPE,
    PI_ATTENDEE_MOBILE_NO attendee.attendee_mobile_no%TYPE
);
PROCEDURE CANCEL_BOOKING(
    PI_BOOKING_ID BOOKING.booking_id%TYPE
);
PROCEDURE DELETE_ATTENDEE(
    PI_ATTENDEE_USERNAME attendee.attendee_username%TYPE
);
END pkg_attendee;
/

CREATE OR REPLACE PACKAGE BODY pkg_attendee AS

    PROCEDURE ADD_ATTENDEE(
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
    DBMS_OUTPUT.PUT_LINE('Attendee Created');
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
END;
PROCEDURE ADD_BOOKING(
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
    E_AGE_RESTRICTED EXCEPTION;
    V_ATTENDEE_ID ATTENDEE.attendee_id%TYPE;
    V_PROMOTION_ID PROMOTIONS.promotion_id%TYPE;
    V_TICKET_ID TICKET.ticket_id%TYPE;
    v_ticket_category_count NUMBER;
    V_EVENT_ID NUMBER;
    v_booking_amout BOOKING.booking_amount%type;
    v_discount_code PROMOTIONS.promotion_discount%type;
    v_ticket_max_booking_count_per_user TICKET.ticket_max_booking_count_per_user%type;
    v_promotion_enddate PROMOTIONS.promotion_enddate%type;
    v_promotion_startdate PROMOTIONS.promotion_startdate%type;
    v_promition_no_used NUMBER;
    v_promotion_max_count PROMOTIONS.promotion_max_count%type;
    v_current_ticket_count NUMBER;
    v_event_min_age NUMBER;
    v_attendee_age NUMBER;
    BEGIN
   -- Validate ticket price
    BEGIN 
    SELECT attendee_id,attendee_age
    INTO V_ATTENDEE_ID,v_attendee_age
    FROM ATTENDEE
    WHERE attendee_username = PI_ATTENDEE_USERNAME;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE E_ATTENDEE_NOT_FOUND;
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
        RAISE E_EVENT_NOT_FOUND;
    END;
    -- Check if the event exists
    IF V_EVENT_ID IS NULL THEN
        RAISE E_EVENT_NOT_FOUND;
    END IF;
    
    SELECT event_type_age_restiricted into v_event_min_age FROM EVENTS e 
    LEFT JOIN EVENT_TYPE et on et.event_type_id = e.event_type_id
    WHERE e.event_id=V_EVENT_ID;
    IF v_event_min_age > v_attendee_age THEN 
    RAISE E_AGE_RESTRICTED;
    END IF;
    -- Get ticket id based on ticket category name
    BEGIN
    SELECT ticket_id,ticket_max_booking_count_per_user
    INTO V_TICKET_ID,v_ticket_max_booking_count_per_user
    FROM TICKET
    WHERE ticket_category_name = PI_TICKET_CATEGORY_NAME and event_id=V_EVENT_ID;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
           RAISE E_TICKET_NOT_FOUND;
    END;
    -- Check if the ticket exists
    IF V_TICKET_ID IS NULL THEN
        RAISE E_TICKET_NOT_FOUND;
    END IF;

    
    
    IF PI_PROMOTION_CODE IS NULL THEN
        v_discount_code:=0;
        V_PROMOTION_ID:=-1;
        v_promotion_enddate:=TO_DATE('2099-02-28', 'YYYY-MM-DD');
        v_promotion_enddate:=TO_DATE('2000-02-28', 'YYYY-MM-DD');
    ELSE 
    -- Get promotion id based on promotion code
    BEGIN
    SELECT promotion_id,promotion_discount,PROMOTION_STARTDATE,promotion_enddate
    INTO V_PROMOTION_ID, v_discount_code,v_promotion_startdate,v_promotion_enddate
    FROM PROMOTIONS
    WHERE promotion_code = PI_PROMOTION_CODE AND event_id=V_EVENT_ID;
    EXCEPTION 
    WHEN NO_DATA_FOUND THEN
           RAISE E_PROMOTION_NOT_FOUND;
    END;
    SELECT COUNT(booking_id),nvl(promotion_max_count,0)
    INTO v_promition_no_used ,v_promotion_max_count
    FROM PROMOTIONS P 
    FULL JOIN BOOKING B ON B.PROMOTION_ID= P.PROMOTION_ID
    WHERE P.PROMOTION_ID = V_PROMOTION_ID
    GROUP BY promotion_max_count;
    
    END IF;
    
    -- Check if the promotion exists
    IF v_promotion_max_count-1 < v_promition_no_used AND v_promotion_max_count IS NOT NULL THEN 
        RAISE E_PROMOTION_NOT_FOUND;
    END IF;
    IF V_PROMOTION_ID IS NULL THEN
        RAISE E_PROMOTION_NOT_FOUND;
    END IF;
    
    IF v_promotion_enddate < SYSTIMESTAMP OR  v_promotion_startdate > SYSTIMESTAMP THEN
        RAISE E_PROMOTION_NOT_FOUND;
    END IF;
    
    SELECT SUM(BOOKING_TICKET_COUNT) into v_current_ticket_count FROM BOOKING 
    WHERE attendee_id = V_ATTENDEE_ID AND ticket_id = V_TICKET_ID AND Booking_status <> 'Cancel';
    -- Validate booking ticket count
    IF PI_BOOKING_TICKET_COUNT <= 0 OR v_ticket_max_booking_count_per_user < PI_BOOKING_TICKET_COUNT OR v_current_ticket_count+PI_BOOKING_TICKET_COUNT > v_ticket_max_booking_count_per_user THEN
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
    DBMS_OUTPUT.PUT_LINE('Booking completed');
EXCEPTION
    WHEN E_INVALID_TICKET_COUNT THEN
        DBMS_OUTPUT.PUT_LINE('Invalid booking ticket count.');
    WHEN E_AGE_RESTRICTED THEN
        DBMS_OUTPUT.PUT_LINE('Event is age restricted');
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
END ;
PROCEDURE ADD_REVIEW(
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
   -- Validate ticket price
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
        SELECT attendee_id
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
END  ;

PROCEDURE UPDATE_ATTENDEE(
    PI_ATTENDEE_USERNAME attendee.attendee_username%TYPE,
    PI_ATTENDEE_EMAIL attendee.attendee_email%TYPE,
    PI_ATTENDEE_MOBILE_NO attendee.attendee_mobile_no%TYPE
) AS
    E_INVALID_MOBILE EXCEPTION;
    E_INVALID_EMAIL EXCEPTION;
    E_USERNAME_DOES_NOT_EXISTS EXCEPTION;
    E_NO_UPDATE EXCEPTION;
    v_username_count NUMBER;
    v_attendee_email attendee.attendee_email%TYPE;
    v_attendee_mobile_no attendee.attendee_mobile_no%TYPE;
    BEGIN
    -- Check if the username exists
    SELECT COUNT(*)
    INTO v_username_count
    FROM attendee
    WHERE attendee_username = PI_ATTENDEE_USERNAME;
    IF v_username_count = 0
    THEN
        RAISE E_USERNAME_DOES_NOT_EXISTS;
    END IF;
    -- Validity checks
    IF PI_ATTENDEE_MOBILE_NO IS NULL OR LENGTH(PI_ATTENDEE_MOBILE_NO) <> 10 OR NOT REGEXP_LIKE(PI_ATTENDEE_MOBILE_NO, '^[0-9]+$')
    THEN
        RAISE E_INVALID_MOBILE;
    END IF;
    IF PI_ATTENDEE_EMAIL IS NOT NULL AND NOT REGEXP_LIKE(PI_ATTENDEE_EMAIL, '^[A-Za-z0-9._-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,4}$')
    THEN
        RAISE E_INVALID_EMAIL;
    END IF;
    SELECT attendee_email,attendee_mobile_no 
    INTO v_attendee_email,v_attendee_mobile_no
    FROM attendee
    WHERE attendee_username = PI_ATTENDEE_USERNAME;
   
    IF PI_ATTENDEE_EMAIL = v_attendee_email AND PI_ATTENDEE_MOBILE_NO = v_attendee_mobile_no
    THEN 
        RAISE E_NO_UPDATE;
    END IF;
    
    UPDATE attendee
    SET attendee_email = PI_ATTENDEE_EMAIL,
    attendee_mobile_no = PI_ATTENDEE_MOBILE_NO
    WHERE attendee_username = PI_ATTENDEE_USERNAME;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('User updated');
    EXCEPTION  
    WHEN E_USERNAME_DOES_NOT_EXISTS THEN
        DBMS_OUTPUT.PUT_LINE('User does not exists.');
    WHEN E_INVALID_MOBILE THEN
        DBMS_OUTPUT.PUT_LINE('PLEASE ENTER A VALID MOBILE NUMBER FOR THE ATTENDEE');
    WHEN E_INVALID_EMAIL THEN
        DBMS_OUTPUT.PUT_LINE('INVALID EMAIL FORMAT');
    WHEN E_NO_UPDATE THEN
        DBMS_OUTPUT.PUT_LINE('User updated');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('DBMS Error : '||SQLERRM);
    END;
    
PROCEDURE CANCEL_BOOKING(
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
    BEGIN
    SELECT 'Y' INTO v_event_cancel 
    FROM BOOKING WHERE booking_id=PI_BOOKING_ID;
    EXCEPTION 
    WHEN NO_DATA_FOUND 
    THEN
      RAISE E_BOOKING_NOT_FOUND;  
    END;
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

PROCEDURE DELETE_ATTENDEE(
    PI_ATTENDEE_USERNAME attendee.attendee_username%TYPE
) AS 
E_USERNAME_DOES_NOT_EXISTS EXCEPTION;
v_username_count NUMBER;
BEGIN 
SELECT COUNT(*)
    INTO v_username_count
    FROM attendee
    WHERE attendee_username = PI_ATTENDEE_USERNAME;
    IF v_username_count = 0
    THEN
        RAISE E_USERNAME_DOES_NOT_EXISTS;
    END IF;
    DELETE FROM ATTENDEE WHERE attendee_username = PI_ATTENDEE_USERNAME;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Attendee Deleted');
EXCEPTION  
    WHEN E_USERNAME_DOES_NOT_EXISTS THEN
        DBMS_OUTPUT.PUT_LINE('User does not exists.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
END pkg_attendee;
/
