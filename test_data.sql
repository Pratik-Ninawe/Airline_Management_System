-- Insert test data into the flights table
INSERT INTO Flight (id, flight_number, destination) VALUES (1, 'AA123', 'New York');
INSERT INTO Flight (id, flight_number, destination) VALUES (2, 'BB456', 'London');

-- Insert test data into the tickets table
INSERT INTO Ticket (id, flight_id, passenger_name, seat_number) VALUES (1, 1, 'John Doe', '12A');