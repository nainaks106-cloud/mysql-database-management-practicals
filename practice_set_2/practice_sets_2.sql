-- practice set 2

-- CREATE DATABASE
CREATE DATABASE BookstoreDB;
USE BookstoreDB;

-- TABLES
CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY,
    Name VARCHAR(50),
    Country VARCHAR(50),
    DOB DATE
);

CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50)
);

CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(100),
    AuthorID INT,
    CategoryID INT,
    Price DECIMAL(10,2),
    Stock INT,
    PublishedYear INT,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(50),
    Email VARCHAR(50),
    Phone VARCHAR(15),
    Address VARCHAR(100)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    Status VARCHAR(20),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- INSERT DATA

INSERT INTO Authors VALUES
(1,'Chetan Bhagat','India','1974-04-22'),
(2,'J.K Rowling','UK','1965-07-31'),
(3,'Dan Brown','USA','1964-06-22'),
(4,'Ruskin Bond','India','1934-05-19'),
(5,'Paulo Coelho','Brazil','1947-08-24');

INSERT INTO Categories VALUES
(1,'Fiction'),
(2,'Mystery'),
(3,'Romance'),
(4,'Self Help'),
(5,'Education');

INSERT INTO Books VALUES
(1,'Half Girlfriend',1,3,450,20,2016),
(2,'Harry Potter',2,1,800,15,2005),
(3,'Da Vinci Code',3,2,600,8,2003),
(4,'The Alchemist',5,4,550,5,1998),
(5,'Guide to SQL',4,5,300,12,2018);

INSERT INTO Customers VALUES
(1,'Amit','amit@gmail.com','9876543210','Mumbai'),
(2,'Riya','riya@gmail.com','9123456789','Delhi'),
(3,'Rahul','rahul@gmail.com','9988776655','Pune'),
(4,'Sneha','sneha@gmail.com','9090909090','Mumbai'),
(5,'Arjun','arjun@gmail.com','9898989898','Delhi');

INSERT INTO Orders VALUES
(1,1,CURDATE(),'Completed'),
(2,2,CURDATE(),'Pending'),
(3,1,CURDATE(),'Completed'),
(4,3,CURDATE(),'Pending'),
(5,4,CURDATE(),'Completed');

-- QUERIES

-- 1
SELECT * FROM Books WHERE Price > 500;

-- 2
SELECT * FROM Books WHERE PublishedYear > 2015;

-- 3
SELECT * FROM Customers WHERE Address='Mumbai';

-- 4
SELECT B.* FROM Books B
JOIN Authors A ON B.AuthorID=A.AuthorID
WHERE A.Name='Chetan Bhagat';

-- 5
SELECT * FROM Books ORDER BY Price DESC LIMIT 3;

-- 6
SELECT CategoryID, COUNT(*) FROM Books GROUP BY CategoryID;

-- 7
SELECT * FROM Orders WHERE OrderDate >= CURDATE() - INTERVAL 30 DAY;

-- 8
SELECT C.Name, COUNT(O.OrderID)
FROM Customers C
LEFT JOIN Orders O ON C.CustomerID=O.CustomerID
GROUP BY C.Name;

-- 9
SELECT * FROM Books WHERE Stock < 10;

-- 10
SELECT AuthorID, COUNT(*) FROM Books GROUP BY AuthorID HAVING COUNT(*) > 1;

-- 11
SELECT B.Title, C.CategoryName
FROM Books B
JOIN Categories C ON B.CategoryID=C.CategoryID;

-- 12 (dummy total since no order items table)
SELECT OrderID, COUNT(*) * 500 AS TotalAmount
FROM Orders
GROUP BY OrderID;

-- 13
SELECT * FROM Orders WHERE Status='Pending';

-- 14
SELECT * FROM Authors WHERE Country='India';

-- 15
SELECT * FROM Customers
WHERE CustomerID NOT IN (SELECT CustomerID FROM Orders);

-- 16
SELECT CategoryID, AVG(Price) FROM Books GROUP BY CategoryID;

-- 17
SELECT * FROM Books ORDER BY PublishedYear DESC;

-- 18
SELECT CustomerID, MAX(OrderDate)
FROM Orders
GROUP BY CustomerID;

-- 19
SELECT * FROM Categories
WHERE CategoryID NOT IN (SELECT CategoryID FROM Books);

-- 20
SELECT DISTINCT Address FROM Customers;

-- 21
SELECT COUNT(*) FROM Customers;

-- 22
SELECT O.OrderID, C.Name, O.OrderDate
FROM Orders O
JOIN Customers C ON O.CustomerID=C.CustomerID;

-- 23
SELECT CategoryID, MIN(Price)
FROM Books
GROUP BY CategoryID;

-- 24
SELECT DISTINCT C.*
FROM Customers C
JOIN Orders O ON C.CustomerID=O.CustomerID
JOIN Books B ON B.AuthorID=1;

-- 25
SELECT * FROM Books WHERE Title LIKE '%Guide%';

-- ==============================
-- CREATE DATABASE
-- ==============================
CREATE DATABASE HospitalDB;
USE HospitalDB;

-- ==============================
-- TABLES
-- ==============================

-- Doctors Table
CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY,        -- Unique doctor ID
    Name VARCHAR(50),
    Specialization VARCHAR(50),
    Phone VARCHAR(15),
    JoiningDate DATE
);

-- Patients Table
CREATE TABLE Patients (
    PatientID INT PRIMARY KEY,       -- Unique patient ID
    Name VARCHAR(50),
    DOB DATE,
    Gender VARCHAR(10),
    Phone VARCHAR(15)
);

-- Departments Table
CREATE TABLE Departments (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50),
    Location VARCHAR(50)
);

