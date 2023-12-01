/* 
    ADD DATA INTO EVENT_TYPE AND VENUE TABLES
    THIS SCRIPT SHOULD BE RUN BY APP_ADMIN.
*/
SET SERVEROUTPUT ON;
alter session set nls_timestamp_format = 'DD-MON-RR HH.MI';
------------------------ Event Type Data ------------------------
-- Event Type Data
EXEC pkg_app_admin.ADD_EVENT_TYPE('Conference', 'Large-scale conference', 25);
EXEC pkg_app_admin.ADD_EVENT_TYPE('Webinar', 'Online seminar', 10);
EXEC pkg_app_admin.ADD_EVENT_TYPE('Hackathon', 'Coding competition', 20);
EXEC pkg_app_admin.ADD_EVENT_TYPE('Panel Discussion', 'Discussion with experts', 15);
EXEC pkg_app_admin.ADD_EVENT_TYPE('Product Launch', 'Introduction of new products', 30);
EXEC pkg_app_admin.ADD_EVENT_TYPE('Career Fair', 'Job and internship opportunities', 12);
EXEC pkg_app_admin.ADD_EVENT_TYPE('Trade Show', 'Showcasing products and services', 28);
EXEC pkg_app_admin.ADD_EVENT_TYPE('Roundtable Discussion', 'Interactive discussion in small groups', 14);
EXEC pkg_app_admin.ADD_EVENT_TYPE('Art Exhibition', 'Display of artistic works', 18);
EXEC pkg_app_admin.ADD_EVENT_TYPE('Health and Wellness', 'Promoting a healthy lifestyle', 22);
EXEC pkg_app_admin.ADD_EVENT_TYPE('Music Concert', 'Live musical performances', 35);
EXEC pkg_app_admin.ADD_EVENT_TYPE('Sports Event', 'Athletic competitions', 40);
EXEC pkg_app_admin.ADD_EVENT_TYPE('Fashion Show', 'Showcasing latest fashion trends', 26);
EXEC pkg_app_admin.ADD_EVENT_TYPE('Culinary Expo', 'Showcasing culinary skills', 32);
EXEC pkg_app_admin.ADD_EVENT_TYPE('Science Fair', 'Display of scientific projects', 17);
EXEC pkg_app_admin.ADD_EVENT_TYPE('Community Outreach', 'Engaging with the local community', 14);
EXEC pkg_app_admin.ADD_EVENT_TYPE('Technology Expo', 'Showcasing latest technological advancements', 30);
EXEC pkg_app_admin.ADD_EVENT_TYPE('Entrepreneurship Forum', 'Hands-on technology experience', 18);
EXEC pkg_app_admin.ADD_EVENT_TYPE('Scientific Symposium', 'Exploring the latest advancements in science', 18);
------------------------ Venue Data ------------------------

EXEC pkg_app_admin.ADD_VENUE('Exhibition Hall', '456 Oak Street', 300, 'exhibition@email.com');
EXEC pkg_app_admin.ADD_VENUE('Auditorium A', '789 Maple Avenue', 150, 'auditoriumA@email.com');
EXEC pkg_app_admin.ADD_VENUE('Conference Room', '101 Pine Lane', 50, 'conference.room@email.com');
EXEC pkg_app_admin.ADD_VENUE('Convention Center', '555 Elm Street', 200, 'convention.center@email.com');
EXEC pkg_app_admin.ADD_VENUE('Grand Ballroom', '123 Rose Avenue', 250, 'grand.ballroom@email.com');
EXEC pkg_app_admin.ADD_VENUE('Meeting Room 1', '222 Birch Lane', 30, 'meeting.room1@email.com');
EXEC pkg_app_admin.ADD_VENUE('Lecture Hall', '333 Cedar Street', 120, 'lecture.hall@email.com');
EXEC pkg_app_admin.ADD_VENUE('Banquet Hall', '444 Fir Avenue', 180, 'banquet.hall@email.com');
EXEC pkg_app_admin.ADD_VENUE('Club Lounge', '666 Pine Lane', 80, 'club.lounge@email.com');
EXEC pkg_app_admin.ADD_VENUE('Garden Pavilion', '777 Maple Avenue', 50, 'garden.pavilion@email.com');
EXEC pkg_app_admin.ADD_VENUE('Rooftop Terrace', '888 Oak Street', 40, 'rooftop.terrace@email.com');
EXEC pkg_app_admin.ADD_VENUE('Small Meeting Room', '999 Elm Street', 20, 'small.meeting.room@email.com');
EXEC pkg_app_admin.ADD_VENUE('Tech Hub', '111 Tech Lane', 100, 'tech.hub@email.com');
EXEC pkg_app_admin.ADD_VENUE('Theater Room', '222 Drama Avenue', 70, 'theater.room@email.com');
EXEC pkg_app_admin.ADD_VENUE('Studio Space', '333 Artist Lane', 60, 'studio.space@email.com');
EXEC pkg_app_admin.ADD_VENUE('City View Lounge', '444 Skyline Avenue', 90, 'city.view.lounge@email.com');
EXEC pkg_app_admin.ADD_VENUE('Waterfront Hall', '555 Harbor Lane', 200, 'waterfront.hall@email.com');
EXEC pkg_app_admin.ADD_VENUE('Mountain Retreat', '666 Summit Avenue', 120, 'mountain.retreat@email.com');
EXEC pkg_app_admin.ADD_VENUE('Tech Innovation Center', '777 Innovation Lane', 150, 'tech.innovation@email.com');
EXEC pkg_app_admin.ADD_VENUE('Oceanfront Pavilion', '888 Ocean Avenue', 80, 'oceanfront.pavilion@email.com');
EXEC pkg_app_admin.ADD_VENUE('Innovation Hub', '777 Innovation Lane', 120, 'innovation.hub@email.com');
EXEC pkg_app_admin.ADD_VENUE('Science Center Auditorium', '456 Science Avenue', 30, 'science.center@email.com');
 
 