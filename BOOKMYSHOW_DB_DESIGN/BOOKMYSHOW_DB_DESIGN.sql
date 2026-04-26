-- ============================================================
--  BookMyShow Database Schema + Dummy Data
--  DBMS : MySQL 8.0+
-- ============================================================
CREATE DATABASE BOOKMYSHOW;
USE BOOKMYSHOW;

-- ============================================================
-- 1. USERS
-- ============================================================
CREATE TABLE users (
    user_id        INT            NOT NULL AUTO_INCREMENT,
    name           VARCHAR(100)   NOT NULL,
    email          VARCHAR(150)   NOT NULL UNIQUE,
    phone          VARCHAR(15)    NOT NULL UNIQUE,
    password_hash  VARCHAR(255)   NOT NULL,
    created_at     TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id)
);

-- ============================================================
-- 2. CITIES
-- ============================================================
CREATE TABLE cities (
    city_id    INT           NOT NULL AUTO_INCREMENT,
    city_name  VARCHAR(80)   NOT NULL,
    state      VARCHAR(80)   NOT NULL,
    PRIMARY KEY (city_id)
);

-- ============================================================
-- 3. VENUES
-- ============================================================
CREATE TABLE venues (
    venue_id       INT           NOT NULL AUTO_INCREMENT,
    venue_name     VARCHAR(150)  NOT NULL,
    address        VARCHAR(300)  NOT NULL,
    city_id        INT           NOT NULL,
    total_screens  INT           NOT NULL DEFAULT 1,
    PRIMARY KEY (venue_id),
    CONSTRAINT fk_venue_city FOREIGN KEY (city_id)
        REFERENCES cities (city_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- ============================================================
-- 4. MOVIES
-- ============================================================
CREATE TABLE movies (
    movie_id       INT           NOT NULL AUTO_INCREMENT,
    title          VARCHAR(200)  NOT NULL,
    genre          VARCHAR(60)   NOT NULL,
    language       VARCHAR(40)   NOT NULL,
    duration_mins  INT           NOT NULL,
    certificate    VARCHAR(10)   NOT NULL COMMENT 'U, UA, A, S',
    release_date   DATE          NOT NULL,
    PRIMARY KEY (movie_id)
);

-- ============================================================
-- 5. SCREENS
-- ============================================================
CREATE TABLE screens (
    screen_id    INT           NOT NULL AUTO_INCREMENT,
    venue_id     INT           NOT NULL,
    screen_name  VARCHAR(60)   NOT NULL,
    total_seats  INT           NOT NULL,
    screen_type  VARCHAR(20)   NOT NULL COMMENT '2D, 3D, 4DX, IMAX',
    PRIMARY KEY (screen_id),
    CONSTRAINT fk_screen_venue FOREIGN KEY (venue_id)
        REFERENCES venues (venue_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- ============================================================
-- 6. SHOWS
-- ============================================================
CREATE TABLE shows (
    show_id      INT             NOT NULL AUTO_INCREMENT,
    movie_id     INT             NOT NULL,
    screen_id    INT             NOT NULL,
    show_time    DATETIME        NOT NULL,
    base_price   DECIMAL(8,2)   NOT NULL,
    status       VARCHAR(20)    NOT NULL DEFAULT 'OPEN'
                 COMMENT 'OPEN, HOUSEFUL, CANCELLED',
    PRIMARY KEY (show_id),
    CONSTRAINT fk_show_movie  FOREIGN KEY (movie_id)
        REFERENCES movies (movie_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_show_screen FOREIGN KEY (screen_id)
        REFERENCES screens (screen_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    UNIQUE KEY uq_show_screen_time (screen_id, show_time)
);

-- ============================================================
-- 7. SEATS
-- ============================================================
CREATE TABLE seats (
    seat_id          INT             NOT NULL AUTO_INCREMENT,
    screen_id        INT             NOT NULL,
    row_label        CHAR(1)         NOT NULL COMMENT 'A–Z row label',
    seat_number      INT             NOT NULL,
    category         VARCHAR(20)     NOT NULL COMMENT 'SILVER, GOLD, PLATINUM',
    price_multiplier DECIMAL(4,2)    NOT NULL DEFAULT 1.00,
    PRIMARY KEY (seat_id),
    CONSTRAINT fk_seat_screen FOREIGN KEY (screen_id)
        REFERENCES screens (screen_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    UNIQUE KEY uq_seat_position (screen_id, row_label, seat_number)
);

-- ============================================================
-- 8. BOOKINGS
-- ============================================================
CREATE TABLE bookings (
    booking_id      INT             NOT NULL AUTO_INCREMENT,
    user_id         INT             NOT NULL,
    show_id         INT             NOT NULL,
    booked_at       TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    total_amount    DECIMAL(10,2)  NOT NULL,
    booking_status  VARCHAR(20)    NOT NULL DEFAULT 'CONFIRMED'
                    COMMENT 'CONFIRMED, CANCELLED, PENDING',
    payment_status  VARCHAR(20)    NOT NULL DEFAULT 'PAID'
                    COMMENT 'PAID, PENDING, REFUNDED',
    PRIMARY KEY (booking_id),
    CONSTRAINT fk_booking_user FOREIGN KEY (user_id)
        REFERENCES users (user_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_booking_show FOREIGN KEY (show_id)
        REFERENCES shows (show_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- ============================================================
-- 9. BOOKING_SEATS  (junction / bridge table)
-- ============================================================
CREATE TABLE booking_seats (
    booking_seat_id  INT             NOT NULL AUTO_INCREMENT,
    booking_id       INT             NOT NULL,
    seat_id          INT             NOT NULL,
    seat_price       DECIMAL(8,2)   NOT NULL,
    PRIMARY KEY (booking_seat_id),
    CONSTRAINT fk_bs_booking FOREIGN KEY (booking_id)
        REFERENCES bookings (booking_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_bs_seat FOREIGN KEY (seat_id)
        REFERENCES seats (seat_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    UNIQUE KEY uq_booking_seat (booking_id, seat_id)
);

-- ============================================================
-- 10. PAYMENTS
-- ============================================================
CREATE TABLE payments (
    payment_id      INT             NOT NULL AUTO_INCREMENT,
    booking_id      INT             NOT NULL UNIQUE,
    amount          DECIMAL(10,2)  NOT NULL,
    payment_method  VARCHAR(40)    NOT NULL COMMENT 'CARD, UPI, NET_BANKING, WALLET',
    transaction_id  VARCHAR(100)   NOT NULL UNIQUE,
    status          VARCHAR(20)    NOT NULL DEFAULT 'SUCCESS'
                    COMMENT 'SUCCESS, FAILED, REFUNDED',
    paid_at         TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (payment_id),
    CONSTRAINT fk_payment_booking FOREIGN KEY (booking_id)
        REFERENCES bookings (booking_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- ============================================================
-- 11. OFFERS
-- ============================================================
CREATE TABLE offers (
    offer_id      INT             NOT NULL AUTO_INCREMENT,
    offer_code    VARCHAR(30)     NOT NULL UNIQUE,
    description   VARCHAR(200)   NOT NULL,
    discount_pct  DECIMAL(5,2)   NOT NULL,
    valid_from    DATE            NOT NULL,
    valid_to      DATE            NOT NULL,
    PRIMARY KEY (offer_id)
);

-- ============================================================
-- 12. BOOKING_OFFERS  (junction table)
-- ============================================================
CREATE TABLE booking_offers (
    id                INT             NOT NULL AUTO_INCREMENT,
    booking_id        INT             NOT NULL,
    offer_id          INT             NOT NULL,
    discount_applied  DECIMAL(8,2)   NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_bo_booking FOREIGN KEY (booking_id)
        REFERENCES bookings (booking_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_bo_offer FOREIGN KEY (offer_id)
        REFERENCES offers (offer_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    UNIQUE KEY uq_booking_offer (booking_id, offer_id)
);

-- ============================================================
-- INDEXES (performance)
-- ============================================================
CREATE INDEX idx_shows_movie   ON shows (movie_id);
CREATE INDEX idx_shows_time    ON shows (show_time);
CREATE INDEX idx_bookings_user ON bookings (user_id);
CREATE INDEX idx_bs_seat       ON booking_seats (seat_id);
CREATE INDEX idx_payments_txn  ON payments (transaction_id);

-- ============================================================
--  DUMMY DATA
-- ============================================================

-- USERS
INSERT INTO users (name, email, phone, password_hash) VALUES
('Aarav Sharma',    'aarav@email.com',   '9876543210', SHA2('pass1',256)),
('Priya Mehta',     'priya@email.com',   '9876543211', SHA2('pass2',256)),
('Rohan Desai',     'rohan@email.com',   '9876543212', SHA2('pass3',256)),
('Sneha Kapoor',    'sneha@email.com',   '9876543213', SHA2('pass4',256)),
('Vikram Nair',     'vikram@email.com',  '9876543214', SHA2('pass5',256));

-- CITIES
INSERT INTO cities (city_name, state) VALUES
('Mumbai',    'Maharashtra'),
('Bengaluru', 'Karnataka'),
('Delhi',     'Delhi'),
('Hyderabad', 'Telangana');

-- VENUES
INSERT INTO venues (venue_name, address, city_id, total_screens) VALUES
('PVR Juhu',           'Juhu, Mumbai',              1, 6),
('INOX Malleshwaram',  'Malleshwaram, Bengaluru',   2, 4),
('Cinepolis Connaught','Connaught Place, Delhi',    3, 5),
('PVR Hitech City',    'Hitech City, Hyderabad',    4, 4);

-- MOVIES
INSERT INTO movies (title, genre, language, duration_mins, certificate, release_date) VALUES
('Kalki 2898 AD',      'Action/Sci-Fi',  'Telugu',  181, 'UA', '2024-06-27'),
('Stree 2',            'Horror/Comedy',  'Hindi',   136, 'UA', '2024-08-15'),
('The Dark Knight',    'Action/Thriller','English', 152, 'UA', '2008-07-18'),
('Merry Christmas',    'Thriller',       'Hindi',   140, 'UA', '2024-01-12');

-- SCREENS
INSERT INTO screens (venue_id, screen_name, total_seats, screen_type) VALUES
(1, 'Audi 1', 200, 'IMAX'),
(1, 'Audi 2', 150, '3D'),
(2, 'Audi 1', 180, '2D'),
(3, 'Audi 1', 220, 'IMAX'),
(4, 'Audi 1', 160, '4DX');

-- SHOWS
INSERT INTO shows (movie_id, screen_id, show_time, base_price, status) VALUES
(1, 1, '2024-11-01 10:00:00', 350.00, 'OPEN'),
(1, 1, '2024-11-01 14:00:00', 350.00, 'HOUSEFUL'),
(2, 2, '2024-11-01 12:00:00', 200.00, 'OPEN'),
(3, 3, '2024-11-01 18:00:00', 250.00, 'OPEN'),
(4, 4, '2024-11-01 20:00:00', 300.00, 'OPEN'),
(1, 5, '2024-11-01 09:30:00', 400.00, 'OPEN');

-- SEATS  (sample seats for screen 1)
INSERT INTO seats (screen_id, row_label, seat_number, category, price_multiplier) VALUES
(1,'A',1,'SILVER',1.00),(1,'A',2,'SILVER',1.00),(1,'A',3,'SILVER',1.00),
(1,'B',1,'GOLD',  1.25),(1,'B',2,'GOLD',  1.25),(1,'B',3,'GOLD',  1.25),
(1,'C',1,'PLATINUM',1.50),(1,'C',2,'PLATINUM',1.50),(1,'C',3,'PLATINUM',1.50),
-- seats for screen 2
(2,'A',1,'SILVER',1.00),(2,'A',2,'SILVER',1.00),
(2,'B',1,'GOLD',  1.20),(2,'B',2,'GOLD',  1.20);

-- OFFERS
INSERT INTO offers (offer_code, description, discount_pct, valid_from, valid_to) VALUES
('HDFC10',   'HDFC Bank 10% off',    10.00, '2024-01-01', '2024-12-31'),
('NEWUSER20','New user 20% off',     20.00, '2024-01-01', '2024-12-31'),
('PAYTM15',  'Paytm wallet 15% off', 15.00, '2024-10-01', '2024-11-30');

-- BOOKINGS
INSERT INTO bookings (user_id, show_id, total_amount, booking_status, payment_status) VALUES
(1, 1, 1050.00, 'CONFIRMED', 'PAID'),    -- Aarav: 3 seats show 1
(2, 3,  400.00, 'CONFIRMED', 'PAID'),    -- Priya: 2 seats show 3
(3, 4,  500.00, 'CONFIRMED', 'PAID'),    -- Rohan: 2 seats show 4
(4, 1,  437.50, 'CONFIRMED', 'PAID'),    -- Sneha: 1 gold seat show 1
(5, 6,  800.00, 'CANCELLED', 'REFUNDED');-- Vikram: cancelled

-- BOOKING_SEATS
INSERT INTO booking_seats (booking_id, seat_id, seat_price) VALUES
(1, 1, 350.00),(1, 2, 350.00),(1, 4, 437.50), -- booking 1
(2,10, 200.00),(2,11, 200.00),                 -- booking 2
(3, 9, 250.00),(3, 6, 312.50),                 -- booking 3
(4, 4, 437.50);                                -- booking 4

-- PAYMENTS
INSERT INTO payments (booking_id, amount, payment_method, transaction_id, status) VALUES
(1, 1050.00, 'CARD',        'TXN-BMS-00001', 'SUCCESS'),
(2,  400.00, 'UPI',         'TXN-BMS-00002', 'SUCCESS'),
(3,  500.00, 'NET_BANKING', 'TXN-BMS-00003', 'SUCCESS'),
(4,  437.50, 'WALLET',      'TXN-BMS-00004', 'SUCCESS'),
(5,  800.00, 'CARD',        'TXN-BMS-00005', 'REFUNDED');

-- BOOKING_OFFERS
INSERT INTO booking_offers (booking_id, offer_id, discount_applied) VALUES
(1, 1,  105.00),  -- HDFC10 on booking 1
(2, 2,   80.00),  -- NEWUSER20 on booking 2
(3, 3,   75.00);  -- PAYTM15 on booking 3

SELECT * FROM booked_seats_view;  -- remove double booking problem

-- payment failure handling via transaction block
START TRANSACTION;

INSERT INTO bookings (user_id, show_id, total_amount)
VALUES (1, 1, 500);

-- Simulate failure
ROLLBACK;

--  show cancellation
UPDATE shows
SET status = 'CANCELLED'
WHERE show_id = 1;

-- dublicate payment prevention - demo

-- concurrency issue
START TRANSACTION;
SELECT * FROM seats WHERE seat_id = 1;

-- ============================================================
--  SAMPLE QUERIES
-- ============================================================

-- Q1: All available shows for a movie in a city
SELECT s.show_id, v.venue_name, sc.screen_name, sc.screen_type,
       s.show_time, s.base_price, s.status
FROM   shows s
JOIN   screens sc ON sc.screen_id = s.screen_id
JOIN   venues  v  ON v.venue_id   = sc.venue_id
JOIN   cities  c  ON c.city_id    = v.city_id
WHERE  s.movie_id = 1
  AND  c.city_id  = 1
  AND  s.status   = 'OPEN'
ORDER  BY s.show_time;

-- Q2: Seats already booked for a show
SELECT se.row_label, se.seat_number, se.category
FROM   booking_seats bs
JOIN   bookings b  ON b.booking_id = bs.booking_id
JOIN   seats    se ON se.seat_id   = bs.seat_id
WHERE  b.show_id = 1
  AND  b.booking_status = 'CONFIRMED';

-- Q3: Full booking summary with user and payment details
SELECT bk.booking_id, u.name AS customer, m.title AS movie,
       s.show_time, v.venue_name, bk.total_amount,
       p.payment_method, p.status AS payment_status
FROM   bookings bk
JOIN   users    u  ON u.user_id   = bk.user_id
JOIN   shows    s  ON s.show_id   = bk.show_id
JOIN   movies   m  ON m.movie_id  = s.movie_id
JOIN   screens  sc ON sc.screen_id= s.screen_id
JOIN   venues   v  ON v.venue_id  = sc.venue_id
JOIN   payments p  ON p.booking_id= bk.booking_id
ORDER  BY bk.booked_at DESC;

-- Q4: Revenue per movie (confirmed bookings only)
SELECT m.title, COUNT(bk.booking_id) AS total_bookings,
       SUM(bk.total_amount) AS total_revenue
FROM   bookings bk
JOIN   shows  s ON s.show_id   = bk.show_id
JOIN   movies m ON m.movie_id  = s.movie_id
WHERE  bk.booking_status = 'CONFIRMED'
GROUP  BY m.movie_id, m.title
ORDER  BY total_revenue DESC;

-- Q5: Offers redeemed and total discount given
SELECT o.offer_code, COUNT(bo.id) AS times_used,
       SUM(bo.discount_applied) AS total_discount
FROM   booking_offers bo
JOIN   offers o ON o.offer_id = bo.offer_id
GROUP  BY o.offer_id, o.offer_code;

