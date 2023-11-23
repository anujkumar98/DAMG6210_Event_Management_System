-- View to get venue availability
CREATE OR REPLACE VIEW venue_availability AS
SELECT
    v.venue_id AS venue_id,
    v.venue_name AS venue_name,
    e.event_id AS event_id,
    e.event_name AS event_name,
    NVL(e.event_starttime, TO_TIMESTAMP('1900-01-01 00:00', 'YYYY-MM-DD HH24:MI')) AS event_starttime,
    NVL(e.event_endtime, TO_TIMESTAMP('1900-01-01 00:00', 'YYYY-MM-DD HH24:MI')) AS event_endtime
FROM
    venue v
    LEFT JOIN events e ON v.venue_id = e.event_venue_id;
    
    
-- View to get No of seat in venue remaining
CREATE OR REPLACE VIEW EventSeatAvailability AS
SELECT
    e.event_id,
    e.event_name,
    v.venue_name,
    v.venue_total_capacity AS venue_capacity,
    NVL(SUM(t.ticket_seats),0) AS total_assigned_seats,
    NVL(v.venue_total_capacity - SUM(t.ticket_seats),v.venue_total_capacity) AS remaining_capacity
FROM
    EVENTS e
LEFT JOIN
    TICKET t ON e.event_id = t.event_id
LEFT JOIN
    VENUE v ON e.event_venue_id = v.venue_id
GROUP BY
    e.event_id, e.event_name, v.venue_name, v.venue_total_capacity;


-- View to get Category wise ticket count 
CREATE OR REPLACE VIEW TicketCategoryAvailability AS
SELECT
    t.ticket_id,
    t.event_id,
    t.ticket_category_name,
    t.ticket_seats AS total_seats,
    t.ticket_price,
    NVL(SUM(CASE WHEN b.booking_status = 'Confirmed' THEN b.booking_ticket_count ELSE 0 END), 0) AS booked_seats,
    t.ticket_seats - NVL(SUM(CASE WHEN b.booking_status = 'Confirmed' THEN b.booking_ticket_count ELSE 0 END), 0) AS remaining_seats
    FROM
        TICKET t
    LEFT JOIN
        BOOKING b ON t.ticket_id = b.ticket_id
    GROUP BY
         t.ticket_id, t.event_id, t.ticket_category_name, t.ticket_seats, t.ticket_price;

