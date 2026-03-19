-- PRACTICE SETS 1 --
CREATE DATABASE bookstore_management_systems;
-- QUESTION 1 
CREATE TABLE authors (
AuthorId INT PRIMARY KEY,
Name VARCHAR(25) NOT NULL,
COUNTRY VARCHAR(50),
DOB DATE
);

-- QUESTION 2 
CREATE TABLE categories (
categoryID INT PRIMARY KEY,
categoryName VARCHAR(25) UNIQUE );

-- QUESTION 3 & 4
CREATE TABLE books (
bookId INT PRIMARY KEY,
title  VARCHAR(25) UNIQUE,
AuthorId INT,
categoryID INT,
price DECIMAL(10,2) CHECK (PRICE > 0),
stock int CHECK (stock > 0),
PublishedYear YEAR DEFAULT (YEAR(CURDATE())),
foreign key (AuthorID) REFERENCES authors(AuthorID),
foreign key (categoryId) REFERENCES categories(categoryId)
);

-- QUESTION 5
CREATE TABLE Customers (
 CustomerID INT PRIMARY KEY,
 Name VARCHAR(100) NOT NULL,
 Email VARCHAR(100) UNIQUE,
 Phone VARCHAR(10),
 Address VARCHAR(255)
);
-- QUESTION 6 
ALTER TABLE Customers ADD CONSTRAINT chk_phone CHECK (Phone REGEXP '^[789]');
-- QUESTION 7
ALTER TABLE Customers MODIFY Phone VARCHAR(10) NOT NULL;
-- QUESTION 8
ALTER TABLE Customers ADD DateOfBirth DATE;

