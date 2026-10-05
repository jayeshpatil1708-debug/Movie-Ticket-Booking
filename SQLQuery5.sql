

USE MovieBooking;
GO

DROP TABLE IF EXISTS Booking_Seats;
DROP TABLE IF EXISTS Bookings;
DROP TABLE IF EXISTS Shows;
DROP TABLE IF EXISTS Theatres;
DROP TABLE IF EXISTS Movies;
DROP TABLE IF EXISTS Users;
GO


-- 1. Users Table

CREATE TABLE Users
(
    user_id INT PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL,
    phone VARCHAR(13) UNIQUE NOT NULL,
    pass VARCHAR(55) NOT NULL
);
GO

INSERT INTO Users
(user_id, name, email, phone, pass)
VALUES
(1, 'Aayush Patil', 'aayush@email.com', '9876543210', 'pass123'),
(2, 'Satwik Gaikwad', 'satwik@email.com', '9876543211', 'pass123'),
(3, 'Pratik Kumthe', 'pratik@email.com', '9876543212', 'pass123'),
(4, 'Harshal Mahajan', 'harshal@email.com', '9876543213', 'pass123'),
(5, 'Pritesh Dhake', 'pritesh@email.com', '9876543214', 'pass123'),
(6, 'Vedant Choudhary', 'vedant@email.com', '9876543215', 'pass123');

SELECT * FROM Users;
GO


-- 2. Movies Table

CREATE TABLE Movies
(
    movie_id INT PRIMARY KEY,
    movie_name VARCHAR(50) NOT NULL,
    language VARCHAR(20) NOT NULL,
    duration INT NOT NULL,
    genre VARCHAR(30) NOT NULL
);
GO

INSERT INTO Movies
(movie_id, movie_name, language, duration, genre)
VALUES
(101, 'Avengers Endgame', 'English', 181, 'Action'),
(102, '3 Idiots', 'Hindi', 170, 'Comedy'),
(103, 'Chhaava', 'Hindi', 161, 'Historical'),
(104, 'Interstellar', 'English', 169, 'Sci-Fi'),
(105, 'Dangal', 'Hindi', 161, 'Sports');

SELECT * FROM Movies;
GO


-- 3. Theatres Table

CREATE TABLE Theatres
(
    theatre_id INT PRIMARY KEY,
    theatre_name VARCHAR(50) NOT NULL,
    location VARCHAR(50) NOT NULL
);
GO

INSERT INTO Theatres
(theatre_id, theatre_name, location)
VALUES
(201, 'PVR Cinemas', 'Nashik'),
(202, 'INOX', 'Jalgaon'),
(203, 'Cinepolis', 'Pune'),
(204, 'City Pride', 'Pune');

SELECT * FROM Theatres;
GO


-- 4. Shows Table

CREATE TABLE Shows
(
    show_id INT PRIMARY KEY,
    movie_id INT NOT NULL,
    theatre_id INT NOT NULL,
    show_date DATE NOT NULL,
    show_time TIME NOT NULL,
    ticket_price DECIMAL(8,2) NOT NULL,

    FOREIGN KEY (movie_id)
        REFERENCES Movies(movie_id),

    FOREIGN KEY (theatre_id)
        REFERENCES Theatres(theatre_id)
);
GO

INSERT INTO Shows
(show_id, movie_id, theatre_id, show_date, show_time, ticket_price)
VALUES
(301, 101, 201, '2026-10-01', '10:00:00', 180.00),
(302, 101, 201, '2026-10-01', '19:00:00', 250.00),
(303, 102, 202, '2026-10-01', '13:00:00', 150.00),
(304, 103, 202, '2026-10-01', '18:30:00', 200.00),
(305, 104, 203, '2026-10-02', '20:00:00', 300.00),
(306, 105, 204, '2026-10-02', '17:00:00', 180.00);

SELECT * FROM Shows;
GO


-- 5. Bookings Table

CREATE TABLE Bookings
(
    booking_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    show_id INT NOT NULL,
    booking_date DATE NOT NULL,
    total_amount DECIMAL(8,2) NOT NULL,

    FOREIGN KEY (user_id)
        REFERENCES Users(user_id),

    FOREIGN KEY (show_id)
        REFERENCES Shows(show_id)
);
GO

INSERT INTO Bookings
(booking_id, user_id, show_id, booking_date, total_amount)
VALUES
(401, 1, 302, '2026-09-28', 500.00),
(402, 2, 303, '2026-09-28', 300.00),
(403, 3, 304, '2026-09-28', 400.00),
(404, 4, 305, '2026-09-28', 600.00),
(405, 5, 306, '2026-09-28', 360.00);

SELECT * FROM Bookings;
GO


-- 6. Booking Seats Table

CREATE TABLE Booking_Seats
(
    booking_seat_id INT PRIMARY KEY,
    booking_id INT NOT NULL,
    seat_number VARCHAR(10) NOT NULL,
    seat_type VARCHAR(20) NOT NULL,

    FOREIGN KEY (booking_id)
        REFERENCES Bookings(booking_id)
);
GO

INSERT INTO Booking_Seats
(booking_seat_id, booking_id, seat_number, seat_type)
VALUES
(501, 401, 'A5', 'Regular'),
(502, 401, 'A6', 'Regular'),
(503, 402, 'B4', 'Regular'),
(504, 402, 'B5', 'Regular'),
(505, 403, 'C7', 'Premium'),
(506, 403, 'C8', 'Premium'),
(507, 404, 'D5', 'Premium'),
(508, 404, 'D6', 'Premium'),
(509, 405, 'E3', 'Regular'),
(510, 405, 'E4', 'Regular');

SELECT * FROM Booking_Seats;
GO

SELECT
    B.booking_id AS Ticket_No,
    U.name AS Customer_Name,
    U.phone AS Phone,
    M.movie_name AS Movie_Name,
    M.language AS Language,
    M.genre AS Genre,
    T.theatre_name AS Theatre_Name,
    T.location AS Location,
    S.show_date AS Show_Date,
    S.show_time AS Show_Time,
    BS.seat_number AS Seat_No,
    BS.seat_type AS Seat_Type,
    S.ticket_price AS Ticket_Price,
    B.total_amount AS Total_Amount,
    B.booking_date AS Booking_Date
FROM Bookings B
INNER JOIN Users U
ON B.user_id = U.user_id
INNER JOIN Shows S
ON B.show_id = S.show_id
INNER JOIN Movies M
ON S.movie_id = M.movie_id
INNER JOIN Theatres T
ON S.theatre_id = T.theatre_id
INNER JOIN Booking_Seats BS
ON B.booking_id = BS.booking_id
ORDER BY B.booking_id, BS.seat_number;
GO