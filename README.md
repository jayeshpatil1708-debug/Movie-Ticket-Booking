# Movie-Ticket-Booking
REATE DATABASE MovieBooking;
GO

USE MovieBooking;
GO

-- Delete old tables if they already exist

IF OBJECT_ID('dbo.Booking_Seats', 'U') IS NOT NULL
    DROP TABLE dbo.Booking_Seats;

IF OBJECT_ID('dbo.Bookings', 'U') IS NOT NULL
    DROP TABLE dbo.Bookings;

IF OBJECT_ID('dbo.Shows', 'U') IS NOT NULL
    DROP TABLE dbo.Shows;

IF OBJECT_ID('dbo.Theatres', 'U') IS NOT NULL
    DROP TABLE dbo.Theatres;

IF OBJECT_ID('dbo.Movies', 'U') IS NOT NULL
    DROP TABLE dbo.Movies;

IF OBJECT_ID('dbo.Users', 'U') IS NOT NULL
    DROP TABLE dbo.Users;
GO


-- 1. Users Table

CREATE TABLE Users
(
    user_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    pass VARCHAR(50) NOT NULL
);
GO

INSERT INTO Users
VALUES
(1, 'Aayush Patil', 'aayush@email.com', '9876543210', 'pass123'),
(2, 'Satwik Gaikwad', 'satwik@email.com', '9876543211', 'pass123'),
(3, 'Pratik Kumthe', 'pratik@email.com', '9876543212', 'pass123'),
(4, 'Harshal Mahajan', 'harshal@email.com', '9876543213', 'pass123'),
(5, 'Pritesh Dhake', 'pritesh@email.com', '9876543214', 'pass123'),
(6, 'Vedant Choudhary', 'vedant@email.com', '9876543215', 'pass123');
GO

SELECT * FROM Users;
GO


-- 2. Movies Table

CREATE TABLE Movies
(
    movie_id INT PRIMARY KEY,
    movie_name VARCHAR(100) NOT NULL,
    language VARCHAR(30) NOT NULL,
    duration INT NOT NULL,
    genre VARCHAR(50) NOT NULL
);
GO

INSERT INTO Movies
VALUES
(101, 'Avengers Endgame', 'English', 181, 'Action'),
(102, '3 Idiots', 'Hindi', 170, 'Comedy'),
(103, 'Chhaava', 'Hindi', 161, 'Historical'),
(104, 'Interstellar', 'English', 169, 'Sci-Fi'),
(105, 'Dangal', 'Hindi', 161, 'Sports');
GO

SELECT * FROM Movies;
GO


-- 3. Theatres Table

CREATE TABLE Theatres
(
    theatre_id INT PRIMARY KEY,
    theatre_name VARCHAR(100) NOT NULL,
    location VARCHAR(100) NOT NULL
);
GO

INSERT INTO Theatres
VALUES
(201, 'PVR Cinemas', 'Jalgaon'),
(202, 'INOX', 'Jalgaon'),
(203, 'Nataraj', 'Jalgaon'),
(204, 'Star Cinemas', 'Jalgaon');
GO

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
VALUES
(301, 101, 201, '2026-10-01', '10:00:00', 180.00),
(302, 101, 201, '2026-10-01', '19:00:00', 250.00),
(303, 102, 202, '2026-10-01', '13:00:00', 150.00),
(304, 103, 202, '2026-10-01', '18:30:00', 200.00),
(305, 104, 203, '2026-10-02', '20:00:00', 300.00),
(306, 105, 204, '2026-10-02', '17:00:00', 180.00);
GO

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
VALUES
(401, 1, 302, '2026-09-28', 500.00),
(402, 2, 303, '2026-09-28', 300.00),
(403, 3, 304, '2026-09-28', 400.00),
(404, 4, 305, '2026-09-28', 600.00),
(405, 5, 306, '2026-09-28', 360.00);
GO

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
GO

SELECT * FROM Booking_Seats;
GO


-- 7. WHERE Clause

SELECT *
FROM Movies
WHERE language = 'Hindi';
GO


-- 8. ORDER BY Clause

SELECT movie_name, duration
FROM Movies
ORDER BY duration DESC;
GO


-- 9. WHERE with Ticket Price

SELECT *
FROM Shows
WHERE ticket_price > 200;
GO


-- 10. COUNT Function

SELECT COUNT(*) AS Total_Users
FROM Users;
GO

SELECT COUNT(*) AS Total_Movies
FROM Movies;
GO


-- 11. MAX Function

SELECT MAX(ticket_price) AS Maximum_Price
FROM Shows;
GO


-- 12. MIN Function

SELECT MIN(ticket_price) AS Minimum_Price
FROM Shows;
GO


-- 13. AVG Function

SELECT AVG(ticket_price) AS Average_Price
FROM Shows;
GO


-- 14. SUM Function

SELECT SUM(total_amount) AS Total_Booking_Amount
FROM Bookings;
GO


-- 15. GROUP BY

SELECT
    language,
    COUNT(*) AS Total_Movies
FROM Movies
GROUP BY language;
GO


-- 16. GROUP BY with HAVING

SELECT
    language,
    COUNT(*) AS Total_Movies
FROM Movies
GROUP BY language
HAVING COUNT(*) > 1;
GO


-- 17. INNER JOIN - Movie and Show

SELECT
    M.movie_name,
    S.show_date,
    S.show_time,
    S.ticket_price
FROM Movies M
INNER JOIN Shows S
ON M.movie_id = S.movie_id;
GO


-- 18. INNER JOIN - Customer and Booking

SELECT
    U.name AS Customer_Name,
    B.booking_id,
    B.booking_date,
    B.total_amount
FROM Users U
INNER JOIN Bookings B
ON U.user_id = B.user_id;
GO


-- 19. INNER JOIN - Movie, Theatre and Show

SELECT
    M.movie_name,
    T.theatre_name,
    T.location,
    S.show_date,
    S.show_time,
    S.ticket_price
FROM Shows S
INNER JOIN Movies M
ON S.movie_id = M.movie_id
INNER JOIN Theatres T
ON S.theatre_id = T.theatre_id;
GO


-- 20. INNER JOIN - Booking and Seat

SELECT
    B.booking_id,
    U.name AS Customer_Name,
    BS.seat_number,
    BS.seat_type
FROM Bookings B
INNER JOIN Users U
ON B.user_id = U.user_id
INNER JOIN Booking_Seats BS
ON B.booking_id = BS.booking_id;
GO


-- 21. Subquery

SELECT
    movie_name,
    duration
FROM Movies
WHERE duration >
(
    SELECT AVG(duration)
    FROM Movies
);
GO


-- 22. UPDATE

UPDATE Shows
SET ticket_price = 200.00
WHERE show_id = 301;
GO

SELECT *
FROM Shows
WHERE show_id = 301;
GO


-- 23. DELETE

INSERT INTO Users
VALUES
(7, 'Test User', 'test@email.com', '9876543216', 'test123');
GO

SELECT *
FROM Users
WHERE user_id = 7;
GO

DELETE FROM Users
WHERE user_id = 7;
GO

-- 24. Final Movie Ticket Report

SELECT
    B.booking_id AS Ticket_No,
    U.name AS Customer_Name,
    U.phone,
    M.movie_name AS Movie_Name,
    M.language,
    M.genre,
    T.theatre_name AS Theatre_Name,
    T.location,
    S.show_date,
    S.show_time,
    BS.seat_number AS Seat_No,
    BS.seat_type AS Seat_Type,
    S.ticket_price AS Ticket_Price,
    B.total_amount AS Total_Amount,
    B.booking_date
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
