CREATE TABLE flights (
    id BIGINT PRIMARY KEY,
    flight_number VARCHAR(255),
    destination VARCHAR(255)
);

CREATE TABLE tickets (
    id BIGINT PRIMARY KEY,
    flight_id BIGINT,
    passenger_name VARCHAR(255),
    seat_number VARCHAR(255),
    FOREIGN KEY (flight_id) REFERENCES flights(id)
);