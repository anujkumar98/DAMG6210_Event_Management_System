/* 
    Update and delete attendee. Cancel event booking.
    THIS SCRIPT SHOULD BE RUN BY ATENDEE.
*/
--Update user and delete user 
EXEC EVENT_APP_ADMIN.pkg_attendee.UPDATE_ATTENDEE('thomas_jenkins','thomas.jenkins@email.com', '1432109876');
SELECT * FROM EVENT_APP_ADMIN.ATTENDEE WHERE attendee_username ='thomas_jenkins';


--DELETE USER 
EXEC EVENT_APP_ADMIN.pkg_attendee.ADD_ATTENDEE('alice_smith1', 'Alice', 'Smith', 'alice.smith@email.com', '9876543210', 30, 'Female');
EXEC EVENT_APP_ADMIN.pkg_attendee.DELETE_ATTENDEE('alice_smith1');


--Cancel booking
EXEC EVENT_APP_ADMIN.pkg_attendee.CANCEL_BOOKING(54);
SELECT * FROM EVENT_APP_ADMIN.BOOKING WHERE BOOKING_ID=40;


