CREATE DATABASE University_Database;
use university_Database;

create table Student (
StudentID int primary key,
Firstname varchar(50),
lastname varchar(50),
DOB date,
gender Varchar(10),
GPA Decimal(3,2)
);

create table course (
coursecode Varchar(10) primary key,
title varchar(100),
credits int,
deptID int,
foreign key(deptid) references Department(deptid)
);

create table Department (
deptid int primary key,
deptName varchar(100),
location varchar(100),
managerEmpID int);

create table Section (
CourseCode Varchar(10),
SectionNo int,
Semester Varchar(20),
year INt,
Time Varchar(20),
Room varchar(20),
EmpID int,
Primary key (coursecode,sectionno),
foreign key (coursecode) references course(Coursecode),
foreign key (EmpID) references instructor(Empid)
);

create table Instructor(
EmpID int primary key,
FirstName varchar(50),
Lastname varchar(50),
Title varchar(50), 
salary decimal(10,2),
deptid int,
foreign key (deptid) references department(deptid)
);

-- multivalued atrribute
CREATE TABLE Instructor_Phone (
    EmpID INT,
    PhoneNo VARCHAR(15),
    PRIMARY KEY (EmpID, PhoneNo),
    FOREIGN KEY (EmpID) REFERENCES Instructor(EmpID)
);

-- Multivalued attribute
CREATE TABLE Student_Email (
    StudentID INT,
    Email VARCHAR(100),
    PRIMARY KEY (StudentID, Email),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID)
);

-- 6. ENROLLMENT (M:N relationship)
CREATE TABLE Enrollment (
    StudentID INT,
    CourseCode VARCHAR(10),
    SectionNo INT,
    Grade CHAR(2),
    PRIMARY KEY (StudentID, CourseCode, SectionNo),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (CourseCode, SectionNo) REFERENCES Section(CourseCode, SectionNo)
);

show tables;


-- casestudy 2 : Hospital database:
CREATE DATABASE Hospital;
use Hospital;

-- 1. Ward
CREATE TABLE Ward (
WardID INT PRIMARY KEY,
WardName VArchar(100),
floorno int,
Capacity int,
HeadNurseID int);

-- 2. Nurse 
Create Table Nurse (
NurseID int primary key,
namess varchar(100),
WardID int,
Foreign key (WardID) references Ward(wardID)
);

-- 3. multivalued attreibute
create table Nurse_Shift (
NurseID int,
 Shift varchar(20),
 Primary key(NurseID, Shift),
 foreign key (NurseID) references Nurse(NurseID)
 );
 
 -- 4. patient 
 create Table patient (
 PatientID int primary key,
 nam varchar(100),
 DOB Date,
 Bloodtype Varchar(5),
 street varchar(30),
 city varchar (30),
 state varchar(30)
 );
 
 -- Weak entity of Patient
CREATE TABLE Emergency_Contact (
    PatientID INT,
    ContactName VARCHAR(100),
    Relation VARCHAR(50),
    Phone VARCHAR(15),
    PRIMARY KEY (PatientID, ContactName),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
    );
    
    -- 4. DOCTOR
CREATE TABLE Doctor (
    DoctorID INT PRIMARY KEY,
    Name VARCHAR(100),
    Specialization VARCHAR(100),
    Contact VARCHAR(15),
    YearsExperience INT
);


-- 5. ADMISSION
CREATE TABLE Admission (
    AdmissionID INT PRIMARY KEY,
    PatientID INT,
    WardID INT,
    AdmitDate DATE,
    DischargeDate DATE,
    Reason VARCHAR(200),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (WardID) REFERENCES Ward(WardID)
);

-- 6. MEDICATION
CREATE TABLE Medication (
    DrugID INT PRIMARY KEY,
    Name VARCHAR(100),
    Manufacturer VARCHAR(100),
    Type VARCHAR(50)
);

-- 7. TREATMENT
CREATE TABLE Treatment (
    TreatmentID INT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    Date DATE,
    Diagnosis VARCHAR(200),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID)
);

-- 8. PRESCRIPTION
CREATE TABLE Prescription (
    TreatmentID INT,
    DrugID INT,
    Dosage VARCHAR(50),
    Frequency VARCHAR(50),
    Duration VARCHAR(50),
    PRIMARY KEY (TreatmentID, DrugID),
    FOREIGN KEY (TreatmentID) REFERENCES Treatment(TreatmentID),
    FOREIGN KEY (DrugID) REFERENCES Medication(DrugID)
);

-- 9. LAB TEST
CREATE TABLE Lab_Test (
    TestID INT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    TestName VARCHAR(100),
    Date DATE,
    Result VARCHAR(200),
    Status VARCHAR(50),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID)
);