-- Appointments Table
CREATE TABLE Appointments (
    AppointmentID INT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    Date DATE,
    Time TIME,
    Status VARCHAR(20),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- Bills Table
CREATE TABLE Bills (
    BillID INT PRIMARY KEY,
    PatientID INT,
    Amount DECIMAL(10,2),
    BillDate DATE,
    PaymentStatus VARCHAR(20),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

-- ==============================
-- INSERT DUMMY DATA
-- ==============================

INSERT INTO Doctors VALUES
(1,'Dr. Sharma','Cardiology','9811111111','2021-05-10'),
(2,'Dr. Mehta','Neurology','9822222222','2019-03-15'),
(3,'Dr. Khan','Orthopedic','9833333333','2022-07-20'),
(4,'Dr. Roy','Cardiology','9844444444','2023-01-10'),
(5,'Dr. Singh','Dermatology','9855555555','2018-11-05');

INSERT INTO Patients VALUES
(1,'Amit','1955-06-10','Male','9876543210'),
(2,'Riya','1995-03-12','Female','9123456789'),
(3,'Arjun','1960-08-22','Male','9988776655'),
(4,'Sneha','2001-01-01','Female','9090909090'),
(5,'Ankit','1980-09-09','Male','9898989898');

INSERT INTO Departments VALUES
(1,'Cardiology','Block A'),
(2,'Neurology','Block B'),
(3,'Orthopedic','Block C'),
(4,'Dermatology','Block D'),
(5,'General','Block E');

INSERT INTO Appointments VALUES
(1,1,1,CURDATE(),'10:00:00','Completed'),
(2,2,2,CURDATE(),'11:00:00','Cancelled'),
(3,3,1,CURDATE(),'12:00:00','Completed'),
(4,1,2,CURDATE(),'01:00:00','Pending'),
(5,4,3,CURDATE(),'02:00:00','Completed');

INSERT INTO Bills VALUES
(1,1,6000,CURDATE(),'Paid'),
(2,2,3000,CURDATE(),'Unpaid'),
(3,3,8000,CURDATE(),'Paid'),
(4,4,2000,CURDATE(),'Unpaid'),
(5,1,7000,CURDATE(),'Paid');

-- ==============================
-- QUERIES (25)
-- ==============================

-- 1. Doctors with Cardiology specialization
SELECT * FROM Doctors WHERE Specialization='Cardiology';

-- 2. Patients above 60 years
SELECT * FROM Patients WHERE TIMESTAMPDIFF(YEAR,DOB,CURDATE()) > 60;

-- 3. Appointments today
SELECT * FROM Appointments WHERE Date = CURDATE();

-- 4. Total patients per department (assumed mapping via doctors)
SELECT D.DeptName, COUNT(A.PatientID)
FROM Departments D
JOIN Doctors Doc ON D.DeptName = Doc.Specialization
JOIN Appointments A ON Doc.DoctorID = A.DoctorID
GROUP BY D.DeptName;

-- 5. Patients assigned to a specific doctor
SELECT P.* FROM Patients P
JOIN Appointments A ON P.PatientID=A.PatientID
WHERE A.DoctorID=1;

-- 6. Bills greater than 5000
SELECT * FROM Bills WHERE Amount > 5000;

-- 7. Unpaid bills
SELECT * FROM Bills WHERE PaymentStatus='Unpaid';

-- 8. Doctor with maximum appointments
SELECT DoctorID, COUNT(*) AS Total
FROM Appointments
GROUP BY DoctorID
ORDER BY Total DESC
LIMIT 1;

-- 9. Patients without appointments
SELECT * FROM Patients
WHERE PatientID NOT IN (SELECT PatientID FROM Appointments);

-- 10. Oldest patient
SELECT * FROM Patients ORDER BY DOB LIMIT 1;

-- 11. Average bill amount per department (approx logic)
SELECT AVG(Amount) FROM Bills;

-- 12. Doctors joined after 2020
SELECT * FROM Doctors WHERE JoiningDate > '2020-01-01';

-- 13. Patients starting with 'A'
SELECT * FROM Patients WHERE Name LIKE 'A%';

-- 14. Cancelled appointments
SELECT * FROM Appointments WHERE Status='Cancelled';

-- 15. Count appointments per day
SELECT Date, COUNT(*) FROM Appointments GROUP BY Date;

-- 16. Patients visited more than 3 times
SELECT PatientID, COUNT(*) 
FROM Appointments
GROUP BY PatientID
HAVING COUNT(*) > 3;

-- 17. Department with doctors
SELECT D.DeptName, Doc.Name
FROM Departments D
LEFT JOIN Doctors Doc ON D.DeptName = Doc.Specialization;

-- 18. Doctors in Neurology
SELECT * FROM Doctors WHERE Specialization='Neurology';

-- 19. Total bills per patient
SELECT PatientID, SUM(Amount)
FROM Bills
GROUP BY PatientID;

-- 20. Top 5 highest billing patients
SELECT PatientID, SUM(Amount) AS Total
FROM Bills
GROUP BY PatientID
ORDER BY Total DESC
LIMIT 5;

-- 21. Appointments with doctor and patient names
SELECT A.AppointmentID, P.Name, D.Name
FROM Appointments A
JOIN Patients P ON A.PatientID=P.PatientID
JOIN Doctors D ON A.DoctorID=D.DoctorID;

-- 22. Departments without doctors
SELECT * FROM Departments
WHERE DeptName NOT IN (SELECT Specialization FROM Doctors);

-- 23. Doctors with phone starting '98'
SELECT * FROM Doctors WHERE Phone LIKE '98%';

-- 24. Patients admitted in last 7 days (using appointments)
SELECT * FROM Patients
WHERE PatientID IN (
    SELECT PatientID FROM Appointments
    WHERE Date >= CURDATE() - INTERVAL 7 DAY
);

-- 25. Doctors and total billing amount
SELECT D.Name, SUM(B.Amount)
FROM Doctors D
JOIN Appointments A ON D.DoctorID=A.DoctorID
JOIN Bills B ON A.PatientID=B.PatientID
GROUP BY D.Name;

-- ==============================
-- CREATE DATABASE
-- ==============================
CREATE DATABASE UniversityDB;
USE UniversityDB;

-- ==============================
-- TABLES
-- ==============================

-- Departments Table
CREATE TABLE Departments (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50),
    HOD VARCHAR(50)
);

-- Students Table
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50),
    DOB DATE,
    Gender VARCHAR(10),
    DeptID INT,
    Email VARCHAR(50),
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);

-- Courses Table
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(50),
    DeptID INT,
    Credits INT,
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);

-- Faculty Table
CREATE TABLE Faculty (
    FacultyID INT PRIMARY KEY,
    Name VARCHAR(50),
    DeptID INT,
    Email VARCHAR(50),
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);

-- Enrollments Table
CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    Semester VARCHAR(20),
    Grade DECIMAL(5,2),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- ==============================
-- INSERT DUMMY DATA
-- ==============================

INSERT INTO Departments VALUES
(1,'Computer Science','Dr. Rao'),
(2,'Physics','Dr. Sharma'),
(3,'Mathematics','Dr. Mehta'),
(4,'Commerce','Dr. Singh'),
(5,'Biology','Dr. Khan');

INSERT INTO Students VALUES
(1,'Amit','2002-05-10','Male',1,'amit@gmail.com'),
(2,'Riya','1999-03-12','Female',2,'riya@gmail.com'),
(3,'Suresh','2001-08-22','Male',3,'suresh@gmail.com'),
(4,'Sneha','2003-01-01','Female',1,'sneha@gmail.com'),
(5,'Sam','1998-09-09','Male',4,'sam@gmail.com');

INSERT INTO Courses VALUES
(1,'DBMS',1,4),
(2,'Physics I',2,3),
(3,'Mathematics',3,5),
(4,'Accounts',4,3),
(5,'Biology Basics',5,4);

INSERT INTO Faculty VALUES
(1,'Prof. A',1,'a@uni.com'),
(2,'Prof. B',2,'b@uni.com'),
(3,'Prof. C',3,'c@uni.com'),
(4,'Prof. D',4,'d@uni.com'),
(5,'Prof. E',5,'e@uni.com');

INSERT INTO Enrollments VALUES
(1,1,1,'Sem1',8.5),
(2,1,3,'Sem1',7.5),
(3,2,2,'Sem1',6.0),
(4,3,3,'Sem1',9.0),
(5,4,1,'Sem1',8.0),
(6,4,2,'Sem1',7.0),
(7,5,4,'Sem1',5.5);

-- ==============================
-- QUERIES (25)
-- ==============================

-- 1. Students in Computer Science
SELECT S.* FROM Students S
JOIN Departments D ON S.DeptID=D.DeptID
WHERE D.DeptName='Computer Science';

-- 2. Courses with more than 3 credits
SELECT * FROM Courses WHERE Credits > 3;

-- 3. Students born after 2000
SELECT * FROM Students WHERE DOB > '2000-01-01';

-- 4. Average grade per course
SELECT CourseID, AVG(Grade)
FROM Enrollments
GROUP BY CourseID;

-- 5. Faculty in Physics department
SELECT F.* FROM Faculty F
JOIN Departments D ON F.DeptID=D.DeptID
WHERE D.DeptName='Physics';

-- 6. Total students per department
SELECT DeptID, COUNT(*) 
FROM Students
GROUP BY DeptID;

-- 7. Courses taught by a given faculty (assumed same dept)
SELECT C.* FROM Courses C
JOIN Faculty F ON C.DeptID=F.DeptID
WHERE F.FacultyID=1;

-- 8. Students with no enrollments
SELECT * FROM Students
WHERE StudentID NOT IN (SELECT StudentID FROM Enrollments);

-- 9. Top 3 scorers in a course
SELECT * FROM Enrollments
ORDER BY Grade DESC
LIMIT 3;

-- 10. Students enrolled in more than 4 courses
SELECT StudentID, COUNT(*) 
FROM Enrollments
GROUP BY StudentID
HAVING COUNT(*) > 4;

-- 11. Courses with no enrollments
SELECT * FROM Courses
WHERE CourseID NOT IN (SELECT CourseID FROM Enrollments);

-- 12. Department names with total faculty
SELECT D.DeptName, COUNT(F.FacultyID)
FROM Departments D
LEFT JOIN Faculty F ON D.DeptID=F.DeptID
GROUP BY D.DeptName;

-- 13. Courses taken by a specific student
SELECT C.* FROM Courses C
JOIN Enrollments E ON C.CourseID=E.CourseID
WHERE E.StudentID=1;

-- 14. Students starting with 'S'
SELECT * FROM Students WHERE Name LIKE 'S%';

-- 15. Youngest student
SELECT * FROM Students ORDER BY DOB DESC LIMIT 1;

-- 16. Students and average grade
SELECT StudentID, AVG(Grade)
FROM Enrollments
GROUP BY StudentID;

-- 17. Departments without students
SELECT * FROM Departments
WHERE DeptID NOT IN (SELECT DeptID FROM Students);

-- 18. Faculty emails
SELECT Email FROM Faculty;

