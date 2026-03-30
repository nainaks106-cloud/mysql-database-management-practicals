🎬 BookMyShow Database Design & Architecture

A production-grade relational database design inspired by platforms like BookMyShow, built using MySQL 8.0+.

This project demonstrates how large-scale ticket booking systems manage users, movies, shows, seats, bookings, payments, and offers with strong data integrity and optimized performance.

📌 Project Overview

This repository contains:

📂 Complete MySQL schema (12 tables)
🔗 Foreign key relationships & constraints
⚡ Optimized indexing strategy
🧪 Dummy data for testing
📊 Sample analytical SQL queries
📄 Detailed case study report (PDF/Doc)
🧠 Key Features

✔️ Fully normalized database (3NF)
✔️ Real-world ticket booking workflow modeling
✔️ Seat-level booking system with price calculation
✔️ Offer & discount system (coupon codes)
✔️ Payment integration structure
✔️ Soft delete strategy (CANCELLED / REFUNDED states)
✔️ Designed for scalability & performance

🏗️ Database Schema

The system consists of 12 tables grouped into 3 domains:

📍 Location Domain
cities
venues
🎥 Content Domain
movies
screens
shows
seats
💳 Transaction Domain
users
bookings
booking_seats
payments
offers
booking_offers
🔗 Entity Relationships
One city → many venues
One venue → many screens
One screen → many shows & seats
One movie → many shows
One user → many bookings
One booking → multiple seats (M:N via booking_seats)
One booking → one payment (1:1)
Many bookings ↔ offers (M:N)
⚙️ Tech Stack
Database: MySQL 8.0+
Concepts Used:
Relational Modeling
Normalization (1NF, 2NF, 3NF)
Indexing
Foreign Key Constraints
Transaction Handling
🚀 Getting Started
1️⃣ Clone the repository
git clone https://github.com/your-username/bookmyshow-db.git
cd bookmyshow-db
2️⃣ Run the SQL file
mysql -u root -p < bookmyshow_database.sql
3️⃣ Verify tables
SHOW TABLES;
📊 Sample Queries
🎟️ Get all shows for a movie in a city
SELECT s.show_id, v.venue_name, s.show_time
FROM shows s
JOIN screens sc ON sc.screen_id = s.screen_id
JOIN venues v ON v.venue_id = sc.venue_id
WHERE s.movie_id = 1 AND v.city_id = 1;
💺 Get booked seats
SELECT se.row_label, se.seat_number
FROM booking_seats bs
JOIN bookings b ON b.booking_id = bs.booking_id
JOIN seats se ON se.seat_id = bs.seat_id
WHERE b.show_id = 1;
💰 Revenue per movie
SELECT m.title, SUM(b.total_amount) AS revenue
FROM bookings b
JOIN shows s ON s.show_id = b.show_id
JOIN movies m ON m.movie_id = s.movie_id
GROUP BY m.title;
🔄 Core Workflows
🎟️ Booking Flow
Search movie by city
Select show
Choose seats
Apply offer
Make payment
Booking confirmed
❌ Cancellation Flow
Cancel booking
Check refund eligibility
Update payment status
Seats become available
📈 Indexing Strategy
Index	Purpose
idx_shows_movie	Fast movie-based search
idx_shows_time	Time filtering
idx_bookings_user	User booking history
idx_bs_seat	Seat availability check
idx_payments_txn	Payment lookup
⚖️ Design Decisions
💾 Stored total_amount → avoids recalculation
🧾 Seat price stored per booking → ensures financial accuracy
🔁 Soft deletes → maintain audit trail
🔗 Bridge tables → handle many-to-many relationships
🔒 Unique constraints → prevent duplicate bookings & scheduling
📁 Project Structure
📦 bookmyshow-db
 ┣ 📜 bookmyshow_database.sql
 ┣ 📄 BookMyShow_Case_Study_Report.pdf
 ┗ 📄 README.md
🎯 Learning Outcomes
Real-world DB design for scalable systems
Handling complex relationships (M:N)
Writing optimized SQL queries
Applying normalization + performance trade-offs
Understanding backend architecture for booking systems
🙌 Author

Naina Yadav
📌 Database Design Project

⭐ Support

If you found this project helpful:

⭐ Star this repo
🍴 Fork it
📢 Share with others