-- Sample Queries
-- List all patients currently admitted
SELECT p.nam, w.WardName, a.AdmitDate
FROM Patient p
JOIN Admission a ON p.PatientID = a.PatientID
JOIN Ward w ON a.WardID = w.WardID
WHERE a.DischargeDate IS NULL;

-- Doctors who treated more than 10 patients
SELECT d.Name, COUNT(DISTINCT t.PatientID) AS PatientCount
FROM Doctor d
JOIN Treatment t ON d.DoctorID = t.DoctorID
WHERE YEAR(t.Date) = 2024
GROUP BY d.DoctorID
HAVING COUNT(DISTINCT t.PatientID) > 10;

-- Nurses working morning shift in Ward 2
SELECT n.Namess
FROM Nurse n
JOIN Nurse_Shift ns ON n.NurseID = ns.NurseID
WHERE n.WardID = 2 AND ns.Shift = 'Morning';

-- E-Commerce Database

-- Create Database
CREATE DATABASE EcommerceDB;
USE EcommerceDB;

-- 1. CATEGORY (self-referencing)
CREATE TABLE Category (
    CatID INT PRIMARY KEY,
    CatName VARCHAR(100),
    ParentCatID INT,
    FOREIGN KEY (ParentCatID) REFERENCES Category(CatID)
);

-- 2. PRODUCT
CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    Name VARCHAR(100),
    Description TEXT,
    BasePrice DECIMAL(10,2),
    StockQty INT,
    Weight DECIMAL(10,2),
    CatID INT,
    FOREIGN KEY (CatID) REFERENCES Category(CatID)
);

-- Multivalued attribute (Images)
CREATE TABLE Product_Image (
    ProductID INT,
    ImageURL VARCHAR(255),
    PRIMARY KEY (ProductID, ImageURL),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- 3. VENDOR
CREATE TABLE Vendor (
    VendorID INT PRIMARY KEY,
    Name VARCHAR(100),
    Rating DECIMAL(2,1),
    Email VARCHAR(100),
    Phone VARCHAR(15)
);

-- M:N relationship Vendor-Product
CREATE TABLE Vendor_Product (
    VendorID INT,
    ProductID INT,
    VendorPrice DECIMAL(10,2),
    DeliveryDays INT,
    PRIMARY KEY (VendorID, ProductID),
    FOREIGN KEY (VendorID) REFERENCES Vendor(VendorID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- 4. CUSTOMER
CREATE TABLE Customer (
    CustID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateJoined DATE,
    LoyaltyPoints INT
);

-- Multivalued Email
CREATE TABLE Customer_Email (
    CustID INT,
    Email VARCHAR(100),
    PRIMARY KEY (CustID, Email),
    FOREIGN KEY (CustID) REFERENCES Customer(CustID)
);

-- Weak entity ADDRESS
CREATE TABLE Address (
    CustID INT,
    AddressID INT,
    Street VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(50),
    Country VARCHAR(50),
    Pincode VARCHAR(10),
    Type VARCHAR(20),
    PRIMARY KEY (CustID, AddressID),
    FOREIGN KEY (CustID) REFERENCES Customer(CustID)
);

-- 5. CART
CREATE TABLE Cart (
    CartID INT PRIMARY KEY,
    CustID INT UNIQUE,
    CreatedAt DATE,
    FOREIGN KEY (CustID) REFERENCES Customer(CustID)
);

-- Cart Items
CREATE TABLE Cart_Item (
    CartID INT,
    ProductID INT,
    Quantity INT,
    PRIMARY KEY (CartID, ProductID),
    FOREIGN KEY (CartID) REFERENCES Cart(CartID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- 6. ORDERS
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustID INT,
    OrderDate DATE,
    Status VARCHAR(50),
    ShipStreet VARCHAR(100),
    ShipCity VARCHAR(50),
    ShipState VARCHAR(50),
    FOREIGN KEY (CustID) REFERENCES Customer(CustID)
);

-- ORDER ITEMS (weak entity)
CREATE TABLE Order_Item (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    Discount DECIMAL(5,2),
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- 7. PAYMENT
CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY,
    OrderID INT UNIQUE,
    Method VARCHAR(50),
    Amount DECIMAL(10,2),
    TxnID VARCHAR(100),
    Status VARCHAR(50),
    PaidAt DATE,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- 8. REVIEW
CREATE TABLE Review (
    ReviewID INT PRIMARY KEY,
    CustID INT,
    ProductID INT,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comment TEXT,
    ReviewDate DATE,
    UNIQUE (CustID, ProductID),
    FOREIGN KEY (CustID) REFERENCES Customer(CustID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);