-- 19. Students in Mathematics course
SELECT S.* FROM Students S
JOIN Enrollments E ON S.StudentID=E.StudentID
JOIN Courses C ON E.CourseID=C.CourseID
WHERE C.CourseName='Mathematics';

-- 20. Total credits per student
SELECT E.StudentID, SUM(C.Credits)
FROM Enrollments E
JOIN Courses C ON E.CourseID=C.CourseID
GROUP BY E.StudentID;

-- 21. Students with failing grades (<5)
SELECT * FROM Enrollments WHERE Grade < 5;

-- 22. Courses with maximum students
SELECT CourseID, COUNT(*) AS Total
FROM Enrollments
GROUP BY CourseID
ORDER BY Total DESC;

-- 23. Grade distribution per course
SELECT CourseID, Grade, COUNT(*)
FROM Enrollments
GROUP BY CourseID, Grade;

-- 24. Students with department names
SELECT S.Name, D.DeptName
FROM Students S
JOIN Departments D ON S.DeptID=D.DeptID;

-- 25. Oldest faculty member (assumed lowest ID oldest)
SELECT * FROM Faculty ORDER BY FacultyID LIMIT 1;

-- ==============================
-- CREATE DATABASE
-- ==============================
CREATE DATABASE AirlineDB;
USE AirlineDB;

-- ==============================
-- TABLES
-- ==============================

-- Airlines Table
CREATE TABLE Airlines (
    AirlineID INT PRIMARY KEY,
    AirlineName VARCHAR(50),
    Country VARCHAR(50)
);

-- Flights Table
CREATE TABLE Flights (
    FlightID INT PRIMARY KEY,
    AirlineID INT,
    Source VARCHAR(50),
    Destination VARCHAR(50),
    DepartureTime TIME,
    ArrivalTime TIME,
    Price DECIMAL(10,2),
    FOREIGN KEY (AirlineID) REFERENCES Airlines(AirlineID)
);

-- Passengers Table
CREATE TABLE Passengers (
    PassengerID INT PRIMARY KEY,
    Name VARCHAR(50),
    PassportNo VARCHAR(20),
    Nationality VARCHAR(50),
    DOB DATE
);

-- Bookings Table
CREATE TABLE Bookings (
    BookingID INT PRIMARY KEY,
    FlightID INT,
    PassengerID INT,
    BookingDate DATE,
    SeatNo VARCHAR(10),
    Status VARCHAR(20),
    FOREIGN KEY (FlightID) REFERENCES Flights(FlightID),
    FOREIGN KEY (PassengerID) REFERENCES Passengers(PassengerID)
);

-- Payments Table
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    BookingID INT,
    Amount DECIMAL(10,2),
    PaymentDate DATE,
    Method VARCHAR(20),
    FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID)
);

-- ==============================
-- INSERT DUMMY DATA
-- ==============================

INSERT INTO Airlines VALUES
(1,'Air India','India'),
(2,'Indigo','India'),
(3,'Emirates','UAE'),
(4,'Delta','USA'),
(5,'Lufthansa','Germany');

INSERT INTO Flights VALUES
(1,1,'Delhi','Mumbai','18:00:00','20:00:00',6000),
(2,2,'Delhi','Mumbai','10:00:00','12:00:00',5000),
(3,3,'Mumbai','Dubai','06:00:00','09:00:00',15000),
(4,4,'New York','LA','19:00:00','22:00:00',20000),
(5,5,'Berlin','Paris','08:00:00','10:00:00',8000);

INSERT INTO Passengers VALUES
(1,'Amit','M123','India','2000-01-01'),
(2,'Riya','N456','India','1995-03-12'),
(3,'John','M789','USA','1988-07-07'),
(4,'Sara','P111','UK','2002-05-05'),
(5,'Arjun','M222','India','2001-09-09');

INSERT INTO Bookings VALUES
(1,1,1,CURDATE(),'A1','Confirmed'),
(2,2,2,CURDATE(),'B2','Cancelled'),
(3,1,3,CURDATE(),'C3','Confirmed'),
(4,3,1,CURDATE(),'D4','Confirmed'),
(5,4,4,CURDATE(),'E5','Pending');

INSERT INTO Payments VALUES
(1,1,6000,CURDATE(),'Card'),
(2,2,5000,CURDATE(),'UPI'),
(3,3,6000,CURDATE(),'Card'),
(4,4,15000,CURDATE(),'NetBanking'),
(5,5,20000,CURDATE(),'Card');

-- ==============================
-- QUERIES (25)
-- ==============================

-- 1. Flights from Delhi to Mumbai
SELECT * FROM Flights WHERE Source='Delhi' AND Destination='Mumbai';

-- 2. Flights departing after 6 PM
SELECT * FROM Flights WHERE DepartureTime > '18:00:00';

-- 3. Passengers with nationality India
SELECT * FROM Passengers WHERE Nationality='India';

-- 4. Confirmed bookings
SELECT * FROM Bookings WHERE Status='Confirmed';

-- 5. Bookings for a given passenger
SELECT B.* FROM Bookings B
JOIN Passengers P ON B.PassengerID=P.PassengerID
WHERE P.Name='Amit';

-- 6. Flights per airline
SELECT AirlineID, COUNT(*) FROM Flights GROUP BY AirlineID;

-- 7. Passengers who booked more than 3 flights
SELECT PassengerID, COUNT(*)
FROM Bookings
GROUP BY PassengerID
HAVING COUNT(*) > 3;

-- 8. Most expensive flight
SELECT * FROM Flights ORDER BY Price DESC LIMIT 1;

-- 9. Airlines in USA
SELECT * FROM Airlines WHERE Country='USA';

-- 10. Bookings in last 7 days
SELECT * FROM Bookings
WHERE BookingDate >= CURDATE() - INTERVAL 7 DAY;

-- 11. Average price per airline
SELECT AirlineID, AVG(Price)
FROM Flights
GROUP BY AirlineID;

-- 12. Passengers without bookings
SELECT * FROM Passengers
WHERE PassengerID NOT IN (SELECT PassengerID FROM Bookings);

-- 13. Flights with no bookings
SELECT * FROM Flights
WHERE FlightID NOT IN (SELECT FlightID FROM Bookings);

-- 14. Passport starting with 'M'
SELECT * FROM Passengers WHERE PassportNo LIKE 'M%';

-- 15. Bookings with passenger & flight details
SELECT B.BookingID, P.Name, F.Source, F.Destination
FROM Bookings B
JOIN Passengers P ON B.PassengerID=P.PassengerID
JOIN Flights F ON B.FlightID=F.FlightID;

-- 16. Top 5 highest payments
SELECT * FROM Payments ORDER BY Amount DESC LIMIT 5;

-- 17. Passengers per flight
SELECT FlightID, COUNT(*) FROM Bookings GROUP BY FlightID;

-- 18. Flights arriving before 10 AM
SELECT * FROM Flights WHERE ArrivalTime < '10:00:00';

-- 19. Flights with airline names
SELECT F.FlightID, A.AirlineName
FROM Flights F
JOIN Airlines A ON F.AirlineID=A.AirlineID;

-- 20. Passengers with multiple bookings same date
SELECT PassengerID, BookingDate, COUNT(*)
FROM Bookings
GROUP BY PassengerID, BookingDate
HAVING COUNT(*) > 1;

-- 21. Payment methods with total amount
SELECT Method, SUM(Amount)
FROM Payments
GROUP BY Method;

-- 22. Passengers booked last month
SELECT DISTINCT PassengerID
FROM Bookings
WHERE BookingDate >= CURDATE() - INTERVAL 1 MONTH;

-- 23. Flights priced between 5000 and 10000
SELECT * FROM Flights WHERE Price BETWEEN 5000 AND 10000;

-- 24. Passengers born after 2000
SELECT * FROM Passengers WHERE DOB > '2000-01-01';

-- 25. Airlines with no flights
SELECT * FROM Airlines
WHERE AirlineID NOT IN (SELECT AirlineID FROM Flights);

-- ==============================
-- CREATE DATABASE
-- ==============================
CREATE DATABASE HotelDB;
USE HotelDB;

-- ==============================
-- TABLES
-- ==============================

-- Hotels Table
CREATE TABLE Hotels (
    HotelID INT PRIMARY KEY,
    HotelName VARCHAR(50),
    Location VARCHAR(50),
    Rating DECIMAL(2,1)
);