-- QUESTION 9
CREATE TABLE Orders (
 OrderID INT PRIMARY KEY,
 CustomerID INT,
 OrderDate DATE,
 Status VARCHAR(50) DEFAULT 'Pending',
 FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- QUESTION 10
CREATE TABLE OrderDetails (
 OrderID INT,
 BookID INT,
 Quantity INT CHECK (Quantity > 0),
 Price DECIMAL(10,2) CHECK (Price > 0.01),
 PRIMARY KEY (OrderID, BookID),
 FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
 FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

-- QUESTION 11 & 12
CREATE TABLE Payments (
 PaymentID INT PRIMARY KEY,
 OrderID INT,
 Amount DECIMAL(10,2),
 PaymentDate DATE,
 Method VARCHAR(50) DEFAULT 'Cash',
 FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- QUESTION 13 
ALTER TABLE Books
ADD CONSTRAINT chk_max_price
CHECK (Price <= 10000);

-- QUESTION 14
ALTER TABLE Books
ADD CONSTRAINT unique_isbn UNIQUE (ISBN);

-- QUESTION 15
ALTER TABLE Books
ADD ISBN VARCHAR(20);

-- QUESTION 16
ALTER TABLE Books
MODIFY Stock TINYINT;

-- QUESTION 17
ALTER TABLE Books
RENAME COLUMN PublishedYear TO YearPublished;

-- QUESTION 18
ALTER TABLE Customers
DROP COLUMN DateOfBirth;

-- QUESTION 19
ALTER TABLE Orders
ADD DeliveryAgentID INT,
ADD FOREIGN KEY (DeliveryAgentID) REFERENCES DeliveryAgents(AgentID);

-- QUESTION 20
ALTER TABLE Orders DROP FOREIGN KEY fk_delivery;

-- QUESTION 21
ALTER TABLE OrderDetails ADD Discount DECIMAL(5,2) DEFAULT 0;

--  QUESTION 22
ALTER TABLE OrderDetails ALTER Discount DROP DEFAULT;

--  QUESTION 23
ALTER TABLE Books DROP INDEX uc_isbn;

-- QUESTION 24
ALTER TABLE Books DROP CHECK chk_price;

-- SECTION C (QUESTION 33 - 42)
CREATE TABLE deliveryAgents (
agentId int primary key,
agentName varchar(25) not null,
phone VARCHAR(20) UNIQUE,
 Region VARCHAR(10) DEFAULT 'North',
 CHECK (Region IN ('North', 'South', 'East', 'West'))
);

ALTER TABLE deliveryAgents
ADD EMAIL VARCHAR (25) UNIQUE;

ALTER TABLE deliveryAgents
MODIFY PHONE VARCHAR (10);

ALTER TABLE deliveryagents 
DROP COLUMN EMAIL;

ALTER TABLE deliveryteam
RENAME COLUMN region TO assignedregion;

TRUNCATE TABLE DeliveryTeam;

TRUNCATE TABLE Payments;

TRUNCATE TABLE OrderDetails;

DROP TABLE Payments;

DROP TABLE DeliveryTeam;

-- SECTION  D : DROPPING AND RENAMING (Q43 - Q55)

DROP TABLE Payments;

DROP TABLE DeliveryTeam;

RENAME TABLE BOOKS TO BOOKINVENTORY;

RENAME TABLE CUSTOMERS TO CLIENTS;

ALTER TABLE CLIENTS
RENAME COLUMN NAME TO FULLNAME;

ALTER TABLE BOOKINVENTORY
RENAME COLUMN TITLE TO BOOKTITLE;

RENAME TABLE BOOKINVENTORY TO BOOKS;

ALTER TABLE OrderDetails DROP FOREIGN KEY OrderDetails_ibfk_1;
ALTER TABLE OrderDetails DROP FOREIGN KEY OrderDetails_ibfk_2;

-- SECTION E VIEWS AND ADVANCED CONSTRAINS (Q51 - Q60)
CREATE VIEW TopSellingBooks AS
SELECT B.BookID, B.Title, SUM(OD.Quantity) AS TotalSold
FROM Books B
JOIN OrderDetails OD ON B.BookID = OD.BookID
GROUP BY B.BookID, B.Title
ORDER BY TotalSold DESC;
ALTER TABLE Payments ALTER COLUMN Method SET DEFAULT 'Card';
CREATE TABLE OrderNotes (
 NoteID INT PRIMARY KEY,
 Note TEXT NOT NULL
);
ALTER TABLE Books DROP INDEX uc_isbn;
ALTER TABLE Books DROP CHECK chk_price;

-- Section F: Real-World Scenarios (Q61–Q80)
CREATE TABLE ReturnRequests (
 ReturnID INT PRIMARY KEY,
 OrderID INT,
 Reason VARCHAR(255),
 Status VARCHAR(50) DEFAULT 'Pending',
 FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);
ALTER TABLE ReturnRequests ADD ReturnDate DATE;
ALTER TABLE ReturnRequests DROP COLUMN ReturnDate;
ALTER TABLE ReturnRequests ADD CONSTRAINT fk_return_order FOREIGN KEY (OrderID)
REFERENCES Orders(OrderID);
ALTER TABLE ReturnRequests DROP FOREIGN KEY fk_return_order;
CREATE TABLE Wishlists (
 CustomerID INT,
 BookID INT,
 PRIMARY KEY (CustomerID, BookID),
 FOREIGN KEY (CustomerID) REFERENCES CLIENTS(CustomerID),
 FOREIGN KEY (BookID) REFERENCES Books(BookID)
);
ALTER TABLE Wishlists ADD DateAdded DATE;
ALTER TABLE Wishlists DROP COLUMN DateAdded;
RENAME TABLE Wishlists TO CustomerWishlists;
RENAME TABLE CustomerWishlists TO Wishlists;
 
 -- Section G: Final Challenges (Q81–Q100)
DROP TABLE Books;
CREATE TABLE Books (
 BookID INT PRIMARY KEY,
 Title VARCHAR(200) UNIQUE,
 AuthorID INT,
 CategoryID INT,
 Price DECIMAL(10,2) CHECK (Price > 0),
 Stock INT CHECK (Stock >= 0),
 PublishedYear YEAR DEFAULT (YEAR(CURDATE())),
 FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID),
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);
ALTER TABLE Books ADD Edition VARCHAR(20) DEFAULT 'First';
ALTER TABLE Books MODIFY Edition VARCHAR(50);
ALTER TABLE Books DROP COLUMN Edition;
CREATE TABLE DeliveryLogs (
 LogID INT PRIMARY KEY,
 DeliveryAgentID INT,
 Date DATE,
 Status VARCHAR(20),
 FOREIGN KEY (DeliveryAgentID) REFERENCES DeliveryAgents(AgentID)
);
ALTER TABLE DeliveryLogs ADD Comments TEXT;
ALTER TABLE DeliveryLogs DROP COLUMN Comments;
ALTER TABLE DeliveryLogs ADD CONSTRAINT chk_status CHECK (Status IN ('Delivered',
'Pending', 'Failed'));
ALTER TABLE DeliveryLogs DROP CHECK chk_status;
ALTER TABLE Books ADD Rating DECIMAL(2,1) CHECK (Rating BETWEEN 1 AND 5);
ALTER TABLE Books MODIFY Rating DECIMAL(3,1);
ALTER TABLE Books DROP COLUMN Rating;
CREATE TABLE BookReviews (
 ReviewID INT PRIMARY KEY,
 BookID INT,
 CustomerID INT,
 ReviewText TEXT
 FOREIGN KEY (BookID) REFERENCES Books(BookID),
 FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
ALTER TABLE BookReviews ADD Stars INT CHECK (Stars BETWEEN 1 AND 5);
ALTER TABLE BookReviews MODIFY Stars INT NULL;
DROP TABLE BookReviews;
CREATE TABLE BookReviews (
 ReviewID INT PRIMARY KEY,
 BookID INT,
 CustomerID INT,
 ReviewText TEXT,
 FOREIGN KEY (BookID) REFERENCES Books(BookID),
 FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
ALTER TABLE BookReviews ADD CONSTRAINT fk_book FOREIGN KEY (BookID) REFERENCES
Books(BookID);
ALTER TABLE BookReviews ADD CONSTRAINT fk_customer FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID);
ALTER TABLE BookReviews DROP FOREIGN KEY fk_book;
ALTER TABLE BookReviews DROP FOREIGN KEY fk_customer;
DROP TABLE BookReviews;
CREATE TABLE Coupons (
 CouponID INT PRIMARY KEY,
 Code VARCHAR(50) UNIQUE,
 Discount INT,
 ExpiryDate DATE
 );
ALTER TABLE Coupons ADD Status VARCHAR(20) DEFAULT 'Active';
ALTER TABLE Coupons ADD CONSTRAINT chk_discount CHECK (Discount BETWEEN 1 AND
50);
ALTER TABLE Coupons DROP CHECK chk_discount;
ALTER TABLE Coupons DROP COLUMN Status;





