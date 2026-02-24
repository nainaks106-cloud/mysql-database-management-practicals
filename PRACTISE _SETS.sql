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




