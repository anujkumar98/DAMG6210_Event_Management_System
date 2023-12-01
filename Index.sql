/* 
    Index on booking data
    THIS SCRIPT SHOULD BE RUN BY EVENT_APP_ADMIN.
*/
SET SERVEROUTPUT ON;
DECLARE 
   v_index_count NUMBER;
BEGIN
   -- Check if the index already exists
   SELECT COUNT(*)
   INTO v_index_count
   FROM user_indexes
   WHERE index_name = 'IDX_BOOKING_DATE_MONTH_YEAR';

   -- If the index doesn't exist, create it
   IF v_index_count = 0 THEN
      EXECUTE IMMEDIATE 'CREATE INDEX idx_booking_date_month_year ON booking(EXTRACT(MONTH FROM booking_date), EXTRACT(YEAR FROM booking_date))';
      DBMS_OUTPUT.PUT_LINE('Index created successfully.');
   ELSE
      DBMS_OUTPUT.PUT_LINE('Index already exists.');
   END IF;
EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END CreateBookingDateIndex;
/

