/* 
    ADD DATA INTO EVENT,TICKET,PROMOTION TABLES
    THIS SCRIPT SHOULD BE RUN BY EVENT_MANAGER.
*/
SET SERVEROUTPUT ON;
alter session set nls_timestamp_format = 'DD-MON-RR HH.MI';
----------- Events ---------------------
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_EVENT('Tech Conference', 'Annual technology conference', 'Scheduled', TO_TIMESTAMP('2023-12-05 10:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2023-12-05 18:00', 'YYYY-MM-DD HH24:MI'), 'Conference', 'Exhibition Hall');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_EVENT('Business Seminar', 'Strategies for Success', 'Scheduled', TO_TIMESTAMP('2023-11-20 13:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2023-11-20 17:00', 'YYYY-MM-DD HH24:MI'), 'Webinar', 'Auditorium A');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_EVENT('Networking Mixer', 'Casual networking event', 'Scheduled', TO_TIMESTAMP('2023-11-25 18:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2023-11-25 21:00', 'YYYY-MM-DD HH24:MI'), 'Career Fair', 'Conference Room');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_EVENT('Data Science Workshop', 'Hands-on data analysis', 'Scheduled', TO_TIMESTAMP('2023-12-10 14:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2023-12-10 17:00', 'YYYY-MM-DD HH24:MI'), 'Webinar', 'Exhibition Hall');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_EVENT('Marketing Summit', 'Latest trends in marketing', 'Scheduled', TO_TIMESTAMP('2023-11-30 09:30', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2023-11-30 16:30', 'YYYY-MM-DD HH24:MI'), 'Panel Discussion', 'Auditorium A');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_EVENT('Startup Networking', 'Connect with entrepreneurs', 'Scheduled', TO_TIMESTAMP('2023-12-15 17:30', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2023-12-15 20:30', 'YYYY-MM-DD HH24:MI'), 'Career Fair', 'Conference Room');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_EVENT('Artificial Intelligence Symposium', 'Exploring AI advancements', 'Scheduled', TO_TIMESTAMP('2023-11-22 11:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2023-11-22 16:00', 'YYYY-MM-DD HH24:MI'), 'Conference', 'Exhibition Hall');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_EVENT('Finance Seminar', 'Financial planning strategies', 'Scheduled', TO_TIMESTAMP('2023-12-08 12:30', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2023-12-08 15:30', 'YYYY-MM-DD HH24:MI'), 'Hackathon', 'Auditorium A');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_EVENT('Career Development Mixer', 'Job opportunities and networking', 'Scheduled', TO_TIMESTAMP('2023-11-28 18:30', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2023-11-28 21:30', 'YYYY-MM-DD HH24:MI'), 'Trade Show', 'Conference Room');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_EVENT('Coding Bootcamp', 'Learn to code from experts', 'Scheduled', TO_TIMESTAMP('2023-12-18 09:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2023-12-18 17:00', 'YYYY-MM-DD HH24:MI'), 'Science Fair', 'Exhibition Hall');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_EVENT('Health and Wellness Seminar', 'Holistic approach to well-being', 'Scheduled', TO_TIMESTAMP('2023-11-26 14:30', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2023-11-26 18:30', 'YYYY-MM-DD HH24:MI'), 'Community Outreach', 'Auditorium A');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_EVENT('Entrepreneurship Forum', 'Insights from successful entrepreneurs', 'Scheduled', TO_TIMESTAMP('2023-12-03 16:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2023-12-03 20:00', 'YYYY-MM-DD HH24:MI'), 'Roundtable Discussion', 'Conference Room');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_EVENT('Web Development Workshop', 'Building modern web applications', 'Scheduled', TO_TIMESTAMP('2023-11-23 10:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2023-11-23 16:00', 'YYYY-MM-DD HH24:MI'), 'Webinar', 'Exhibition Hall');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_EVENT('Leadership Summit', 'Developing effective leadership skills', 'Scheduled', TO_TIMESTAMP('2023-12-12 09:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2023-12-12 17:00', 'YYYY-MM-DD HH24:MI'), 'Technology Expo', 'Auditorium A');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_EVENT('Film Industry Mixer', 'Networking for film professionals', 'Scheduled', TO_TIMESTAMP('2023-12-01 19:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2023-12-01 22:00', 'YYYY-MM-DD HH24:MI'), 'Fashion Show', 'Conference Room');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_EVENT('Robotics Symposium', 'Advancements in robotics technology', 'Scheduled', TO_TIMESTAMP('2023-11-29 11:30', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2023-11-29 15:30', 'YYYY-MM-DD HH24:MI'), 'Hackathon', 'Exhibition Hall');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_EVENT('Legal Seminar', 'Current issues in law and policy', 'Scheduled', TO_TIMESTAMP('2023-12-06 13:30', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2023-12-06 17:30', 'YYYY-MM-DD HH24:MI'), 'Trade Show', 'Auditorium A');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_EVENT('Social Media Networking', 'Connecting in the digital age', 'Scheduled', TO_TIMESTAMP('2023-11-27 18:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2023-11-27 21:00', 'YYYY-MM-DD HH24:MI'), 'Technology Expo', 'Conference Room');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_EVENT('Space Exploration Workshop', 'Journey to the stars', 'Scheduled', TO_TIMESTAMP('2023-12-14 15:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2023-12-14 18:00', 'YYYY-MM-DD HH24:MI'), 'Science Fair', 'Exhibition Hall');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_EVENT('Fashion Show', 'Showcasing latest fashion trends', 'Scheduled', TO_TIMESTAMP('2023-11-21 16:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2023-11-21 19:00', 'YYYY-MM-DD HH24:MI'), 'Fashion Show', 'Grand Ballroom');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_EVENT('Startup Pitch Event', 'Showcasing innovative startup ideas', 'Scheduled', TO_TIMESTAMP('2023-12-07 15:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2023-12-07 18:00', 'YYYY-MM-DD HH24:MI'), 'Entrepreneurship Forum', 'Innovation Hub');

-----------TICKETS ---------------------

EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_TICKET('General Admission', 50.00, 100, 5, 'Tech Conference');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_TICKET('VIP Access', 150.00, 20, 3, 'Tech Conference');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_TICKET('Early Bird', 40.00, 50, 2, 'Tech Conference');

--SELECT * FROM EVENTS WHERE EVENT_NAME='Tech Conference';


EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_TICKET('General Admission', 50.00, 10, 2, 'Tech Conference');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_TICKET('VIP Access', 150.00, 5, 2, 'Tech Conference');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_TICKET('Early Bird', 60.00, 5, 2, 'Tech Conference');
 

EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_TICKET('Standard Pass', 30.00, 80, 4, 'Business Seminar');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_TICKET('Premium Pass', 60.00, 30, 2, 'Business Seminar');

EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_TICKET('Networking Pass', 20.00, 60, 3, 'Networking Mixer');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_TICKET('VIP Networking', 75.00, 15, 2, 'Networking Mixer');

EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_TICKET('Data Enthusiast', 25.00, 70, 3, 'Data Science Workshop');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_TICKET('Master Analyst', 70.00, 25, 2, 'Data Science Workshop');

EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_TICKET('Marketing Enthusiast', 35.00, 60, 4, 'Marketing Summit');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_TICKET('Marketing Pro', 80.00, 20, 2, 'Marketing Summit');

EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_TICKET('Startup Enthusiast', 30.00, 50, 3, 'Startup Networking');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_TICKET('Startup VIP', 90.00, 15, 2, 'Startup Networking');

EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_TICKET('AI Explorer', 40.00, 90, 4, 'Artificial Intelligence Symposium');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_TICKET('AI Expert', 100.00, 30, 2, 'Artificial Intelligence Symposium');

EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_TICKET('Finance Buff', 45.00, 65, 3, 'Finance Seminar');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_TICKET('Finance Guru', 120.00, 15, 2, 'Finance Seminar');

EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_TICKET('Career Development Pass', 25.00, 50, 4, 'Career Development Mixer');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_TICKET('Executive Networking', 85.00, 18, 2, 'Career Development Mixer');

EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_TICKET('Coding Enthusiast', 30.00, 60, 3, 'Coding Bootcamp');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_TICKET('Code Master', 100.00, 25, 2, 'Coding Bootcamp');

EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_TICKET('Wellness Seeker', 20.00, 40, 5, 'Health and Wellness Seminar');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_TICKET('Wellness Pro', 65.00, 15, 2, 'Health and Wellness Seminar');

EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_TICKET('Entrepreneurial Spirit', 35.00, 55, 3, 'Entrepreneurship Forum');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_TICKET('Startup Roundtable', 80.00, 20, 2, 'Entrepreneurship Forum');

EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_TICKET('Web Dev Enthusiast', 30.00, 50, 4, 'Web Development Workshop');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_TICKET('Web Dev Pro', 90.00, 18, 2, 'Web Development Workshop');

EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_TICKET('Leadership Enthuast', 40.00, 60, 3, 'Leadership Summit');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_TICKET('Leadership Pro', 110.00, 20, 2, 'Leadership Summit');

EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_TICKET('Film Industry Pass', 25.00, 45, 4, 'Film Industry Mixer');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_TICKET('VIP Filmmaker', 75.00, 15, 2, 'Film Industry Mixer');

EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_TICKET('Robotics Enthusiast', 35.00, 55, 3, 'Robotics Symposium');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_TICKET('Robotics Pro', 95.00, 18, 2, 'Robotics Symposium');

EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_TICKET('Legal Insights', 30.00, 50, 4, 'Legal Seminar');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_TICKET('Legal Expert', 85.00, 20, 2, 'Legal Seminar');

EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_TICKET('Social Media Pass', 20.00, 40, 5, 'Social Media Networking');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_TICKET('Digital Connector', 60.00, 20, 2, 'Social Media Networking');

EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_TICKET('Space Explorer', 40.00, 70, 3, 'Space Exploration Workshop');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_TICKET('Stellar Voyager', 120.00, 25, 2, 'Space Exploration Workshop');

EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_TICKET('Fashion Enthusiast', 30.00, 55, 4, 'Fashion Show');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_TICKET('Fashionista VIP', 100.00, 15, 2, 'Fashion Show');



EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_TICKET('General Admission', 50.00, 10, 2, 'Startup Pitch Event');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_TICKET('VIP Access', 150.00, 5, 2, 'Startup Pitch Event');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_TICKET('Early Bird', 60.00, 5, 2, 'Startup Pitch Event');
 
-------------------- PROMOTIONS ------------------------

EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_PROMOTION('TECH20NOW', TO_DATE('2023-11-15', 'YYYY-MM-DD'), TO_DATE('2023-11-30', 'YYYY-MM-DD'), 20.00, 50, 'Tech Conference');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_PROMOTION('SUCCESSBOOST', TO_DATE('2023-11-25', 'YYYY-MM-DD'), TO_DATE('2023-12-05', 'YYYY-MM-DD'), 25.00, 30, 'Business Seminar');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_PROMOTION('CONNECTPLUS', TO_DATE('2023-11-28', 'YYYY-MM-DD'), TO_DATE('2023-12-15', 'YYYY-MM-DD'), 30.00, 40, 'Networking Mixer');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_PROMOTION('DATAHUB', TO_DATE('2023-12-01', 'YYYY-MM-DD'), TO_DATE('2023-12-10', 'YYYY-MM-DD'), 35.00, 25, 'Data Science Workshop');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_PROMOTION('MARKETEDGE', TO_DATE('2023-11-20', 'YYYY-MM-DD'), TO_DATE('2023-11-30', 'YYYY-MM-DD'), 22.00, 35, 'Marketing Summit');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_PROMOTION('STARTUPSPARK', TO_DATE('2023-12-05', 'YYYY-MM-DD'), TO_DATE('2023-12-20', 'YYYY-MM-DD'), 28.00, 20, 'Startup Networking');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_PROMOTION('AIFUTURE', TO_DATE('2023-11-18', 'YYYY-MM-DD'), TO_DATE('2023-12-05', 'YYYY-MM-DD'), 20.00, 30, 'Artificial Intelligence Symposium');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_PROMOTION('FINWISE', TO_DATE('2023-11-28', 'YYYY-MM-DD'), TO_DATE('2023-12-15', 'YYYY-MM-DD'), 25.00, 25, 'Finance Seminar');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_PROMOTION('CAREERBOOST', TO_DATE('2023-11-21', 'YYYY-MM-DD'), TO_DATE('2023-12-10', 'YYYY-MM-DD'), 32.00, 40, 'Career Development Mixer');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_PROMOTION('CODEMASTER', TO_DATE('2023-12-05', 'YYYY-MM-DD'), TO_DATE('2023-12-18', 'YYYY-MM-DD'), 40.00, 15, 'Coding Bootcamp');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_PROMOTION('WELLNESSJOY', TO_DATE('2023-11-26', 'YYYY-MM-DD'), TO_DATE('2023-12-05', 'YYYY-MM-DD'), 22.00, 35, 'Health and Wellness Seminar');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_PROMOTION('ENTREPRENOW', TO_DATE('2023-11-30', 'YYYY-MM-DD'), TO_DATE('2023-12-15', 'YYYY-MM-DD'), 28.00, 20, 'Entrepreneurship Forum');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_PROMOTION('WEBWONDER', TO_DATE('2023-11-22', 'YYYY-MM-DD'), TO_DATE('2023-12-05', 'YYYY-MM-DD'), 20.00, 30, 'Web Development Workshop');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_PROMOTION('LEADERSHIPPLUS', TO_DATE('2023-12-08', 'YYYY-MM-DD'), TO_DATE('2023-12-20', 'YYYY-MM-DD'), 25.00, 25, 'Leadership Summit');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_PROMOTION('FILMFEST', TO_DATE('2023-12-01', 'YYYY-MM-DD'), TO_DATE('2023-12-10', 'YYYY-MM-DD'), 32.00, 40, 'Film Industry Mixer');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_PROMOTION('ROBOINNOVATE', TO_DATE('2023-11-29', 'YYYY-MM-DD'), TO_DATE('2023-12-10', 'YYYY-MM-DD'), 40.00, 15, 'Robotics Symposium');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_PROMOTION('LEGALINSIGHT', TO_DATE('2023-12-06', 'YYYY-MM-DD'), TO_DATE('2023-12-15', 'YYYY-MM-DD'), 22.00, 35, 'Legal Seminar');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_PROMOTION('SOCIALCONNECT', TO_DATE('2023-11-27', 'YYYY-MM-DD'), TO_DATE('2023-12-10', 'YYYY-MM-DD'), 28.00, 20, 'Social Media Networking');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_PROMOTION('SPACENEXT', TO_DATE('2023-12-14', 'YYYY-MM-DD'), TO_DATE('2023-12-25', 'YYYY-MM-DD'), 35.00, 25, 'Space Exploration Workshop');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_PROMOTION('FASHIONGALA', TO_DATE('2023-11-21', 'YYYY-MM-DD'), TO_DATE('2023-12-05', 'YYYY-MM-DD'), 25.00, 30, 'Fashion Show');
EXEC EVENT_APP_ADMIN.pkg_event_manager.ADD_PROMOTION('STARTUP20', TO_DATE('2023-11-15', 'YYYY-MM-DD'), TO_DATE('2023-12-03', 'YYYY-MM-DD'), 20.00, 10, 'Startup Pitch Event');