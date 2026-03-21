-- practice set 2

-- set 1 :- online bookstore
drop database online_bookstore;
create database online_bookstore;
use online_bookstore;

-- table Author
CREATE TABLE Authors (
AuthorId INT PRIMARY KEY,
Namee VARCHAR (50),
Country VARCHAR (30),
DOB date);

-- table categories
CREATE TABLE Categories (
categoryID INT PRIMARY KEY,
C_Name VARCHAR (30));

-- TABLE BOOKS 
CREATE TABLE Books(
BookID INT PRIMARY KEY,
Tittle  varchar(50),
AuthorId int,
categoryID int,
price decimal (10,2),
stock varchar(30),
PublishedYear date,
foreign key(AuthorId) REFERENCES Authors(AuthorId),
foreign key (categoryID)  REFERENCES Categories(categoryID));

-- TABLE CUSTOMER
CREATE TABLE Customers (
CustomerID INT PRIMARY KEY,
CU_Name VARCHAR (30),
Email varchar (30) unique,
Phone VARCHAR (12),
Address VARCHAR(30));

-- table orders
CREATE TABLE Orders(
OrderID INT PRIMARY KEY,
CustomerID INT,
Orderdate DATE,
Statuss VARCHAR (30),
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID));

-- table oderitems (important for many-to- many relation between orders and books)
CREATE TABLE Orderitems(
orderitemsID INT PRIMARY KEY,
OrderID int,
BookID INT,
Quantity INT,
UNIT_Price DECIMAL(10,2),
FOREIGN KEY (OrderID) REFERENCES Orders(orderID),
FOREIGN KEY (BookID) REFERENCES Books(BookId));

-- insert values in table author
INSERT INTO Authors (AuthorID, Namee, Country, DOB)
VALUES
(1, "CHETAN BHAGAT", "INDIA", "1973-03-12"),
(2, "J.K Rowlings", "UK", "1965-07-31"),
(3, "George orwell", "UK", "1903-06-25"),
(4, "Paulo", "brazil", "1947-08-24"),
(5, "Dan Brown", "USA", "1964-04-15");

-- insert values in table categories
INSERT INTO Categories (CategoryId, C_Name)
VALUES
(1, "Fiction"),
(2, "mystry"),
(3, "Fantasy" ),
(4, "Self - Help"),
(5, "Science- Fiction");

-- insert values into Books
INSERT INTO Books( BookID, Tittle, AuthorID, CategoryID, Price, Stock, PublishedYear)
VALUES
(1, "Half Girlfriend", 1, 1, 300, 15, "2014-03-12"),
(2, "Harry Potter", 2, 3, 600, 20, "1997-04-12"),
(3, "1984", 3, 5, 450, 5, "1949-11-12"),
(4, "The Alchemist", 4, 4, 700, 25, "1998-07-12"),
(5, "The DA Vinci Code", 5, 2, 350, 10, "2003-03-4");

-- insert into customers
INSERT INTO  Customers (CustomerID, CU_Name, Email, Phone, Address) 
VALUES 
(1, "Rhul sharma", "rahul@gmail.com", "99876543210", "Mumbai"),
(2, "Priya Singh", "Priya@gmail.com", "98766543210", "Delhi"),
(3, "Amit kumar", "Amit@gmail.com", "9567438210", "Bangalore"),
(4, "Neha verma", "Neha@gmail.com", "8779543210", "Pune"),
(5, "Rohit Mehera", "rohit@gmail.com", "9899543210", "Chennai");

-- insert into orders
insert into Orders (OrderID, CustomerID, OrderDate, Statuss)
VALUES
(1, 1, "2026-03-01", "Delivered"),
(2, 2, "2026-03-05", "Pending"),
(3, 3, "2026-02-25", "Delivered"),
(4, 1, "2026-03-10", "Shipped"),
(5, 4, "2026-03-15", "Pending");

-- insert into ortder items.
INSERT INTO Orderitems (OrderitemsID, OrderID, BookId, Quantity, Unit_Price)
Values
(1, 1, 1, 2, 300),
(2, 1, 2, 1, 600),
(3, 2, 3, 1, 450),
(4, 4, 3, 3, 350),
(5, 4, 5, 1, 700);

-- 25 Queries:-
-- 1. list all books with price above 500
select * from Books 
where Price > 500;

-- 2. show books published after 2015
select * from Books 
where PublishedYear > "2015-01-01";

Select* From books;

-- 3. find Customers from specific city
SELECT * FROM Customers
where Address = "Mumbai";

-- 4. Display books by given Author name
Select b. * FROM Books b 
JOIN Authors a ON b.AuthorID = a.AuthorID
where a.Namee = "Chetan Bhagat";

-- 5. list top 3 most expensive books
SELECT * FROM Books 
ORDER BY Price DESC
LIMIT 3;

-- 6. count total number of books in each category.
SELECT c.C_Name, count(b.BookID)
AS TotalBooks
FROM Categories c
LEFT JOIN BOOKS b 
ON c.CategoryID = b.CategoryID
Group by C.categoryID, c.C_Name;

-- 7. show orders placed in the last 30 days.
SELECT * FROM Orders
where OrderDate >= CURDATE()-
INTERVAL 30 DAY;

-- 8. display customer name and total orders placed
SELECT c.CustomerID, c.CU_Name, 
COUNT(o.OrderID) As TotalOrders 
FROM Customers c
LEFT JOIN Orders o
ON c.CustomerID = O.CustomerID
GRoup by c.CustomerID, c.CU_Name;

-- 9. list books with stock less than 10.
SELECT * FROM Books 
WHERE Stock < 10;

-- find authors with more than 5 books
SELECT a.AuthorID, a.Namee, 
Count(b.bookId) As TotalBooks
From Authors a
Join Books b 
ON a.AuthorID= B.AuthorID
GROUP BY a.AuthorID, a.Namee
HAVING COUNT(B.BookID)>5;

-- show books with category name
 Select * from Books b
 left join Categories c
 ON b.CategoryID = c.CategoryID;
 
 SELECT b.BookID,b.Tittle, C.C_Name, B.Price, b.Stock
 FROM books b
 join Categories c 
 ON b.CategoryID = c.CategoryID;
 
 -- find total sales amount for a given order.
 
