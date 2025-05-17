-- Insert flights (5 tuples)
INSERT INTO FLIGHT (ID, FLIGHT_NUMBER, ORIGIN, DESTINATION) VALUES
(1, 'AA123', 'Los Angeles', 'New York'),
(2, 'BB456', 'Chicago', 'London'),
(3, 'CC789', 'San Francisco', 'Tokyo'),
(4, 'DD012', 'Miami', 'Paris'),
(5, 'EE345', 'Dallas', 'Sydney');

-- Insert schedules (2 schedules per flight, 10 tuples total)
INSERT INTO SCHEDULE (ID, FLIGHT_ID, DEPARTURE_TIME, ARRIVAL_TIME, AVAILABLE_SEATS, PRICE) VALUES
(1, 1, '2025-05-16T10:00:00', '2025-05-16T12:00:00', 100, 200.00),
(2, 1, '2025-05-17T10:00:00', '2025-05-17T12:00:00', 95, 210.00),
(3, 2, '2025-05-16T11:00:00', '2025-05-16T13:00:00', 120, 300.00),
(4, 2, '2025-05-17T11:00:00', '2025-05-17T13:00:00', 115, 310.00),
(5, 3, '2025-05-16T12:00:00', '2025-05-16T14:00:00', 80, 400.00),
(6, 3, '2025-05-17T12:00:00', '2025-05-17T14:00:00', 75, 410.00),
(7, 4, '2025-05-16T13:00:00', '2025-05-16T15:00:00', 90, 350.00),
(8, 4, '2025-05-17T13:00:00', '2025-05-17T15:00:00', 85, 360.00),
(9, 5, '2025-05-16T14:00:00', '2025-05-16T16:00:00', 110, 500.00),
(10, 5, '2025-05-17T14:00:00', '2025-05-17T16:00:00', 105, 510.00);

-- Insert tickets (5 tuples, linked to schedules)
INSERT INTO TICKET (ID, SCHEDULE_ID, PASSENGER_NAME, PASSENGER_EMAIL, STATUS, BOOKING_TIME) VALUES
(1, 1, 'John Doe', 'john.doe@example.com', 'BOOKED', '2025-05-16T09:00:00'),
(2, 1, 'Jane Smith', 'jane.smith@example.com', 'BOOKED', '2025-05-16T09:05:00'),
(3, 3, 'Alice Johnson', 'alice.johnson@example.com', 'BOOKED', '2025-05-16T09:10:00'),
(4, 5, 'Bob Wilson', 'bob.wilson@example.com', 'BOOKED', '2025-05-16T09:15:00'),
(5, 7, 'Eve Brown', 'eve.brown@example.com', 'BOOKED', '2025-05-16T09:20:00');