/* 
    TRIGGERS for creating deleted user copy
    THIS SCRIPT SHOULD BE RUN BY EVENT_APP_ADMIN.
*/
-- Trigger to copy value of attendee into a diffrent table when deleted
CREATE OR REPLACE TRIGGER attendee_before_delete
BEFORE DELETE
ON event_app_admin.ATTENDEE
FOR EACH ROW
BEGIN
   -- Insert record into audit table
   INSERT INTO event_app_admin.ATTENDEE_AUDIT
   (ATTENDEE_USERNAME,
    ATTENDEE_ID,
    ATTENDEE_FIRSTNAME,
    ATTENDEE_LASTNAME,
    ATTENDEE_EMAIL,
    ATTENDEE_MOBILE_NO,
    ATTENDEE_AGE,
    ATTENDEE_GENDER,
    ATTENDEE_CREATED_AT,
    ATTENDEE_DELETED_DATE)
   VALUES
   (:old.ATTENDEE_USERNAME,
    :old.ATTENDEE_ID,
    :old.ATTENDEE_FIRSTNAME,
    :old.ATTENDEE_LASTNAME,
    :old.ATTENDEE_EMAIL,
    :old.ATTENDEE_MOBILE_NO,
    :old.ATTENDEE_AGE,
    :old.ATTENDEE_GENDER,
    :old.ATTENDEE_CREATED_AT,
    SYSTIMESTAMP);
END;
/