-- Rooms Table
CREATE TABLE Rooms (
    RoomID INT PRIMARY KEY,
    HotelID INT,
    RoomType VARCHAR(50),
    PricePerNight DECIMAL(10,2),
    Availability VARCHAR(20),
    FOREIGN KEY (HotelID) REFERENCES Hotels(HotelID)
);

-- Guests Table
CREATE TABLE Guests (
    GuestID INT PRIMARY KEY,
    Name VARCHAR(50),
    Phone VARCHAR(15),
    Email VARCHAR(50),
    Address VARCHAR(100)
);

-- Reservations Table
CREATE TABLE Reservations (
    ReservationID INT PRIMARY KEY,
    RoomID INT,
    GuestID INT,
    CheckInDate DATE,
    CheckOutDate DATE,
    Status VARCHAR(20),
    FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID),
    FOREIGN KEY (GuestID) REFERENCES Guests(GuestID)
);

-- Payments Table
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    ReservationID INT,
    Amount DECIMAL(10,2),
    PaymentDate DATE,
    Method VARCHAR(20),
    FOREIGN KEY (ReservationID) REFERENCES Reservations(ReservationID)
);

-- ==============================
-- INSERT DUMMY DATA
-- ==============================

INSERT INTO Hotels VALUES
(1,'Taj Hotel','Mumbai',4.8),
(2,'Oberoi','Delhi',4.5),
(3,'ITC Grand','Bangalore',4.6),
(4,'Leela Palace','Delhi',4.7),
(5,'Hyatt','Pune',4.3);

INSERT INTO Rooms VALUES
(1,1,'Suite',6000,'Available'),
(2,1,'Deluxe',4000,'Booked'),
(3,2,'Suite',7000,'Available'),
(4,3,'Standard',2500,'Available'),
(5,4,'Suite',8000,'Booked');

INSERT INTO Guests VALUES
(1,'Amit','9876543210','amit@gmail.com','Mumbai'),
(2,'Riya','9123456789','riya@gmail.com','Delhi'),
(3,'Rahul','9988776655','rahul@gmail.com','Pune'),
(4,'Sneha','9090909090','sneha@gmail.com','Mumbai'),
(5,'Arjun','9898989898','arjun@gmail.com','Delhi');

INSERT INTO Reservations VALUES
(1,1,1,CURDATE()-INTERVAL 5 DAY,CURDATE(),'Checked-In'),
(2,2,2,CURDATE()-INTERVAL 10 DAY,CURDATE()-INTERVAL 5 DAY,'Completed'),
(3,3,3,CURDATE()-INTERVAL 2 DAY,CURDATE()+INTERVAL 3 DAY,'Checked-In'),
(4,4,4,CURDATE()-INTERVAL 30 DAY,CURDATE()-INTERVAL 25 DAY,'Completed'),
(5,5,5,CURDATE(),CURDATE()+INTERVAL 2 DAY,'Checked-In');

INSERT INTO Payments VALUES
(1,1,30000,CURDATE(),'Card'),
(2,2,20000,CURDATE(),'UPI'),
(3,3,35000,CURDATE(),'NetBanking'),
(4,4,15000,CURDATE(),'Card'),
(5,5,25000,CURDATE(),'Card');

-- ==============================
-- QUERIES (25)
-- ==============================

-- 1. Hotels in Mumbai
SELECT * FROM Hotels WHERE Location='Mumbai';

-- 2. Rooms above 3000
SELECT * FROM Rooms WHERE PricePerNight > 3000;

-- 3. Available rooms in a hotel (HotelID = 1)
SELECT * FROM Rooms 
WHERE HotelID=1 AND Availability='Available';

-- 4. Guests with reservations in a specific hotel
SELECT DISTINCT G.*
FROM Guests G
JOIN Reservations R ON G.GuestID=R.GuestID
JOIN Rooms Ro ON R.RoomID=Ro.RoomID
WHERE Ro.HotelID=1;

-- 5. Checked-In reservations
SELECT * FROM Reservations WHERE Status='Checked-In';

-- 6. Count rooms by type per hotel
SELECT HotelID, RoomType, COUNT(*)
FROM Rooms
GROUP BY HotelID, RoomType;

-- 7. Guests stayed more than 5 nights
SELECT GuestID, DATEDIFF(CheckOutDate, CheckInDate) AS Nights
FROM Reservations
WHERE DATEDIFF(CheckOutDate, CheckInDate) > 5;

-- 8. Top 3 expensive room types
SELECT DISTINCT RoomType, PricePerNight
FROM Rooms
ORDER BY PricePerNight DESC
LIMIT 3;

-- 9. Reservations in last month
SELECT * FROM Reservations
WHERE CheckInDate >= CURDATE() - INTERVAL 1 MONTH;

-- 10. Guests with more than 2 reservations
SELECT GuestID, COUNT(*)
FROM Reservations
GROUP BY GuestID
HAVING COUNT(*) > 2;

-- 11. Hotels with avg room price > 4000
SELECT H.HotelName, AVG(R.PricePerNight)
FROM Hotels H
JOIN Rooms R ON H.HotelID=R.HotelID
GROUP BY H.HotelName
HAVING AVG(R.PricePerNight) > 4000;

-- 12. Guests from Mumbai
SELECT * FROM Guests WHERE Address='Mumbai';

-- 13. Hotels without reservations
SELECT * FROM Hotels
WHERE HotelID NOT IN (
    SELECT Ro.HotelID
    FROM Reservations R
    JOIN Rooms Ro ON R.RoomID=Ro.RoomID
);

-- 14. Reservation details with guest, hotel, room
SELECT R.ReservationID, G.Name, H.HotelName, Ro.RoomType
FROM Reservations R
JOIN Guests G ON R.GuestID=G.GuestID
JOIN Rooms Ro ON R.RoomID=Ro.RoomID
JOIN Hotels H ON Ro.HotelID=H.HotelID;

-- 15. Total revenue per hotel
SELECT H.HotelName, SUM(P.Amount)
FROM Payments P
JOIN Reservations R ON P.ReservationID=R.ReservationID
JOIN Rooms Ro ON R.RoomID=Ro.RoomID
JOIN Hotels H ON Ro.HotelID=H.HotelID
GROUP BY H.HotelName;

-- 16. Invalid reservations (checkout < checkin)
SELECT * FROM Reservations
WHERE CheckOutDate < CheckInDate;

-- 17. Payment methods used
SELECT DISTINCT Method FROM Payments;

-- 18. Guests with no payments
SELECT * FROM Guests
WHERE GuestID NOT IN (
    SELECT R.GuestID
    FROM Reservations R
    JOIN Payments P ON R.ReservationID=P.ReservationID
);

-- 19. Reservations sorted by check-in date
SELECT * FROM Reservations ORDER BY CheckInDate;

-- 20. Hotels rating above 4
SELECT * FROM Hotels WHERE Rating > 4;

-- 21. Guests who booked suites
SELECT DISTINCT G.*
FROM Guests G
JOIN Reservations R ON G.GuestID=R.GuestID
JOIN Rooms Ro ON R.RoomID=Ro.RoomID
WHERE Ro.RoomType='Suite';

-- 22. Available rooms in Delhi
SELECT Ro.*
FROM Rooms Ro
JOIN Hotels H ON Ro.HotelID=H.HotelID
WHERE H.Location='Delhi' AND Ro.Availability='Available';

-- 23. Total nights per guest
SELECT GuestID, SUM(DATEDIFF(CheckOutDate, CheckInDate))
FROM Reservations
GROUP BY GuestID;

-- 24. Overlapping reservations for same room
SELECT R1.RoomID, R1.ReservationID, R2.ReservationID
FROM Reservations R1, Reservations R2
WHERE R1.RoomID = R2.RoomID
AND R1.ReservationID <> R2.ReservationID
AND R1.CheckInDate < R2.CheckOutDate
AND R2.CheckInDate < R1.CheckOutDate;

-- 25. Distinct hotel cities
SELECT DISTINCT Location FROM Hotels;

-- ==============================
-- CREATE DATABASE
-- ==============================
CREATE DATABASE LibraryDB;
USE LibraryDB;

-- ==============================
-- TABLES
-- ==============================

-- Authors Table
CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY,
    Name VARCHAR(50),
    Nationality VARCHAR(50)
);

-- Books Table
CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(100),
    AuthorID INT,
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
);

