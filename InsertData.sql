
---------------Attendee---------------
EXEC ADD_ATTENDEE('dishapatil1', 'Disha', 'Patil', 'disha@gmail.com', '8928553830', 23, 'Female');
EXEC ADD_ATTENDEE('johnsmith', 'John', 'Smith', 'john.smith@example.com', '1234567890', 30, 'Male');
EXEC ADD_ATTENDEE('alicedoe', 'Alice', 'Doe', 'alice.doe@example.com', '9876543210', 25, 'Female');
EXEC ADD_ATTENDEE('bobwilliams', 'Bob', 'Williams', 'bob.williams@example.com', '5551234567', 28, 'Male');
EXEC ADD_ATTENDEE('emilyjones', 'Emily', 'Jones', 'emily.jones@example.com', '7778889999', 22, 'Female');
EXEC ADD_ATTENDEE('mikeross', 'Mike', 'Ross', 'mike.ross@example.com', '1231231234', 35, 'Male');
EXEC ADD_ATTENDEE('sarahbrown', 'Sarah', 'Brown', 'sarah.brown@example.com', '9876543210', 28, 'Female');
EXEC ADD_ATTENDEE('jasonmiller', 'Jason', 'Miller', 'jason.miller@example.com', '5555555555', 40, 'Male');
EXEC ADD_ATTENDEE('mikeross', 'Linda', 'Wang', 'linda.wang@example.com', '6666666666', 26, 'Female');
EXEC ADD_ATTENDEE('samuellee', 'Samuel', 'Lee', 'samuel.lee@example.com', '4444444444', 32, 'Male');
EXEC ADD_ATTENDEE('rachelgreen', 'Rachel', 'Green', 'rachel.green@example.com', '3333333333', 28, 'Female');
EXEC ADD_ATTENDEE('rossgeller', 'Ross', 'Geller', 'ross.geller@example.com', '4444444444', 35, 'Male');
EXEC ADD_ATTENDEE('monicageller', 'Monica', 'Geller', 'monica.geller@example.com', '5555555555', 26, 'Female');
EXEC ADD_ATTENDEE('joeytribbiani', 'Joey', 'Tribbiani', 'joey.tribbiani@example.com', '6666666666', 30, 'Male');
EXEC ADD_ATTENDEE('phoebebuffay', 'Phoebe', 'Buffay', 'phoebe.buffay@example.com', '7777777777', 22, 'Female');
EXEC ADD_ATTENDEE('chandlerbing', 'Chandler', 'Bing', 'chandler.bing@example.com', '8888888888', 28, 'Male');
EXEC ADD_ATTENDEE('janicehosenstein', 'Janice', 'Hosenstein', 'janice.hosenstein@example.com', '9999999999', 23, 'Female');
EXEC ADD_ATTENDEE('gunthercoffee', 'Gunther', 'Coffee', 'gunther.coffee@example.com', '1010101010', 40, 'Male');
EXEC ADD_ATTENDEE('emilywaltham', 'Emily', 'Waltham', 'emily.waltham@example.com', '1212121212', 27, 'Female');
EXEC ADD_ATTENDEE('richardburke', 'Richard', 'Burke', 'richard.burke@example.com', '1313131313', 33, 'Male');
EXEC ADD_ATTENDEE('janinelecroix', 'Janine', 'Lecroix', 'janine.lecroix@example.com', '1414141414', 29, 'Female');

-----EVENT TYPE---------------

EXEC ADD_EVENT_TYPE('MUSIC', 'Live music performance', 12);
EXEC ADD_EVENT_TYPE('SPORTS', 'Football match', 18);
EXEC ADD_EVENT_TYPE('CONFERENCE', 'Technology conference', 21);
EXEC ADD_EVENT_TYPE('ART', 'Art exhibition', 0);
EXEC ADD_EVENT_TYPE('FOOD', 'Food festival', 0);
EXEC ADD_EVENT_TYPE('EDUCATION', 'Educational workshop', 16);
EXEC ADD_EVENT_TYPE('CHARITY', 'Charity fundraiser', 0);
EXEC ADD_EVENT_TYPE('MOVIES', 'Movie premiere', 0);
EXEC ADD_EVENT_TYPE('GAMING', 'Gaming tournament', 12);
EXEC ADD_EVENT_TYPE('BOOKS', 'Book reading session', 0);

