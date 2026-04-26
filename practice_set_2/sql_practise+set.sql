
CREATE DATABASE MYSQL_PRACTICALS;
USE MYSQL_PRACTICALS;
drop database practice;
create database practice;
use practice;

CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT,
    Gender VARCHAR(10)
);

INSERT INTO Student VALUES
(1,'Ram',21,'Male'),
(2,'Sana',27,'Female'),
(3,'John',25,'Male');


-- retriving data
select StudentID, Name, age from Student;
SELECT * FROM Student;

-- updating the table
update Student
set age = 30
where StudentID = 4;
select * from Student;

-- delete data
delete from student
where StudentID = 4;
 
-- truncate and drop
Truncate table Student;
Drop table student;

-- alter
alter table Student
Add location varchar(30);
-- update student
update student
set location ="bangalore"
where StudentID in (1,3);

update student
set location = "Mumbai"
where studentId = 2;


 
-- print count of students
select count(*) AS np_PF_Students 
from Student;

-- print students from banglore
select StudentID, Name 
 from student
where location = "bangalore";

-- print students from bangalore
select StudentID, Name, location
from student
where location = "bangalore";

-- unique or distinct location
select distinct location 
from student;

-- print top 2/asc 2
select name from student
limit 2;

-- commit , rool back save point
START TRANSACTION;

UPDATE Student_TCL
SET Age = 25
WHERE StudentID = 1;

-- Before commit (shows updated)
SELECT * FROM Student_TCL WHERE StudentID = 1;

COMMIT;

-- After commit (change permanent)
SELECT * FROM Student_TCL WHERE StudentID = 1;

START TRANSACTION;

UPDATE Student_TCL
SET Age = 30
WHERE StudentID = 2;

-- Before rollback (shows updated)
SELECT * FROM Student_TCL WHERE StudentID = 2;

ROLLBACK;

-- After rollback (original value restored)
SELECT * FROM Student_TCL WHERE StudentID = 2;

START TRANSACTION;

-- Step 1
UPDATE Student_TCL
SET Age = 40
WHERE StudentID = 3;

SAVEPOINT A;

-- Step 2
UPDATE Student_TCL
SET Age = 50
WHERE StudentID = 3;

-- Wrong change → undo only step 2
ROLLBACK TO A;

COMMIT;

-- Final result
SELECT * FROM Student_TCL WHERE StudentID = 3;

-- constraints
CREATE TABLE CourseDetails (
    CID INT PRIMARY KEY,
    CName VARCHAR(50),
    Amount INT
);

INSERT INTO CourseDetails VALUES
(1,'SQL',15000),
(2,'PowerBI',12000);

Select * from CourseDetails;

CREATE TABLE StudentDetails (
    SID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT,
    CID INT,
    FOREIGN KEY (CID) REFERENCES CourseDetails(CID)
);

INSERT INTO StudentDetails VALUES
(1,'Ram',21,1),
(2,'John',22,1),
(3,'Sana',23,2);

select * from Studentdetails;

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY AUTO_INCREMENT,
    ProductID INT,
    Quantity INT,
    OrderDate DATE
);

INSERT INTO Sales (ProductID, Quantity, OrderDate) VALUES
(1, 50, '2023-01-10'),
(1, 60, '2023-03-12'),
(1, 20, '2023-07-05'),

(2, 30, '2023-02-15'),
(2, 90, '2023-06-20'),

(3, 120, '2023-08-10'),
(3, 10, '2023-09-12'),

(4, 40, '2023-04-18'),
(4, 30, '2023-05-22');

-- orders of writing query
SELECT ProductID,
       SUM(Quantity) AS TotalQuantity,
       COUNT(*) AS NumberOfOrders
FROM Sales
WHERE OrderDate BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY ProductID
HAVING SUM(Quantity) > 100
ORDER BY TotalQuantity DESC
LIMIT 7;

Create database besant_bank;
use besant_bank;
CREATE TABLE AccountDetails (
    AccountID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(50),
    Age INT,
    CurrentBalance DECIMAL(10,2),
    Accounttype VARCHAR(20)
);

CREATE TABLE TransactionDetails (
    TransactionID INT PRIMARY KEY AUTO_INCREMENT,
    AccountID INT,
    Amount DECIMAL(10,2),
    TransactionType VARCHAR(10),
    TransactionDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (AccountID) REFERENCES AccountDetails(AccountID)
);

INSERT INTO AccountDetails (Name, Age, CurrentBalance) VALUES
('Ram',21,1000),
('Sana',25,2000),
('John',23,1500),
('Peter',30,500);

INSERT INTO TransactionDetails (AccountID, Amount, TransactionType) VALUES
(1,500,'CREDIT'),
(1,200,'DEBIT'),
(2,1000,'CREDIT');

-- INNER JOIN
SELECT a.Name, t.Amount
FROM AccountDetails a
INNER JOIN TransactionDetails t
ON a.AccountID = t.AccountID;