-- Members Table
CREATE TABLE Members (
    MemberID INT PRIMARY KEY,
    Name VARCHAR(50),
    Email VARCHAR(50),
    Phone VARCHAR(15),
    Address VARCHAR(100)
);

-- Loans Table
CREATE TABLE Loans (
    LoanID INT PRIMARY KEY,
    BookID INT,
    MemberID INT,
    IssueDate DATE,
    ReturnDate DATE,
    Status VARCHAR(20),
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

-- Fines Table
CREATE TABLE Fines (
    FineID INT PRIMARY KEY,
    LoanID INT,
    Amount DECIMAL(10,2),
    PaymentStatus VARCHAR(20),
    FOREIGN KEY (LoanID) REFERENCES Loans(LoanID)
);

-- ==============================
-- INSERT DUMMY DATA
-- ==============================

INSERT INTO Authors VALUES
(1,'Chetan Bhagat','India'),
(2,'J.K Rowling','UK'),
(3,'Dan Brown','USA'),
(4,'Ruskin Bond','India'),
(5,'Paulo Coelho','Brazil');

INSERT INTO Books VALUES
(1,'Half Girlfriend',1,'Romance',450,3),
(2,'Harry Potter',2,'Fantasy',800,10),
(3,'Da Vinci Code',3,'Mystery',600,2),
(4,'The Alchemist',5,'Fiction',550,7),
(5,'History Guide',4,'Education',300,4);

INSERT INTO Members VALUES
(1,'Amit','amit@gmail.com','9876543210','Mumbai'),
(2,'Riya','riya@gmail.com','9123456789','Delhi'),
(3,'Rahul','rahul@gmail.com','9988776655','Pune'),
(4,'Sneha','sneha@gmail.com','9090909090','Mumbai'),
(5,'Arjun','arjun@gmail.com','9898989898','Delhi');

INSERT INTO Loans VALUES
(1,1,1,CURDATE()-INTERVAL 10 DAY,NULL,'Borrowed'),
(2,2,2,CURDATE()-INTERVAL 20 DAY,CURDATE()-INTERVAL 5 DAY,'Returned'),
(3,3,1,CURDATE()-INTERVAL 15 DAY,NULL,'Borrowed'),
(4,4,3,CURDATE()-INTERVAL 2 DAY,NULL,'Borrowed'),
(5,5,4,CURDATE()-INTERVAL 30 DAY,CURDATE()-INTERVAL 20 DAY,'Returned');

INSERT INTO Fines VALUES
(1,1,100,'Unpaid'),
(2,2,50,'Paid'),
(3,3,150,'Unpaid'),
(4,4,0,'Paid'),
(5,5,20,'Paid');

-- ==============================
-- QUERIES (25)
-- ==============================

-- 1. Books in Science Fiction
SELECT * FROM Books WHERE Category='Science Fiction';

-- 2. Books with stock < 5
SELECT * FROM Books WHERE Stock < 5;

-- 3. Members with overdue books (not returned)
SELECT * FROM Members
WHERE MemberID IN (
    SELECT MemberID FROM Loans WHERE Status='Borrowed'
);

-- 4. Top 3 expensive books
SELECT * FROM Books ORDER BY Price DESC LIMIT 3;

-- 5. Authors from India
SELECT * FROM Authors WHERE Nationality='India';

-- 6. Books by given author (AuthorID=1)
SELECT * FROM Books WHERE AuthorID=1;

-- 7. Count books per category
SELECT Category, COUNT(*) FROM Books GROUP BY Category;

-- 8. Members borrowed more than 5 books
SELECT MemberID, COUNT(*)
FROM Loans
GROUP BY MemberID
HAVING COUNT(*) > 5;

-- 9. Returned loans
SELECT * FROM Loans WHERE Status='Returned';

-- 10. Members who never borrowed
SELECT * FROM Members
WHERE MemberID NOT IN (SELECT MemberID FROM Loans);

-- 11. Unpaid fines
SELECT * FROM Fines WHERE PaymentStatus='Unpaid';

-- 12. Total fines paid per member
SELECT L.MemberID, SUM(F.Amount)
FROM Loans L
JOIN Fines F ON L.LoanID=F.LoanID
WHERE F.PaymentStatus='Paid'
GROUP BY L.MemberID;

-- 13. Books issued last month
SELECT * FROM Loans
WHERE IssueDate >= CURDATE() - INTERVAL 1 MONTH;

-- 14. Members who borrowed books in a category (e.g., Fiction)
SELECT DISTINCT M.*
FROM Members M
JOIN Loans L ON M.MemberID=L.MemberID
JOIN Books B ON L.BookID=B.BookID
WHERE B.Category='Fiction';

-- 15. Authors with more than 3 books
SELECT AuthorID, COUNT(*)
FROM Books
GROUP BY AuthorID
HAVING COUNT(*) > 3;

-- 16. Books priced between 200 and 500
SELECT * FROM Books WHERE Price BETWEEN 200 AND 500;

-- 17. Average fine amount
SELECT AVG(Amount) FROM Fines;

-- 18. Members with phone starting '9'
SELECT * FROM Members WHERE Phone LIKE '9%';

-- 19. Loans with book & member details
SELECT L.LoanID, B.Title, M.Name
FROM Loans L
JOIN Books B ON L.BookID=B.BookID
JOIN Members M ON L.MemberID=M.MemberID;

-- 20. Books with 'History' in title
SELECT * FROM Books WHERE Title LIKE '%History%';

-- 21. Members with more than one unpaid fine
SELECT L.MemberID, COUNT(*)
FROM Loans L
JOIN Fines F ON L.LoanID=F.LoanID
WHERE F.PaymentStatus='Unpaid'
GROUP BY L.MemberID
HAVING COUNT(*) > 1;

-- 22. Books with no loans
SELECT * FROM Books
WHERE BookID NOT IN (SELECT BookID FROM Loans);

-- 23. Most borrowed book
SELECT BookID, COUNT(*) AS Total
FROM Loans
GROUP BY BookID
ORDER BY Total DESC
LIMIT 1;

-- 24. Top 5 members by borrowings
SELECT MemberID, COUNT(*) AS Total
FROM Loans
GROUP BY MemberID
ORDER BY Total DESC
LIMIT 5;

-- 25. All book categories
SELECT DISTINCT Category FROM Books;

-- ==============================
-- CREATE DATABASE
-- ==============================
CREATE DATABASE InventoryDB;
USE InventoryDB;

-- ==============================
-- TABLES
-- ==============================

-- Categories Table
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50)
);

-- Suppliers Table
CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY,
    SupplierName VARCHAR(50),
    Contact VARCHAR(50),
    City VARCHAR(50)
);

-- Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    CategoryID INT,
    SupplierID INT,
    Price DECIMAL(10,2),
    Stock INT,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

