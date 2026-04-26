# 🎬 BookMyShow Database Design & Architecture

A production-grade relational database design inspired by real-world ticketing systems.  
Built using **MySQL 8.0+**, this project demonstrates how platforms handle bookings, seats, payments, and offers efficiently.

---

## 📌 Project Overview

This repository contains:

- Complete **MySQL schema (12 tables)**
- Well-defined **foreign key relationships**
- Optimized **indexing strategy**
- **Dummy data** for testing
- **Real-world SQL queries**
- Detailed **case study report**

---

## 🧠 Key Features

- ✅ Fully normalized database (**3NF**)
- 🎟️ Seat-level booking system
- 💳 Payment integration structure
- 🎁 Offer & discount system
- 🔄 Cancellation & refund workflow
- ⚡ Optimized for performance using indexes
- 🧾 Maintains audit history using status fields

---

## 🏗️ Database Schema

The system is divided into 3 domains:

### 📍 Location
- `cities`
- `venues`

### 🎥 Content
- `movies`
- `screens`
- `shows`
- `seats`

### 💳 Transactions
- `users`
- `bookings`
- `booking_seats`
- `payments`
- `offers`
- `booking_offers`

---

## 🔗 Entity Relationships

- One **city → many venues**
- One **venue → many screens**
- One **screen → many shows & seats**
- One **movie → many shows**
- One **user → many bookings**
- One **booking → multiple seats (M:N)**
- One **booking → one payment (1:1)**
- Many **bookings ↔ offers (M:N)**

---

## ⚙️ Tech Stack

- **Database:** MySQL 8.0+
- **Concepts Used:**
  - Relational Database Design
  - Normalization (1NF, 2NF, 3NF)
  - Indexing
  - Foreign Key Constraints

---

## 🚀 Getting Started

### 1. Clone the Repository
```bash
git clone https://github.com/your-username/bookmyshow-db.git
cd bookmyshow-db

### 2. Run the SQL Script
mysql -u root -p < bookmyshow_database.sql

### 3. Verify Tables
SHOW TABLES;

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
Process refund
Update booking & payment status


📈 Indexing Strategy
Index	Purpose
idx_shows_movie	Fast search by movie
idx_shows_time	Filter by time
idx_bookings_user	User booking history
idx_bs_seat	Seat availability check
idx_payments_txn	Payment lookup

⚖️ Design Decisions
💾 Stored total_amount for performance
💰 Stored seat_price for historical accuracy
🔄 Used status fields instead of deletes (audit trail)
🔗 Bridge tables for many-to-many relationships
🔒 Unique constraints to prevent duplicates
📁 Project Structure

bookmyshow-db/
│── bookmyshow_database.sql
│── BookMyShow_Case_Study_Report.pdf
│── README.md


🎯 Learning Outcomes
Real-world database design
Handling complex relationships
Writing optimized SQL queries
Understanding system workflows
Applying normalization techniques


🙌 Author

Naina Yadav
Database Design Project
