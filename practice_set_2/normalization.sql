-- Normalization
-- � Scenario: PhonePe India stores user KYC documents. The data entry team created
-- the following table. Identify all 1NF violations and convert the table to 1NF.

-- phonepe KYC document DATABASE 
CREATE DATABASE PHONEPE;
USE PHONEPE;
DROP TABLE KYC;
-- CREATE KYCDocument Table
CREATE TABLE KYC (
UserID INT PRIMARY KEY,
User_Name VARCHAR(50),
Mobile_Number  VARCHAR (50),
KYC_Documents VARCHAR (50)
);

INSERT INTO KYC(UserID, User_Name, Mobile_Number, KYC_Documents)
VALUES 
(001, "Pradeep Nair", "9984537586, 8775643894", "Aadhar, Pan, Passport"),
(002, "Geeta Patil", "998435475, 8775657489", "Aadhar, Pan"),
(003, "Sanjay Mehta", "8984765586, 9975666894", "Aadhar");

-- SOLUTION — Question 1
-- Step 1: Identify 1NF Violations
-- • MobileNumbers column has comma-separated values — NOT atomic
-- • KYCDocuments column has comma-separated values — NOT atomic
-- • No clear single-attribute primary key is apparent

-- Step 2: Create 1NF Tables
-- Option A: Create separate tables for mobile numbers and KYC documents:

-- create table user mobile 1nf
CREATE TABLE USER_MOBILE_1NF (
User_ID INT ,
USser_Name VARCHAR(50),
Moblie_Number VARCHAR(20),
PRIMARY KEY (User_ID, Mobile_Number)
);

-- create table user kyc
CREATE TABLE USER_KYC_1NF (
USER_ID INT,
KYCDocument_Type  VARCHAR (30),
VerificationStatus VARCHAR (20),
PRIMARY KEY (USER_ID, KYCDocument_Type)
);


drop table orderdate;

-- =========================================
-- 1. CREATE DATABASE
-- =========================================
CREATE DATABASE ZOMATO_ANALYTICS;
USE ZOMATO_ANALYTICS;

-- =========================================
-- 2. CREATE TABLES
-- =========================================

CREATE TABLE RESTAURANT (
    RestaurantID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    City VARCHAR(50)
);

CREATE TABLE REVIEWS (
    ReviewID INT PRIMARY KEY AUTO_INCREMENT,
    RestaurantID INT,
    Rating DECIMAL(2,1),
    ReviewDate DATE,
    FOREIGN KEY (RestaurantID) REFERENCES RESTAURANT(RestaurantID)
);

-- =========================================
-- 3. INSERT DATA
-- =========================================

-- RESTAURANTS
INSERT INTO RESTAURANT (Name, City) VALUES
('Spice Garden', 'Bangalore'),
('Food Hub', 'Bangalore'),
('Tasty Bites', 'Mumbai'),
('Urban Kitchen', 'Bangalore');

-- REVIEWS (add mix of ratings & dates)
INSERT INTO REVIEWS (RestaurantID, Rating, ReviewDate) VALUES
-- Spice Garden (ID = 1)
(1, 4.5, '2024-02-10'),
(1, 4.7, '2024-03-15'),
(1, 4.8, '2024-04-01'),
(1, 4.6, '2024-05-05'),

-- Food Hub (ID = 2)
(2, 3.8, '2024-01-20'),
(2, 4.0, '2024-02-25'),
(2, 4.2, '2024-03-30'),

-- Tasty Bites (ID = 3)
(3, 4.9, '2024-04-10'),
(3, 4.8, '2024-05-12'),

-- Urban Kitchen (ID = 4)
(4, 4.6, '2024-02-14'),
(4, 4.7, '2024-03-18'),
(4, 4.9, '2024-04-20'),
(4, 5.0, '2024-05-25');

-- This will give ERROR
SELECT RestaurantID, AVG(Rating)
FROM REVIEWS
WHERE AVG(Rating) > 4.0
GROUP BY RestaurantID;

SELECT RestaurantID, AVG(Rating) AS AvgRating
FROM REVIEWS
GROUP BY RestaurantID
HAVING AVG(Rating) > 4.0;

SELECT R.Name, R.City,
       COUNT(*) AS ReviewCount,
       AVG(Rev.Rating) AS AvgRating
FROM RESTAURANT R
JOIN REVIEWS Rev 
     ON R.RestaurantID = Rev.RestaurantID
WHERE R.City = 'Bangalore'
  AND Rev.ReviewDate >= '2024-01-01'
GROUP BY R.RestaurantID, R.Name, R.City
HAVING COUNT(*) >= 3
   AND AVG(Rev.Rating) > 4.5
ORDER BY AvgRating DESC;


-- =========================================
-- CREATE DATABASE
-- =========================================
CREATE DATABASE Amazon2NF;
USE Amazon2NF;