-- Purchases Table
CREATE TABLE Purchases (
    PurchaseID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT,
    PurchaseDate DATE,
    SupplierID INT,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

-- Sales Table
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT,
    SaleDate DATE,
    CustomerName VARCHAR(50),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- ==============================
-- INSERT DUMMY DATA
-- ==============================

INSERT INTO Categories VALUES
(1,'Electronics'),
(2,'Clothing'),
(3,'Groceries'),
(4,'Furniture'),
(5,'Stationery');

INSERT INTO Suppliers VALUES
(1,'ABC Traders','abc@gmail.com','Delhi'),
(2,'XYZ Supplies','xyz@gmail.com','Mumbai'),
(3,'Global Mart','global@gmail.com','Pune'),
(4,'Prime Goods','prime@gmail.com','Delhi'),
(5,'Urban Supply','urban@gmail.com','Bangalore');

INSERT INTO Products VALUES
(1,'Laptop',1,1,60000,5),
(2,'T-Shirt',2,2,800,20),
(3,'Rice Bag',3,3,2000,50),
(4,'Chair',4,4,3000,8),
(5,'Notebook',5,5,100,100);

INSERT INTO Purchases VALUES
(1,1,10,CURDATE()-INTERVAL 10 DAY,1),
(2,2,50,CURDATE()-INTERVAL 20 DAY,2),
(3,3,100,CURDATE()-INTERVAL 5 DAY,3),
(4,4,20,CURDATE()-INTERVAL 15 DAY,4),
(5,5,200,CURDATE()-INTERVAL 1 DAY,5);

INSERT INTO Sales VALUES
(1,1,2,CURDATE(),'Amit'),
(2,2,5,CURDATE(),'Riya'),
(3,3,20,CURDATE(),'Rahul'),
(4,1,1,CURDATE(),'Sneha'),
(5,2,3,CURDATE(),'Amit');

-- ==============================
-- QUERIES (25)
-- ==============================

-- 1. Products with stock below 10
SELECT * FROM Products WHERE Stock < 10;

-- 2. Top 5 expensive products
SELECT * FROM Products ORDER BY Price DESC LIMIT 5;

-- 3. Suppliers from Delhi
SELECT * FROM Suppliers WHERE City='Delhi';

-- 4. Products by a given supplier (SupplierID=1)
SELECT * FROM Products WHERE SupplierID=1;

-- 5. Count products per category
SELECT CategoryID, COUNT(*) FROM Products GROUP BY CategoryID;

-- 6. Total purchases for a product (ProductID=1)
SELECT ProductID, SUM(Quantity)
FROM Purchases
WHERE ProductID=1
GROUP BY ProductID;

-- 7. Products never sold
SELECT * FROM Products
WHERE ProductID NOT IN (SELECT ProductID FROM Sales);

-- 8. Sales in last week
SELECT * FROM Sales
WHERE SaleDate >= CURDATE() - INTERVAL 7 DAY;

-- 9. Products with sales quantity > 50
SELECT ProductID, SUM(Quantity)
FROM Sales
GROUP BY ProductID
HAVING SUM(Quantity) > 50;

-- 10. Suppliers supplying more than 5 products
SELECT SupplierID, COUNT(*)
FROM Products
GROUP BY SupplierID
HAVING COUNT(*) > 5;

-- 11. Average price per category
SELECT CategoryID, AVG(Price)
FROM Products
GROUP BY CategoryID;

-- 12. Top selling product
SELECT ProductID, SUM(Quantity) AS Total
FROM Sales
GROUP BY ProductID
ORDER BY Total DESC
LIMIT 1;

-- 13. Categories without products
SELECT * FROM Categories
WHERE CategoryID NOT IN (SELECT CategoryID FROM Products);

-- 14. Sales with product names
SELECT S.SaleID, P.ProductName, S.Quantity
FROM Sales S
JOIN Products P ON S.ProductID=P.ProductID;

-- 15. Purchases with supplier names
SELECT Pu.PurchaseID, P.ProductName, S.SupplierName
FROM Purchases Pu
JOIN Products P ON Pu.ProductID=P.ProductID
JOIN Suppliers S ON Pu.SupplierID=S.SupplierID;

-- 16. Suppliers with no purchases
SELECT * FROM Suppliers
WHERE SupplierID NOT IN (SELECT SupplierID FROM Purchases);

-- 17. Most recent purchase per product
SELECT ProductID, MAX(PurchaseDate)
FROM Purchases
GROUP BY ProductID;

-- 18. Customers who bought more than 3 products
SELECT CustomerName, COUNT(*)
FROM Sales
GROUP BY CustomerName
HAVING COUNT(*) > 3;

-- 19. Total stock value
SELECT SUM(Price * Stock) AS TotalStockValue FROM Products;

-- 20. Product with max stock
SELECT * FROM Products ORDER BY Stock DESC LIMIT 1;

-- 21. Sales grouped by customer
SELECT CustomerName, SUM(Quantity)
FROM Sales
GROUP BY CustomerName;

-- 22. Top 3 customers by sales value
SELECT CustomerName, SUM(Quantity * P.Price) AS TotalValue
FROM Sales S
JOIN Products P ON S.ProductID=P.ProductID
GROUP BY CustomerName
ORDER BY TotalValue DESC
LIMIT 3;

-- 23. Monthly sales totals
SELECT MONTH(SaleDate) AS Month, SUM(Quantity)
FROM Sales
GROUP BY MONTH(SaleDate);

-- 24. Products purchased but not sold
SELECT * FROM Products
WHERE ProductID IN (SELECT ProductID FROM Purchases)
AND ProductID NOT IN (SELECT ProductID FROM Sales);

-- 25. Suppliers supplying multiple categories
SELECT S.SupplierID, COUNT(DISTINCT P.CategoryID)
FROM Suppliers S
JOIN Products P ON S.SupplierID=P.SupplierID
GROUP BY S.SupplierID
HAVING COUNT(DISTINCT P.CategoryID) > 1;

-- ==============================
-- CREATE DATABASE
-- ==============================
CREATE DATABASE FoodDeliveryDB;
USE FoodDeliveryDB;

-- ==============================
-- TABLES
-- ==============================

-- Restaurants Table
CREATE TABLE Restaurants (
    RestaurantID INT PRIMARY KEY,
    Name VARCHAR(50),
    City VARCHAR(50),
    Rating DECIMAL(2,1)
);

-- Menu Items Table
CREATE TABLE MenuItems (
    MenuItemID INT PRIMARY KEY,
    RestaurantID INT,
    ItemName VARCHAR(50),
    Price DECIMAL(10,2),
    Category VARCHAR(50),
    FOREIGN KEY (RestaurantID) REFERENCES Restaurants(RestaurantID)
);

-- Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(50),
    Phone VARCHAR(15),
    Address VARCHAR(100)
);

-- Delivery Agents Table
CREATE TABLE DeliveryAgents (
    AgentID INT PRIMARY KEY,
    Name VARCHAR(50),
    Phone VARCHAR(15),
    VehicleNo VARCHAR(20)
);

-- Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    RestaurantID INT,
    OrderDate DATE,
    Status VARCHAR(20),
    AgentID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (RestaurantID) REFERENCES Restaurants(RestaurantID),
    FOREIGN KEY (AgentID) REFERENCES DeliveryAgents(AgentID)
);

-- ==============================
-- INSERT DUMMY DATA
-- ==============================

INSERT INTO Restaurants VALUES
(1,'Dominos','Bangalore',4.2),
(2,'Pizza Hut','Mumbai',4.0),
(3,'KFC','Delhi',4.3),
(4,'Burger King','Pune',4.1),
(5,'Subway','Bangalore',4.4);

INSERT INTO MenuItems VALUES
(1,1,'Pizza',350,'Fast Food'),
(2,2,'Cheese Pizza',400,'Fast Food'),
(3,3,'Fried Chicken',300,'Non-Veg'),
(4,4,'Burger',250,'Fast Food'),
(5,5,'Veg Sandwich',200,'Veg');

INSERT INTO Customers VALUES
(1,'Amit','9876543210','Mumbai'),
(2,'Riya','9123456789','Delhi'),
(3,'Rahul','9988776655','Pune'),
(4,'Sneha','9090909090','Bangalore'),
(5,'Arjun','9898989898','Mumbai');

INSERT INTO DeliveryAgents VALUES
(1,'Raj','9000000001','MH01A1234'),
(2,'Vikram','9000000002','MH02B5678'),
(3,'Aman','9000000003','MH03C9999'),
(4,'Rohit','9000000004','MH04D1111'),
(5,'Karan','9000000005','MH05E2222');

INSERT INTO Orders VALUES
(1,1,2,CURDATE(),'Delivered',1),
(2,2,3,CURDATE(),'Cancelled',2),
(3,3,1,CURDATE(),'Delivered',3),
(4,4,5,CURDATE(),'Pending',4),
(5,1,1,CURDATE(),'Delivered',1);

-- ==============================
-- QUERIES (25)
-- ==============================

-- 1. Restaurants in Bangalore
SELECT * FROM Restaurants WHERE City='Bangalore';

-- 2. Menu items priced above 300
SELECT * FROM MenuItems WHERE Price > 300;

-- 3. Orders in last week
SELECT * FROM Orders
WHERE OrderDate >= CURDATE() - INTERVAL 7 DAY;

-- 4. Top 5 highest rated restaurants
SELECT * FROM Restaurants ORDER BY Rating DESC LIMIT 5;

-- 5. Customers from Mumbai
SELECT * FROM Customers WHERE Address='Mumbai';

-- 6. Delivered orders
SELECT * FROM Orders WHERE Status='Delivered';

-- 7. Count menu items per restaurant
SELECT RestaurantID, COUNT(*) FROM MenuItems GROUP BY RestaurantID;

-- 8. Customers ordering from more than 3 restaurants
SELECT CustomerID, COUNT(DISTINCT RestaurantID)
FROM Orders
GROUP BY CustomerID
HAVING COUNT(DISTINCT RestaurantID) > 3;

