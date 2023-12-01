/* 
    Code  for creating reports
    THIS SCRIPT SHOULD BE RUN BY EVENT_APP_ADMIN.
*/
-- Reports 1: Category with most events
SELECT
    et.event_type_category,
    et.event_type_category,
    COUNT(e.event_id) "COUNT OF EVENTS"
FROM
    events     e
    LEFT JOIN event_type et ON e.event_type_id = et.event_type_id
GROUP BY
    et.event_type_category,
    et.event_type_category
ORDER BY
    3 DESC;
    
-- Report 2: Most popular venue for events
SELECT
    v.venue_name,
    v.venue_name,
    COUNT(e.event_id)
FROM
    events e
    LEFT JOIN venue  v ON e.event_venue_id = v.venue_id
GROUP BY
    v.venue_name,
    v.venue_name
ORDER BY
    3 DESC;
    
--Reports 3:Sales Report for a Specific Event    
SELECT
    e.event_name,
    e.event_name,
    NVL(SUM(b.booking_amount),0) AS total_revenue
FROM
    events e
    LEFT JOIN ticket t on t.event_id=e.event_id
    LEFT JOIN booking b ON t.ticket_id = b.ticket_id
GROUP BY
    e.event_name,
    e.event_name
ORDER BY
    3 DESC;
    
--Reports 4:Review Count for each event
SELECT
    e.event_name,
    e.event_name,
    COUNT(review_id)
FROM
    events e
LEFT JOIN
    reviews r ON e.event_id = r.event_id
GROUP BY e.event_name,e.event_name
ORDER BY
    3 DESC;
    

--Reports 5:Count of cancel for each event
SELECT
    e.event_name,
    e.event_name,
    COUNT(Booking_id)
FROM
    booking b
LEFT JOIN
ticket t ON b.ticket_id = t.ticket_id
LEFT JOIN
    events e ON e.event_id = t.event_id
WHERE
    b.booking_status = 'Cancel'
GROUP BY e.event_name,e.event_name
ORDER BY 3 DESC;
 


--Reports 6: Venue occupancy by every event
CREATE OR REPLACE VIEW VenueOccupancy AS
SELECT
    v.VENUE_NAME "VENUE NAME",
    e.event_name,
    COUNT(t.TICKET_ID) "OCCUPANCY"
FROM
    VENUE v
    LEFT JOIN EVENTS e ON v.VENUE_ID = e.EVENT_VENUE_ID
    LEFT JOIN TICKET t on t.EVENT_ID=e.EVENT_ID
    LEFT JOIN BOOKING b ON t.TICKET_ID = b.TICKET_ID
WHERE e.event_name IS NOT NULL
GROUP BY
    v.VENUE_NAME,e.event_name
ORDER BY "OCCUPANCY" DESC;


-- Reports 7: Promotion usage by every event
CREATE OR REPLACE VIEW PromotionsUsage AS
SELECT
    e.EVENT_NAME "EVENT NAME",
    p.PROMOTION_CODE "PROMOTION NAME",
    COUNT(b.BOOKING_ID) "USAGE COUNT"
FROM
    PROMOTIONS p
    LEFT JOIN BOOKING b ON p.PROMOTION_ID = b.PROMOTION_ID
    LEFT JOIN EVENTS e ON e.EVENT_ID=p.event_id
GROUP BY
    p.PROMOTION_CODE,e.EVENT_NAME
ORDER BY "USAGE COUNT" DESC;