-- =========================================
-- TABLE 1: ORDERS (Customer details depend on OrderID)
-- =========================================
CREATE TABLE Orders (
    OrderID VARCHAR(10) PRIMARY KEY,
    CustomerName VARCHAR(50),
    CustomerCity VARCHAR(50)
);

-- Insert Dummy Data
INSERT INTO Orders VALUES
('ORD001','Aarav Joshi','Bangalore'),
('ORD002','Simran Kaur','Chandigarh'),
('ORD003','Ravi Reddy','Hyderabad');


-- =========================================
-- TABLE 2: PRODUCTS (Product details depend on ProductID)
-- =========================================
CREATE TABLE Products (
    ProductID VARCHAR(10) PRIMARY KEY,
    ProductName VARCHAR(50),
    Category VARCHAR(50),
    UnitPrice DECIMAL(10,2)
);

-- Insert Dummy Data
INSERT INTO Products VALUES
('P101','OnePlus 12','Mobiles',64999),
('P102','USB-C Cable','Accessories',399),
('P103','Noise Buds','Audio',1999);


-- =========================================
-- TABLE 3: ORDER_ITEMS (Full dependency)
-- =========================================
CREATE TABLE Order_Items (
    OrderID VARCHAR(10),
    ProductID VARCHAR(10),
    Qty INT,
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Insert Dummy Data
INSERT INTO Order_Items VALUES
('ORD001','P101',1),
('ORD001','P102',2),
('ORD002','P101',1),
('ORD003','P103',1);


-- =========================================
-- CREATE DATABASE
-- =========================================
CREATE DATABASE RailwayDB;
USE RailwayDB;

-- =========================================
-- TABLE 1: ZONE MASTER
-- (Removes transitive dependency: ZoneCode → ZoneName, ZoneHQ)
-- =========================================
CREATE TABLE Zone_Master (
    ZoneCode VARCHAR(10) PRIMARY KEY,
    ZoneName VARCHAR(50),
    ZoneHQ VARCHAR(50)
);

-- Insert Data
INSERT INTO Zone_Master VALUES
('CR','Central Railway','Mumbai'),
('SR','Southern Railway','Chennai');


-- =========================================
-- TABLE 2: DIVISION MASTER
-- (Removes transitive dependency: DivisionCode → ZoneCode)
-- =========================================
CREATE TABLE Division_Master (
    DivisionCode VARCHAR(10) PRIMARY KEY,
    DivisionName VARCHAR(50),
    ZoneCode VARCHAR(10),
    FOREIGN KEY (ZoneCode) REFERENCES Zone_Master(ZoneCode)
);

-- Insert Data
INSERT INTO Division_Master VALUES
('CR-MUM','Mumbai Division','CR'),
('CR-PUNE','Pune Division','CR'),
('SR-MAS','Chennai Division','SR'),
('SR-TPJ','Tiruchy Division','SR');


-- =========================================
-- TABLE 3: EMPLOYEE
-- (Now only full dependency: EmpID → all attributes)
-- =========================================
CREATE TABLE Employee (
    EmpID VARCHAR(10) PRIMARY KEY,
    EmpName VARCHAR(50),
    DivisionCode VARCHAR(10),
    Designation VARCHAR(50),
    Salary INT,
    FOREIGN KEY (DivisionCode) REFERENCES Division_Master(DivisionCode)
);

-- Insert Data
INSERT INTO Employee VALUES
('IR001','Akash Pandey','CR-MUM','Station Master',62000),
('IR002','Bharti Mishra','CR-PUNE','Ticket Inspector',45000),
('IR003','Suresh Babu','SR-MAS','Loco Pilot',78000),
('IR004','Meena Thomas','SR-TPJ','Clerk',40000);


-- =========================================
-- PHASE 1: RAW TABLE (DENORMALIZED)
-- =========================================
CREATE DATABASE BigBasket_DB;
USE BigBasket_DB;

CREATE TABLE raw_orders (
  OrderID INT,
  CustomerName VARCHAR(100),
  CustomerPhone VARCHAR(50),
  CustomerCity VARCHAR(100),
  ProductIDs VARCHAR(200),
  ProductNames VARCHAR(500),
  CategoryName VARCHAR(200),
  CategoryManager VARCHAR(100),
  Quantities VARCHAR(100),
  UnitPrices VARCHAR(100),
  OrderDate DATE
);

INSERT INTO raw_orders VALUES
(1,'Anita Desai','9876543210,8765432109','Chennai','P1,P2','Tata Salt,Amul Butter','Groceries,Dairy','Rohit,Priya','2,1','22,120','2024-03-01'),
(2,'Suresh Pillai','7654321098','Kochi','P3','Fortune Oil','Groceries','Rohit','1','180','2024-03-01');

-- =========================================
-- PHASE 2: 1NF (Remove multi-valued fields)
-- =========================================

CREATE TABLE Customer_Phone_1NF (
  OrderID INT,
  PhoneNumber VARCHAR(15),
  PRIMARY KEY (OrderID, PhoneNumber)
);

CREATE TABLE Order_Items_1NF (
  OrderID INT,
  ProductID VARCHAR(10),
  ProductName VARCHAR(100),
  CategoryName VARCHAR(100),
  CategoryMgr VARCHAR(100),
  Quantity INT,
  UnitPrice DECIMAL(8,2),
  PRIMARY KEY (OrderID, ProductID)
);

-- =========================================
-- PHASE 3: 2NF (Remove partial dependency)
-- =========================================

CREATE TABLE Product_2NF (
  ProductID VARCHAR(10) PRIMARY KEY,
  ProductName VARCHAR(100),
  CategoryName VARCHAR(100),
  CategoryMgr VARCHAR(100)
);

CREATE TABLE OrderItems_2NF (
  OrderID INT,
  ProductID VARCHAR(10),
  Quantity INT,
  UnitPrice DECIMAL(8,2),
  PRIMARY KEY (OrderID, ProductID),
  FOREIGN KEY (ProductID) REFERENCES Product_2NF(ProductID)
);

-- =========================================
-- PHASE 4: 3NF (Remove transitive dependency)
-- =========================================

-- Category table (Manager depends on Category)
CREATE TABLE Category (
  CategoryID INT AUTO_INCREMENT PRIMARY KEY,
  CategoryName VARCHAR(100) UNIQUE,
  ManagerName VARCHAR(100)
);

-- Product table
CREATE TABLE Product (
  ProductID VARCHAR(10) PRIMARY KEY,
  ProductName VARCHAR(100),
  CategoryID INT,
  UnitPrice DECIMAL(8,2),
  FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);

-- Customer table
CREATE TABLE Customer (
  CustomerID VARCHAR(10) PRIMARY KEY,
  CustomerName VARCHAR(100),
  CustomerCity VARCHAR(100)
);

-- Customer Phone table
CREATE TABLE CustomerPhone (
  CustomerID VARCHAR(10),
  PhoneNumber VARCHAR(15),
  PRIMARY KEY (CustomerID, PhoneNumber),
  FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- Orders table
CREATE TABLE Orders (
  OrderID INT PRIMARY KEY,
  CustomerID VARCHAR(10),
  OrderDate DATE,
  FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- Order Items table
CREATE TABLE OrderItems (
  OrderID INT,
  ProductID VARCHAR(10),
  Quantity INT,
  PRIMARY KEY (OrderID, ProductID),
  FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
  FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- =========================================
-- INSERT DATA (3NF STRUCTURE)
-- =========================================

-- Categories
INSERT INTO Category (CategoryName, ManagerName) VALUES
('Groceries','Rohit'),
('Dairy','Priya');

-- Products
INSERT INTO Product VALUES
('P1','Tata Salt',1,22),
('P2','Amul Butter',2,120),
('P3','Fortune Oil',1,180);

-- Customers
INSERT INTO Customer VALUES
('C001','Anita Desai','Chennai'),
('C002','Suresh Pillai','Kochi');

-- Phones
INSERT INTO CustomerPhone VALUES
('C001','9876543210'),
('C001','8765432109'),
('C002','7654321098');

-- Orders
INSERT INTO Orders VALUES
(1,'C001','2024-03-01'),
(2,'C002','2024-03-01');

-- Order Items
INSERT INTO OrderItems VALUES
(1,'P1',2),
(1,'P2',1),
(2,'P3',1);

-- =========================================
-- TEST QUERIES (VALIDATION)
-- =========================================

-- 1. Chennai customers orders with total amount
SELECT O.OrderID, SUM(P.UnitPrice * OI.Quantity) AS TotalAmount
FROM Orders O
JOIN Customer C ON O.CustomerID = C.CustomerID
JOIN OrderItems OI ON O.OrderID = OI.OrderID
JOIN Product P ON OI.ProductID = P.ProductID
WHERE C.CustomerCity = 'Chennai'
GROUP BY O.OrderID;

-- 2. Category with highest avg order value
SELECT Cat.CategoryName, AVG(P.UnitPrice * OI.Quantity) AS AvgValue
FROM OrderItems OI
JOIN Product P ON OI.ProductID = P.ProductID
JOIN Category Cat ON P.CategoryID = Cat.CategoryID
GROUP BY Cat.CategoryName
ORDER BY AvgValue DESC
LIMIT 1;

-- 3. Update Dairy manager (only 1 row affected)
UPDATE Category SET ManagerName = 'Neha'
WHERE CategoryName = 'Dairy';

SELECT * FROM Category;

-- =========================================
-- ANOMALY TESTS
-- =========================================

-- Update anomaly test
UPDATE Product SET UnitPrice = 25 WHERE ProductID = 'P1';

-- Deletion anomaly test
DELETE FROM Customer WHERE CustomerID = 'C001';
SELECT * FROM Product WHERE ProductID = 'P1';

-- Insertion anomaly test
INSERT INTO Product VALUES ('P99','Amul Ghee',1,500);
SELECT * FROM Product;