-- 9. Most expensive item per restaurant
SELECT RestaurantID, MAX(Price)
FROM MenuItems
GROUP BY RestaurantID;

-- 10. Delivery agents with more than 10 deliveries
SELECT AgentID, COUNT(*)
FROM Orders
WHERE Status='Delivered'
GROUP BY AgentID
HAVING COUNT(*) > 10;

-- 11. Restaurants with no orders
SELECT * FROM Restaurants
WHERE RestaurantID NOT IN (SELECT RestaurantID FROM Orders);

-- 12. Avg price per category
SELECT Category, AVG(Price)
FROM MenuItems
GROUP BY Category;

-- 13. Orders with customer & restaurant names
SELECT O.OrderID, C.Name, R.Name
FROM Orders O
JOIN Customers C ON O.CustomerID=C.CustomerID
JOIN Restaurants R ON O.RestaurantID=R.RestaurantID;

-- 14. Customers ordering same item multiple times (approx logic)
SELECT CustomerID, COUNT(*)
FROM Orders
GROUP BY CustomerID
HAVING COUNT(*) > 1;

-- 15. Delivery agent with max orders
SELECT AgentID, COUNT(*) AS Total
FROM Orders
GROUP BY AgentID
ORDER BY Total DESC
LIMIT 1;

-- 16. Cancelled orders
SELECT * FROM Orders WHERE Status='Cancelled';

-- 17. Restaurants serving Pizza
SELECT DISTINCT R.*
FROM Restaurants R
JOIN MenuItems M ON R.RestaurantID=M.RestaurantID
WHERE M.ItemName LIKE '%Pizza%';

-- 18. Most popular item (approx using count per restaurant)
SELECT RestaurantID, COUNT(*) 
FROM Orders
GROUP BY RestaurantID
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 19. Top 3 customers by order count
SELECT CustomerID, COUNT(*) AS Total
FROM Orders
GROUP BY CustomerID
ORDER BY Total DESC
LIMIT 3;

-- 20. Orders sorted by date
SELECT * FROM Orders ORDER BY OrderDate;

-- 21. Customers with no orders
SELECT * FROM Customers
WHERE CustomerID NOT IN (SELECT CustomerID FROM Orders);

-- 22. Dessert items
SELECT * FROM MenuItems WHERE Category='Dessert';

-- 23. Orders for a specific agent (AgentID=1)
SELECT * FROM Orders WHERE AgentID=1;

-- 24. Daily order count
SELECT OrderDate, COUNT(*) 
FROM Orders
GROUP BY OrderDate;

-- 25. Restaurants with multiple categories
SELECT RestaurantID, COUNT(DISTINCT Category)
FROM MenuItems
GROUP BY RestaurantID
HAVING COUNT(DISTINCT Category) > 1;

-- ==============================
-- CREATE DATABASE
-- ==============================
CREATE DATABASE CinemaDB;
USE CinemaDB;

-- ==============================
-- TABLES
-- ==============================

-- Movies Table
CREATE TABLE Movies (
    MovieID INT PRIMARY KEY,
    Title VARCHAR(100),
    Genre VARCHAR(50),
    Language VARCHAR(50),
    Duration INT,           -- in minutes
    ReleaseDate DATE
);

-- Screens Table
CREATE TABLE Screens (
    ScreenID INT PRIMARY KEY,
    ScreenName VARCHAR(50),
    Capacity INT
);

-- Showtimes Table
CREATE TABLE Showtimes (
    ShowID INT PRIMARY KEY,
    MovieID INT,
    ScreenID INT,
    ShowDate DATE,
    ShowTime TIME,
    Price DECIMAL(10,2),
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID),
    FOREIGN KEY (ScreenID) REFERENCES Screens(ScreenID)
);

-- Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(50),
    Email VARCHAR(50),
    Phone VARCHAR(15)
);

-- Tickets Table
CREATE TABLE Tickets (
    TicketID INT PRIMARY KEY,
    ShowID INT,
    CustomerID INT,
    SeatNo VARCHAR(10),
    BookingDate DATE,
    Status VARCHAR(20),
    FOREIGN KEY (ShowID) REFERENCES Showtimes(ShowID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- ==============================
-- INSERT DUMMY DATA
-- ==============================

INSERT INTO Movies VALUES
(1,'Avengers','Action','English',180,'2021-01-01'),
(2,'Dangal','Drama','Hindi',150,'2016-12-23'),
(3,'Inception','Sci-Fi','English',160,'2010-07-16'),
(4,'KGF','Action','Kannada',170,'2018-12-21'),
(5,'3 Idiots','Comedy','Hindi',140,'2009-12-25');

INSERT INTO Screens VALUES
(1,'Screen 1',100),
(2,'Screen 2',80),
(3,'Screen 3',120),
(4,'Screen 4',90),
(5,'Screen 5',110);

INSERT INTO Showtimes VALUES
(1,1,1,CURDATE(),'18:00:00',300),
(2,2,2,CURDATE(),'15:00:00',250),
(3,3,3,CURDATE(),'20:00:00',350),
(4,4,1,CURDATE()+INTERVAL 1 DAY,'17:00:00',280),
(5,5,2,CURDATE()+INTERVAL 2 DAY,'14:00:00',200);

INSERT INTO Customers VALUES
(1,'Amit','amit@gmail.com','9876543210'),
(2,'Riya','riya@gmail.com','9123456789'),
(3,'Rahul','rahul@gmail.com','9988776655'),
(4,'Sneha','sneha@gmail.com','9090909090'),
(5,'Arjun','arjun@gmail.com','9898989898');

INSERT INTO Tickets VALUES
(1,1,1,'A1',CURDATE(),'Booked'),
(2,2,2,'B2',CURDATE(),'Cancelled'),
(3,1,3,'A2',CURDATE(),'Booked'),
(4,3,1,'C1',CURDATE(),'Booked'),
(5,3,4,'C2',CURDATE(),'Booked');

-- ==============================
-- QUERIES (25)
-- ==============================

-- 1. Movies in Action genre
SELECT * FROM Movies WHERE Genre='Action';

-- 2. Movies released after 2020
SELECT * FROM Movies WHERE ReleaseDate > '2020-01-01';

-- 3. Shows today
SELECT * FROM Showtimes WHERE ShowDate = CURDATE();

-- 4. Top 3 highest priced shows
SELECT * FROM Showtimes ORDER BY Price DESC LIMIT 3;

-- 5. Tickets sold per show
SELECT ShowID, COUNT(*) FROM Tickets
WHERE Status='Booked'
GROUP BY ShowID;

-- 6. Customers with more than 5 tickets
SELECT CustomerID, COUNT(*)
FROM Tickets
GROUP BY CustomerID
HAVING COUNT(*) > 5;

-- 7. Shows with available seats
SELECT S.ShowID, Sc.Capacity - COUNT(T.TicketID) AS AvailableSeats
FROM Showtimes S
JOIN Screens Sc ON S.ScreenID=Sc.ScreenID
LEFT JOIN Tickets T ON S.ShowID=T.ShowID AND T.Status='Booked'
GROUP BY S.ShowID, Sc.Capacity;

-- 8. Customers who booked a given movie
SELECT DISTINCT C.*
FROM Customers C
JOIN Tickets T ON C.CustomerID=T.CustomerID
JOIN Showtimes S ON T.ShowID=S.ShowID
WHERE S.MovieID=1;

-- 9. Movies with no shows
SELECT * FROM Movies
WHERE MovieID NOT IN (SELECT MovieID FROM Showtimes);

-- 10. Tickets with customer & movie names
SELECT T.TicketID, C.Name, M.Title
FROM Tickets T
JOIN Customers C ON T.CustomerID=C.CustomerID
JOIN Showtimes S ON T.ShowID=S.ShowID
JOIN Movies M ON S.MovieID=M.MovieID;

-- 11. Customers without bookings
SELECT * FROM Customers
WHERE CustomerID NOT IN (SELECT CustomerID FROM Tickets);

-- 12. Daily ticket sales
SELECT BookingDate, COUNT(*)
FROM Tickets
WHERE Status='Booked'
GROUP BY BookingDate;

-- 13. Movies longer than 2 hours
SELECT * FROM Movies WHERE Duration > 120;

-- 14. Most popular movie
SELECT M.Title, COUNT(*) AS Total
FROM Tickets T
JOIN Showtimes S ON T.ShowID=S.ShowID
JOIN Movies M ON S.MovieID=M.MovieID
GROUP BY M.Title
ORDER BY Total DESC
LIMIT 1;

-- 15. Top 5 customers by tickets
SELECT CustomerID, COUNT(*) AS Total
FROM Tickets
GROUP BY CustomerID
ORDER BY Total DESC
LIMIT 5;

-- 16. Cancelled tickets
SELECT * FROM Tickets WHERE Status='Cancelled';

-- 17. Shows in specific screen (ScreenID=1)
SELECT * FROM Showtimes WHERE ScreenID=1;

-- 18. Avg price per genre
SELECT M.Genre, AVG(S.Price)
FROM Showtimes S
JOIN Movies M ON S.MovieID=M.MovieID
GROUP BY M.Genre;

-- 19. Movies in Hindi
SELECT * FROM Movies WHERE Language='Hindi';

-- 20. Shows next 7 days
SELECT * FROM Showtimes
WHERE ShowDate BETWEEN CURDATE() AND CURDATE()+INTERVAL 7 DAY;

-- 21. Customers booking multiple movies
SELECT CustomerID, COUNT(DISTINCT S.MovieID)
FROM Tickets T
JOIN Showtimes S ON T.ShowID=S.ShowID
GROUP BY CustomerID
HAVING COUNT(DISTINCT S.MovieID) > 1;

-- 22. Earliest showtime per movie
SELECT MovieID, MIN(ShowTime)
FROM Showtimes
GROUP BY MovieID;

-- 23. Movies in multiple screens
SELECT MovieID, COUNT(DISTINCT ScreenID)
FROM Showtimes
GROUP BY MovieID
HAVING COUNT(DISTINCT ScreenID) > 1;

-- 24. Monthly booking trends
SELECT MONTH(BookingDate) AS Month, COUNT(*)
FROM Tickets
GROUP BY MONTH(BookingDate);

-- 25. Movies screened more than 10 times
SELECT MovieID, COUNT(*)
FROM Showtimes
GROUP BY MovieID
HAVING COUNT(*) > 10;

-- ==============================
-- CREATE DATABASE
-- ==============================
CREATE DATABASE ElearningDB;
USE ElearningDB;

-- ==============================
-- TABLES
-- ==============================

-- Courses Table
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    Title VARCHAR(100),
    Category VARCHAR(50),
    DurationWeeks INT,
    Price DECIMAL(10,2)
);

-- Instructors Table
CREATE TABLE Instructors (
    InstructorID INT PRIMARY KEY,
    Name VARCHAR(50),
    Email VARCHAR(50),
    Specialty VARCHAR(50)
);

-- Students Table
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50),
    Email VARCHAR(50),
    City VARCHAR(50)
);