-- LEFT JOIN
SELECT a.Name, t.Amount
FROM AccountDetails a
LEFT JOIN TransactionDetails t
ON a.AccountID = t.AccountID;

-- RIGHT JOIN
SELECT a.Name, t.Amount
FROM AccountDetails a
RIGHT JOIN TransactionDetails t
ON a.AccountID = t.AccountID;

-- CROSS JOIN
SELECT a.Name, c.CName
FROM AccountDetails a
CROSS JOIN CourseDetails c;

-- SELF JOIN (EMPLOYEE TYPE EXAMPLE)
CREATE TABLE Employee1 (
    EmpID INT,
    Name VARCHAR(50),
    ManagerID INT
);

INSERT INTO Employee1 VALUES
(1,'A',NULL),
(2,'B',1),
(3,'C',1);

SELECT e1.Name AS Employee, e2.Name AS Manager
FROM Employee e1
LEFT JOIN Employee e2
ON e1.ManagerID = e2.EmpID;

CREATE TABLE Department (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50)
);
drop table employee;
CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    DeptID INT,
    ManagerID INT
);

INSERT INTO Department VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Finance'),
(4, 'Marketing');  -- no employee (for LEFT JOIN test)

INSERT INTO Employee VALUES
(101, 'Ram', 1, NULL),
(102, 'Sana', 2, 101),
(103, 'John', 2, 101),
(104, 'Peter', 3, 102),
(105, 'Amit', NULL, 102); -- no department (for RIGHT JOIN test)

-- inner join
SELECT e.EmpName, d.DeptName
FROM Employee e
INNER JOIN Department d
ON e.DeptID = d.DeptID;
-- left join
SELECT e.EmpName, d.DeptName
FROM Employee e
LEFT JOIN Department d
ON e.DeptID = d.DeptID;
-- right join
SELECT e.EmpName, d.DeptName
FROM Employee e
RIGHT JOIN Department d
ON e.DeptID = d.DeptID;

-- full outer join
SELECT e.EmpName, d.DeptName
FROM Employee e
LEFT JOIN Department d ON e.DeptID = d.DeptID

UNION

SELECT e.EmpName, d.DeptName
FROM Employee e
RIGHT JOIN Department d ON e.DeptID = d.DeptID;

-- cross join
SELECT e.EmpName, d.DeptName
FROM Employee e
CROSS JOIN Department d;

-- self join 
SELECT e1.EmpName AS Employee,
       e2.EmpName AS Manager
FROM Employee e1
LEFT JOIN Employee e2
ON e1.ManagerID = e2.EmpID; 

 -- SUBQUERY 
-- =====================================================
SELECT * FROM AccountDetails
WHERE AccountID IN (
    SELECT AccountID FROM TransactionDetails
);

-- derived table
SELECT *
FROM (
    SELECT CurrentBalance
    FROM AccountDetails
    ORDER BY CurrentBalance DESC
    LIMIT 5
) AS temp
ORDER BY CurrentBalance ASC
LIMIT 1;

SELECT *
FROM (
    SELECT CurrentBalance
    FROM AccountDetails
    ORDER BY CurrentBalance DESC
    LIMIT 2
) AS temp
ORDER BY CurrentBalance ASC
LIMIT 1;

SELECT *
FROM (
    SELECT CurrentBalance
    FROM AccountDetails
    ORDER BY CurrentBalance DESC
    LIMIT 3
) AS temp
ORDER BY CurrentBalance ASC
LIMIT 1;

-- Nth highest
SELECT *
FROM (
    SELECT CurrentBalance
    FROM AccountDetails
    ORDER BY CurrentBalance DESC
    LIMIT N
) AS temp
ORDER BY CurrentBalance ASC
LIMIT 1;

CREATE VIEW AccountView AS
SELECT *
FROM AccountDetails
WHERE AccountID IN (
    SELECT AccountID FROM TransactionDetails
);

SELECT * FROM AccountView;

INSERT INTO TransactionDetails (AccountID, Amount)
VALUES (3, 700);

-- Run view again
SELECT * FROM TransactionView;

CREATE TABLE AccountDetails (
    AccountID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(50),
    CurrentBalance INT
);

CREATE TABLE TransactionDetails (
    TransactionID INT PRIMARY KEY AUTO_INCREMENT,
    AccountID INT,
    Amount INT,
    TransactionDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (AccountID) REFERENCES AccountDetails(AccountID)
);

INSERT INTO AccountDetails (Name, CurrentBalance) VALUES
('Ram',1000),
('Sana',2000),
('John',1500);

INSERT INTO TransactionDetails (AccountID, Amount) VALUES
(1,500),
(1,-200),
(2,1000);

CALL Get_Transaction(1);
CALL Mini_Statement(1);

CREATE TABLE AccountDetails (
    AccountID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(50),
    Age INT,
    CurrentBalance INT
);

INSERT INTO AccountDetails (Name, Age, CurrentBalance) VALUES
('Ram',21,1000),
('Sana',25,2000),
('John',23,1500),
('Peter',30,500),
('Amit',28,1200);
-- create indexes
CREATE INDEX idx_name
ON AccountDetails(Name);

