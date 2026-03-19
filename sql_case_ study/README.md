# 📊 Database Design Case Studies

This project contains the design and implementation of three real-world database systems using SQL:

* 🎓 University Database
* 🏥 Hospital Management System
* 🛒 E-Commerce Platform

Each case study demonstrates core concepts of Database Management Systems (DBMS), including entity-relationship modeling, normalization, and relational schema design.

---

## 🚀 Project Overview

The goal of this project is to understand how real-world systems are translated into structured databases. It includes:

* Entity identification
* Relationship mapping (1:1, 1:N, M:N)
* Implementation using SQL
* Reverse engineering to generate ER diagrams

---

## 🧩 Case Studies Included

### 1️⃣ University Database

* Manages students, courses, instructors, and departments
* Includes:

  * Weak entities (Section)
  * Multivalued attributes (Email, Phone)
  * Many-to-Many relationship (Enrollment)

---

### 2️⃣ Hospital Database

* Handles patient records, doctors, wards, and treatments
* Includes:

  * Weak entity (Emergency Contact)
  * Multivalued attribute (Nurse Shift)
  * Complex relationships (Treatment, Prescription, Admission)

---

### 3️⃣ E-Commerce Database

* Simulates an online shopping platform
* Includes:

  * Self-referencing table (Category)
  * M:N relationships (Vendor-Product, Order Items)
  * Weak entities (Address, Order Items)
  * Constraints (UNIQUE, CHECK)

---

## 🛠️ Technologies Used

* MySQL
* SQL (DDL, DML)
* MySQL Workbench (for ER Diagrams)

---

## 🔄 Reverse Engineering (ER Diagram)

Reverse engineering was performed using MySQL Workbench to convert SQL tables into EER (Enhanced Entity Relationship) diagrams.

Steps followed:

1. Create database and tables using SQL scripts
2. Use **Database → Reverse Engineer** in MySQL Workbench
3. Select schema and generate EER diagram
4. Export diagram as PDF

The attached PDF contains:

* Entities (tables)
* Attributes (columns)
* Relationships (foreign keys)
* Cardinality and constraints

---


## 📚 Key Concepts Demonstrated

* Primary Keys & Foreign Keys
* Normalization
* Weak Entities
* Multivalued Attributes
* Many-to-Many Relationships
* Data Integrity Constraints

---

## 🎯 Learning Outcome

This project helped in:

* Understanding real-world database design
* Implementing structured schemas
* Visualizing relationships using ER diagrams
* Improving SQL and analytical skills

---

## 📌 Conclusion

This project showcases how different domains (education, healthcare, and e-commerce) require different database structures while following the same fundamental DBMS principles.