-- Enrollments Table
CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    EnrollDate DATE,
    Status VARCHAR(20),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- Assignments Table
CREATE TABLE Assignments (
    AssignmentID INT PRIMARY KEY,
    CourseID INT,
    Title VARCHAR(100),
    DueDate DATE,
    MaxMarks INT,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- ==============================
-- INSERT DUMMY DATA
-- ==============================

INSERT INTO Courses VALUES
(1,'Data Science','Data Science',10,15000),
(2,'Python Programming','Programming',8,8000),
(3,'AI Basics','AI',6,12000),
(4,'SQL Mastery','Database',5,6000),
(5,'Web Development','Programming',12,14000);

INSERT INTO Instructors VALUES
(1,'Rahul','rahul@edu.com','Python'),
(2,'Sneha','sneha@edu.com','AI'),
(3,'Amit','amit@edu.com','Database'),
(4,'Riya','riya@edu.com','Web'),
(5,'Arjun','arjun@edu.com','Data Science');

INSERT INTO Students VALUES
(1,'Amit','amit@gmail.com','Mumbai'),
(2,'Riya','riya@gmail.com','Delhi'),
(3,'Rahul','rahul@gmail.com','Pune'),
(4,'Sneha','sneha@gmail.com','Mumbai'),
(5,'Arjun','arjun@gmail.com','Delhi');

INSERT INTO Enrollments VALUES
(1,1,1,CURDATE(),'Completed'),
(2,2,2,CURDATE(),'Active'),
(3,3,3,CURDATE(),'Completed'),
(4,4,1,CURDATE(),'Active'),
(5,5,4,CURDATE(),'Completed');

INSERT INTO Assignments VALUES
(1,1,'Project DS',CURDATE()+INTERVAL 5 DAY,100),
(2,2,'Python Task',CURDATE()+INTERVAL 3 DAY,100),
(3,3,'AI Quiz',CURDATE()+INTERVAL 7 DAY,50),
(4,4,'SQL Test',CURDATE()+INTERVAL 2 DAY,80),
(5,5,'Web Project',CURDATE()+INTERVAL 10 DAY,100);

-- ==============================
-- QUERIES (25)
-- ==============================

-- 1. Courses in Data Science
SELECT * FROM Courses WHERE Category='Data Science';

-- 2. Instructors specializing in Python
SELECT * FROM Instructors WHERE Specialty='Python';

-- 3. Students from Mumbai
SELECT * FROM Students WHERE City='Mumbai';

-- 4. Enrollments in last month
SELECT * FROM Enrollments
WHERE EnrollDate >= CURDATE() - INTERVAL 1 MONTH;

-- 5. Courses longer than 8 weeks
SELECT * FROM Courses WHERE DurationWeeks > 8;

-- 6. Top 3 expensive courses
SELECT * FROM Courses ORDER BY Price DESC LIMIT 3;

-- 7. Students in a given course (CourseID=1)
SELECT S.*
FROM Students S
JOIN Enrollments E ON S.StudentID=E.StudentID
WHERE E.CourseID=1;

-- 8. Instructors teaching multiple courses (approx logic)
SELECT Specialty, COUNT(*)
FROM Instructors
GROUP BY Specialty
HAVING COUNT(*) > 1;

-- 9. Assignments due next week
SELECT * FROM Assignments
WHERE DueDate BETWEEN CURDATE() AND CURDATE()+INTERVAL 7 DAY;

-- 10. Students who completed courses
SELECT * FROM Students
WHERE StudentID IN (
    SELECT StudentID FROM Enrollments WHERE Status='Completed'
);

-- 11. Average marks per course (approx using MaxMarks)
SELECT CourseID, AVG(MaxMarks)
FROM Assignments
GROUP BY CourseID;

-- 12. Students without enrollments
SELECT * FROM Students
WHERE StudentID NOT IN (SELECT StudentID FROM Enrollments);

-- 13. Total enrollments per course
SELECT CourseID, COUNT(*)
FROM Enrollments
GROUP BY CourseID;

-- 14. Instructors with no courses (approx logic)
SELECT * FROM Instructors;

-- 15. Students with more than 3 enrollments
SELECT StudentID, COUNT(*)
FROM Enrollments
GROUP BY StudentID
HAVING COUNT(*) > 3;

-- 16. Courses with no students
SELECT * FROM Courses
WHERE CourseID NOT IN (SELECT CourseID FROM Enrollments);

-- 17. Most popular course
SELECT CourseID, COUNT(*) AS Total
FROM Enrollments
GROUP BY CourseID
ORDER BY Total DESC
LIMIT 1;

-- 18. Assignments per course
SELECT CourseID, COUNT(*)
FROM Assignments
GROUP BY CourseID;

-- 19. Late submissions (approx logic)
SELECT * FROM Enrollments WHERE Status='Completed';

-- 20. Courses with instructor names (approx)
SELECT C.Title, I.Name
FROM Courses C
JOIN Instructors I ON C.Category = I.Specialty;

-- 21. Courses under 5000
SELECT * FROM Courses WHERE Price < 5000;

-- 22. Courses with 'AI' in title
SELECT * FROM Courses WHERE Title LIKE '%AI%';

-- 23. Students in multiple categories (approx)
SELECT StudentID, COUNT(DISTINCT CourseID)
FROM Enrollments
GROUP BY StudentID
HAVING COUNT(DISTINCT CourseID) > 1;

-- 24. Monthly enrollment count
SELECT MONTH(EnrollDate), COUNT(*)
FROM Enrollments
GROUP BY MONTH(EnrollDate);

-- 25. Instructors teaching multiple categories (approx)
SELECT Specialty, COUNT(*)
FROM Instructors
GROUP BY Specialty
HAVING COUNT(*) > 1;