-- create index on multiple coloums
CREATE INDEX idx_name_age
ON AccountDetails(Name, Age);

-- unique index
CREATE UNIQUE INDEX idx_unique_name
ON AccountDetails(Name);

-- drop index
DROP INDEX idx_name ON AccountDetails;

-- Trigger query
CREATE TABLE AccountDetails (
    AccountID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(50),
    CurrentBalance INT DEFAULT 0
);
drop table transactionDetails;
CREATE TABLE TransactionDetails (
    TransactionID INT PRIMARY KEY AUTO_INCREMENT,
    AccountID INT,
    Amount INT,
    TransactionType VARCHAR(10), -- CREDIT / DEBIT
    FOREIGN KEY (AccountID) REFERENCES AccountDetails(AccountID)
);

INSERT INTO AccountDetails (Name, CurrentBalance) VALUES
('Ram',0),
('Sana',0);

DELIMITER //

CREATE TRIGGER UpdateBalance
AFTER INSERT ON TransactionDetails
FOR EACH ROW
BEGIN
    IF NEW.TransactionType = 'CREDIT' THEN
        UPDATE AccountDetails
        SET CurrentBalance = CurrentBalance + NEW.Amount
        WHERE AccountID = NEW.AccountID;
    ELSE
        UPDATE AccountDetails
        SET CurrentBalance = CurrentBalance - NEW.Amount
        WHERE AccountID = NEW.AccountID;
    END IF;
END //

DELIMITER ;

CALL error_handling();

CALL ExceptionHandling;

-- functions
SELECT SUM(CurrentBalance) FROM AccountDetails;
SELECT MAX(CurrentBalance) FROM AccountDetails;
SELECT MIN(CurrentBalance) FROM AccountDetails;
SELECT COUNT(*) FROM AccountDetails;
SELECT AVG(CurrentBalance) FROM AccountDetails;

-- TEXT
SELECT UPPER(Name), LOWER(Name), LENGTH(Name)
FROM AccountDetails;

-- DATE
SELECT NOW();
SELECT CURRENT_DATE();
-- ranking and windows functions
SELECT Name, CurrentBalance,
RANK() OVER (ORDER BY CurrentBalance DESC) AS rnk,
DENSE_RANK() OVER (ORDER BY CurrentBalance DESC) AS drnk,
ROW_NUMBER() OVER (ORDER BY CurrentBalance DESC) AS rowno
FROM AccountDetails;

-- user define functions
-- age calculator created
-- bmi calculator created

-- cursor and wild cards
CALL GetAllAccounts();
drop  table AccountDetails;
CREATE TABLE AccountDetails1 (
    AccountID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT,
    AccountType VARCHAR(20),
    CurrentBalance INT,
    AccountStatus VARCHAR(20)
);

INSERT INTO AccountDetails1 VALUES
(1,'Ram',21,'Saving',2000,'Active'),
(2,'Sana',23,'Current',500,'Active'),
(3,'John',25,'Saving',3000,'Inactive');
ALTER TABLE AccountDetails
ADD Age INT,
ADD AccountType VARCHAR(20);

UPDATE AccountDetails
SET Age = 21, AccountType = 'Saving'
WHERE AccountID = 1;

UPDATE AccountDetails
SET Age = 23, AccountType = 'Current'
WHERE AccountID = 2;
-- call 
CALL GetAccountDetails1();

DROP TABLE IF EXISTS AccountDetails;

CREATE TABLE AccountDetails (
    AccountID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT,
    AccountType VARCHAR(20),
    CurrentBalance INT,
    AccountStatus VARCHAR(20)
);

SELECT * 
FROM AccountDetails
WHERE Name LIKE 'pattern';

SELECT * 
FROM AccountDetails
WHERE Name LIKE 'R%';

SELECT * 
FROM AccountDetails
WHERE Name LIKE '%a';

SELECT * 
FROM AccountDetails
WHERE Name LIKE '%n%';

SELECT * 
FROM AccountDetails
WHERE Name NOT LIKE 'R%';

CREATE TABLE AccountDetails2 (
    AccountID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT,
    AccountType VARCHAR(20),
    CurrentBalance INT
);
INSERT INTO AccountDetails2 VALUES
(1,'Ram',21,'Saving',2000),
(2,'Sana',23,'Current',500),
(3,'John',25,'Saving',3000),
(4,'Amit',28,'Saving',4000),
(5,'Neha',27,'Current',700),
(6,'Riya',24,'Saving',2000),
(7,'Karan',30,'Current',10000),
(8,'Pooja',22,'Saving',5000);

WITH AccountSummary AS (
    SELECT 
        AccountType,
        SUM(CurrentBalance) AS TotalBalance,
        AVG(Age) AS AverageAge
    FROM AccountDetails2
    GROUP BY AccountType
)

SELECT 
    AccountType, 
    TotalBalance, 
    AverageAge
FROM AccountSummary;







