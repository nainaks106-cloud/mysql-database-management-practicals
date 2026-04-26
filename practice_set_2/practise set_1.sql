-- =========================================
-- DATABASE
-- =========================================
CREATE DATABASE BookstoreDDL;
USE BookstoreDDL;

-- =========================================
-- SECTION A (Q1–Q12)
-- =========================================

-- Q1
CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Country VARCHAR(50),
    DOB DATE
);

-- Q2
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50) UNIQUE
);

-- Q3 + Q4
CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(100) UNIQUE,
    AuthorID INT,
    CategoryID INT,
    Price DECIMAL(10,2) CHECK (Price > 0),
    Stock INT CHECK (Stock >= 0),
    PublishedYear INT DEFAULT (YEAR(CURDATE())),
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

-- Q5
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Email VARCHAR(50) UNIQUE,
    Phone VARCHAR(15),
    Address VARCHAR(100)
);

-- Q6
ALTER TABLE Customers
ADD CONSTRAINT chk_phone CHECK (Phone LIKE '7%' OR Phone LIKE '8%' OR Phone LIKE '9%');

-- Q7
ALTER TABLE Customers MODIFY Phone VARCHAR(15) NOT NULL;

-- Q8
ALTER TABLE Customers ADD DateOfBirth DATE;

-- Q9
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    Status VARCHAR(20) DEFAULT 'Pending',
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Q10
CREATE TABLE OrderDetails (
    OrderID INT,
    BookID INT,
    Quantity INT CHECK (Quantity > 0),
    Price DECIMAL(10,2) CHECK (Price > 0.01),
    PRIMARY KEY (OrderID, BookID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

-- Q11
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    OrderID INT,
    Amount DECIMAL(10,2),
    PaymentDate DATE,
    Method VARCHAR(20) DEFAULT 'Cash',
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- =========================================
-- SECTION B (Q13–Q24)
-- =========================================

-- Q13
ALTER TABLE Books ADD CONSTRAINT chk_price_max CHECK (Price <= 10000);

-- Q15
ALTER TABLE Books ADD ISBN VARCHAR(20);

-- Q14
ALTER TABLE Books ADD CONSTRAINT unique_isbn UNIQUE (ISBN);

-- Q16
ALTER TABLE Books MODIFY Stock TINYINT;

-- Q17
ALTER TABLE Books CHANGE PublishedYear YearPublished INT;

-- Q18
ALTER TABLE Customers DROP COLUMN DateOfBirth;

-- Q19
CREATE TABLE DeliveryAgents (
    AgentID INT PRIMARY KEY,
    Name VARCHAR(50),
    Phone VARCHAR(15) UNIQUE,
    Region ENUM('North','South','East','West') DEFAULT 'North'
);

ALTER TABLE Orders ADD DeliveryAgentID INT;
ALTER TABLE Orders ADD FOREIGN KEY (DeliveryAgentID) REFERENCES DeliveryAgents(AgentID);

-- Q20
ALTER TABLE Orders DROP FOREIGN KEY Orders_ibfk_1;

-- Q21
ALTER TABLE OrderDetails ADD Discount DECIMAL(5,2) DEFAULT 0;

-- Q22
ALTER TABLE OrderDetails ALTER Discount DROP DEFAULT;

-- Q23
ALTER TABLE Books DROP INDEX unique_isbn;

-- Q24
ALTER TABLE Books DROP CHECK chk_price_max;

-- =========================================
-- SECTION C (Q33–Q42)
-- =========================================

-- Q34
ALTER TABLE DeliveryAgents ADD Email VARCHAR(50) UNIQUE;

-- Q35
ALTER TABLE DeliveryAgents MODIFY Phone VARCHAR(10);

-- Q36
ALTER TABLE DeliveryAgents DROP COLUMN Email;

-- Q37
RENAME TABLE DeliveryAgents TO DeliveryTeam;

-- Q38
ALTER TABLE DeliveryTeam CHANGE Region AssignedRegion VARCHAR(20);

-- Q39
TRUNCATE TABLE DeliveryTeam;

-- Q40
DROP TABLE DeliveryTeam;

-- Q41
TRUNCATE TABLE Payments;

-- Q42
TRUNCATE TABLE OrderDetails;

-- =========================================
-- SECTION D (Q43–Q50)
-- =========================================

-- Q43
DROP TABLE Payments;

-- Q45
RENAME TABLE Books TO BookInventory;

-- Q46
RENAME TABLE Customers TO Clients;

-- Q47
ALTER TABLE Clients CHANGE Name FullName VARCHAR(50);

-- Q48
ALTER TABLE BookInventory CHANGE Title BookTitle VARCHAR(100);

-- Q49
RENAME TABLE BookInventory TO Books;

-- Q50
ALTER TABLE OrderDetails DROP FOREIGN KEY OrderDetails_ibfk_1;
ALTER TABLE OrderDetails DROP FOREIGN KEY OrderDetails_ibfk_2;

-- =========================================
-- SECTION E (Q51–Q60)
-- =========================================

-- Q51
CREATE VIEW TopSellingBooks AS
SELECT BookID, SUM(Quantity) AS TotalSold
FROM OrderDetails
GROUP BY BookID;

-- Q52
ALTER TABLE Orders ALTER Status SET DEFAULT 'Pending';

-- Q53
CREATE TABLE OrderNotes (
    Note VARCHAR(255) NOT NULL
);

-- Q54
ALTER TABLE Books DROP INDEX ISBN;

-- Q55
ALTER TABLE Books DROP CHECK chk_price_max;

-- =========================================
-- SECTION F (Q61–Q75)
-- =========================================

-- Q61
CREATE TABLE ReturnRequests (
    ReturnID INT PRIMARY KEY,
    OrderID INT,
    Reason VARCHAR(100),
    Status VARCHAR(20) DEFAULT 'Pending'
);

-- Q62
ALTER TABLE ReturnRequests ADD ReturnDate DATE;

-- Q63
ALTER TABLE ReturnRequests DROP COLUMN ReturnDate;

-- Q64
ALTER TABLE ReturnRequests ADD FOREIGN KEY (OrderID) REFERENCES Orders(OrderID);

-- Q65
ALTER TABLE ReturnRequests DROP FOREIGN KEY ReturnRequests_ibfk_1;

-- Q66
CREATE TABLE Wishlists (
    CustomerID INT,
    BookID INT,
    PRIMARY KEY (CustomerID, BookID)
);

-- Q67
ALTER TABLE Wishlists ADD DateAdded DATE;

-- Q68
ALTER TABLE Wishlists DROP COLUMN DateAdded;

-- Q69
RENAME TABLE Wishlists TO CustomerWishlists;

-- Q70
RENAME TABLE CustomerWishlists TO Wishlists;

-- Q71–75 (Sample renaming)
RENAME TABLE Orders TO OrdersNew;
RENAME TABLE OrdersNew TO Orders;
ALTER TABLE Books CHANGE BookTitle Title VARCHAR(100);
ALTER TABLE Clients CHANGE FullName Name VARCHAR(50);
ALTER TABLE Books CHANGE YearPublished PublishedYear INT;

-- =========================================
-- SECTION G (Q76–Q100)
-- =========================================

-- Q76
DROP TABLE Books;

-- Q77
CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(100),
    AuthorID INT,
    CategoryID INT,
    Price DECIMAL(10,2),
    Stock INT
);

-- Q78
ALTER TABLE Books ADD Edition VARCHAR(20) DEFAULT 'First';

-- Q79
ALTER TABLE Books MODIFY Edition VARCHAR(50);

-- Q80
ALTER TABLE Books DROP COLUMN Edition;

-- Q81
CREATE TABLE DeliveryLogs (
    LogID INT PRIMARY KEY,
    DeliveryAgentID INT,
    Date DATE,
    Status VARCHAR(20)
);

-- Q82
ALTER TABLE DeliveryLogs ADD Comments VARCHAR(100);

-- Q83
ALTER TABLE DeliveryLogs DROP COLUMN Comments;

-- Q84
ALTER TABLE DeliveryLogs ADD CHECK (Status IN ('Delivered','Pending','Failed'));

-- Q85
ALTER TABLE DeliveryLogs DROP CHECK DeliveryLogs_chk_1;

-- Q86
ALTER TABLE Books ADD Rating INT CHECK (Rating BETWEEN 1 AND 5);

-- Q87
ALTER TABLE Books MODIFY Rating DECIMAL(2,1);

-- Q88
ALTER TABLE Books DROP COLUMN Rating;

-- Q89
CREATE TABLE BookReviews (
    ReviewID INT PRIMARY KEY,
    BookID INT,
    CustomerID INT,
    ReviewText VARCHAR(255)
);

-- Q90
ALTER TABLE BookReviews ADD Stars INT CHECK (Stars BETWEEN 1 AND 5);

-- Q91
ALTER TABLE BookReviews MODIFY Stars INT NULL;

-- Q92
DROP TABLE BookReviews;

-- Q93
CREATE TABLE BookReviews (
    ReviewID INT PRIMARY KEY,
    BookID INT,
    CustomerID INT,
    ReviewText VARCHAR(255),
    Stars INT CHECK (Stars BETWEEN 1 AND 5)
);

-- Q94
ALTER TABLE BookReviews ADD FOREIGN KEY (BookID) REFERENCES Books(BookID);
ALTER TABLE BookReviews ADD FOREIGN KEY (CustomerID) REFERENCES Clients(CustomerID);

-- Q95
ALTER TABLE BookReviews DROP FOREIGN KEY BookReviews_ibfk_1;
ALTER TABLE BookReviews DROP FOREIGN KEY BookReviews_ibfk_2;

-- Q96
DROP TABLE BookReviews;

-- Q97
CREATE TABLE Coupons (
    CouponID INT,
    Code VARCHAR(50) UNIQUE,
    Discount INT,
    ExpiryDate DATE
);

-- Q98
ALTER TABLE Coupons ADD Status VARCHAR(20) DEFAULT 'Active';

-- Q99
ALTER TABLE Coupons ADD CHECK (Discount BETWEEN 1 AND 50);

-- Q100
ALTER TABLE Coupons DROP CHECK Coupons_chk_1;