---------------VENUE---------------
EXEC ADD_VENUE('Conference Hall', 'Main Street, City Center', 200, 'conf.hall@example.com');
EXEC ADD_VENUE('Outdoor Park', 'City Park', 300, 'park@example.com');
EXEC ADD_VENUE('Theater', 'Downtown Theater District', 120, 'theater@example.com');
EXEC ADD_VENUE('Exhibition Center', 'Expo Zone, Business District', 250, 'expo.center@example.com');
EXEC ADD_VENUE('Sports Arena', 'Sports Complex, Stadium Road', 500, 'sports.arena@example.com');
EXEC ADD_VENUE('Banquet Hall', 'Elegant Banquet Street', 150, 'banquet.hall@example.com');
EXEC ADD_VENUE('Community Center', 'Community Street, Suburb', 100, 'community.center@example.com');
EXEC ADD_VENUE('Garden Pavilion', 'Botanical Gardens', 80, 'garden.pavilion@example.com');
EXEC ADD_VENUE('Tech Hub', 'Tech District, Innovation Road', 200, 'tech.hub@example.com');

--truncate table venue;

---------EVENT----------
EXEC ADD_EVENT('Music_Fest', 'Live Music Festival', 'Scheduled', TO_TIMESTAMP('2023-02-15 18:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2023-02-15 23:00', 'YYYY-MM-DD HH24:MI'), 'MUSIC', 'Outdoor Park');
EXEC ADD_EVENT('Tech_Summit', 'Innovation and Technology Summit', 'Scheduled', TO_TIMESTAMP('2023-03-10 09:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2023-03-10 17:00', 'YYYY-MM-DD HH24:MI'), 'CONFERENCE', 'Tech Hub');
EXEC ADD_EVENT('Art_Expo', 'Modern Art Exhibition', 'Scheduled', TO_TIMESTAMP('2023-04-05 12:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2023-04-05 20:00', 'YYYY-MM-DD HH24:MI'), 'ART', 'Exhibition Center');
EXEC ADD_EVENT('Food_Fest', 'International Food Festival', 'Scheduled', TO_TIMESTAMP('2023-05-20 16:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2023-05-20 22:00', 'YYYY-MM-DD HH24:MI'), 'FOOD', 'Banquet Hall');
EXEC ADD_EVENT('Tech_Workshop', 'Advanced Tech Workshop', 'Scheduled', TO_TIMESTAMP('2023-06-15 10:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2023-06-15 14:00', 'YYYY-MM-DD HH24:MI'), 'EDUCATION', 'Tech Hub');
EXEC ADD_EVENT('Charity_Run', 'Community Charity Run', 'Scheduled', TO_TIMESTAMP('2023-07-08 07:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2023-07-08 12:00', 'YYYY-MM-DD HH24:MI'), 'CHARITY', 'Community Center');
EXEC ADD_EVENT('Movie_Night', 'Outdoor Movie Night', 'Scheduled', TO_TIMESTAMP('2023-08-25 19:30', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2023-08-25 22:30', 'YYYY-MM-DD HH24:MI'), 'MOVIES', 'Theater');
EXEC ADD_EVENT('Gaming_Tournament', 'Esports Gaming Tournament', 'Scheduled', TO_TIMESTAMP('2023-09-12 14:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2023-09-12 18:00', 'YYYY-MM-DD HH24:MI'), 'GAMING', 'Sports Arena');
EXEC ADD_EVENT('Book_Reading', 'Classic Book Reading Session', 'Scheduled', TO_TIMESTAMP('2023-10-05 17:00', 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP('2023-10-05 19:00', 'YYYY-MM-DD HH24:MI'), 'BOOKS', 'Garden Pavilion');


------------TICKETS---------
EXEC ADD_TICKET('VIP', 100.00, 50, 2, 'Music_Fest');
EXEC ADD_TICKET('Student', 25.00, 150, 3, 'Music_Fest');
EXEC ADD_TICKET('Early Bird', 40.00, 75, 1, 'Tech_Summit');
EXEC ADD_TICKET('Regular', 75.00, 200, 4, 'Tech_Summit');
EXEC ADD_TICKET('Day Pass', 30.00, 120, 2, 'Art_Expo');
EXEC ADD_TICKET('Food Lover', 45.00, 80, 2, 'Food_Fest');
EXEC ADD_TICKET('Workshop Access', 20.00, 50, 2, 'Tech_Workshop');
EXEC ADD_TICKET('Charity Runner', 10.00, 200, 1, 'Charity_Run');
EXEC ADD_TICKET('Movie Enthusiast', 15.00, 100, 2, 'Movie_Night');
EXEC ADD_TICKET('Gamer Pass', 60.00, 50, 3, 'Gaming_Tournament');


-----------------PROMOTIONS------------
EXEC ADD_PROMOTION('PROMO1', TO_DATE('2023-02-01', 'YYYY-MM-DD'), TO_DATE('2024-02-28', 'YYYY-MM-DD'), 10, 100, 'Music_Fest');
EXEC ADD_PROMOTION('PROMO2', TO_DATE('2023-03-01', 'YYYY-MM-DD'), TO_DATE('2023-03-31', 'YYYY-MM-DD'), 15, 50, 'Tech_Summit');
EXEC ADD_PROMOTION('PROMO3', TO_DATE('2023-04-01', 'YYYY-MM-DD'), TO_DATE('2024-04-30', 'YYYY-MM-DD'), 20, 75, 'Art_Expo');
EXEC ADD_PROMOTION('PROMO4', TO_DATE('2023-05-01', 'YYYY-MM-DD'), TO_DATE('2024-05-31', 'YYYY-MM-DD'), 25, 60, 'Food_Fest');
EXEC ADD_PROMOTION('PROMO5', TO_DATE('2023-06-01', 'YYYY-MM-DD'), TO_DATE('2023-11-28', 'YYYY-MM-DD'), 30, 40, 'Tech_Workshop');
EXEC ADD_PROMOTION('PROMO6', TO_DATE('2023-07-01', 'YYYY-MM-DD'), TO_DATE('2023-07-31', 'YYYY-MM-DD'), 5, 120, 'Charity_Run');
EXEC ADD_PROMOTION('PROMO7', TO_DATE('2023-08-01', 'YYYY-MM-DD'), TO_DATE('2024-08-31', 'YYYY-MM-DD'), 12, 80, 'Movie_Night');
EXEC ADD_PROMOTION('PROMO8', TO_DATE('2023-09-01', 'YYYY-MM-DD'), TO_DATE('2024-09-30', 'YYYY-MM-DD'), 8, 30, 'Gaming_Tournament');
EXEC ADD_PROMOTION('PROMO9', TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2024-09-30', 'YYYY-MM-DD'), 8, 30, 'Music_Fest');

---------------BOOKINS----------------

EXEC ADD_BOOKING(1, 'dishapatil1', 'PROMO1', 'VIP', 'Music_Fest');
EXEC ADD_BOOKING(1, 'alicedoe', 'PROMO2', 'Early Bird', 'Tech_Summit');
EXEC ADD_BOOKING(2, 'dishapatil1', 'PROMO1', 'Student', 'Music_Fest');
EXEC ADD_BOOKING(2, 'dishapatil1', 'PROMO2', 'Regular', 'Tech_Summit');
EXEC ADD_BOOKING(2, 'alicedoe', 'PROMO3', 'Day Pass', 'Art_Expo');
EXEC ADD_BOOKING(2, 'mikeross', 'PROMO1', 'Regular', 'Music_Fest');
EXEC ADD_BOOKING(2, 'monicadavis', 'PROMO5', 'VIP', 'Tech_Workshop');
EXEC ADD_BOOKING(2, 'peterjones', 'PROMO1', 'VIP', 'Music_Fest');
EXEC ADD_BOOKING(2, 'rachelgreen', 'PROMO4', 'VIP', 'Food_Fest');

EXEC ADD_BOOKING(2, 'rossgeller', 'PROMO4', 'Regular', 'Food_Fest');

EXEC ADD_BOOKING(2, 'monicageller', 'PROMO4', 'VIP', 'Food_Fest');

EXEC ADD_BOOKING(2, 'joeytribbiani', 'PROMO4', 'Early Bird', 'Food_Fest');

EXEC ADD_BOOKING(2, 'phoebebuffay', 'PROMO4', 'Regular', 'Food_Fest');
-- Booking for Chandler Bing
EXEC ADD_BOOKING(2, 'chandlerbing', 'PROMO4', 'VIP', 'Food_Fest');
-- Booking for Janice Hosenstein
EXEC ADD_BOOKING(2, 'janicehosenstein', 'PROMO4', 'Early Bird', 'Food_Fest');
-- Booking for Gunther Coffee
EXEC ADD_BOOKING(2, 'gunthercoffee', 'PROMO4', 'Regular', 'Food_Fest');
-- Booking for Emily Waltham
EXEC ADD_BOOKING(2, 'emilywaltham', 'PROMO4', 'VIP', 'Food_Fest');
-- Booking for Richard Burke
EXEC ADD_BOOKING(2, 'richardburke', 'PROMO4', 'Early Bird', 'Food_Fest');

-------------REVIEWS----------------
EXEC ADD_REVIEW('Great event!', 'Music_Fest', 'oliviawilson');
EXEC ADD_REVIEW('Awesome performance!', 'Tech_Summit', 'oliviawilson');
EXEC ADD_REVIEW('Loved every moment!', 'Tech_Summit', 'oliviawilson');
EXEC ADD_REVIEW('Fantastic atmosphere!', 'Art_Expo', 'oliviawilson');
EXEC ADD_REVIEW('Highly recommended!', 'Food_Fest', 'oliviawilson');






