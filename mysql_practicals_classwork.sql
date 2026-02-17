-- create database 
CREATE DATABASE Bank;

-- use db
USE Bank;

CREATE TABLE Accountdetails (
     AccountID INT PRIMARY KEY,
     NAME CHAR(30) NOT NULL,
     Age TINYINT CHECK(Age > 18),
     Accounttype VARCHAR(20),
     Currentbalance INT
);

INSERT INTO Accountdetails VALUES
(1, "Ram", 21, "saving", 2000);

show tableS;

SELECT * FROM Accountdetails;

CREATE TABLE Transactiondetails(
	TransactionID INT PRIMARY KEY AUTO_INCREMENT,
    AccountID INT,
    Transactiontype VARCHAR(10) CHECK(Transactiontype ='Credit'OR transactiontype ='Debit'),
    Transactionammount INT,
    Transactiontime DATETIME DEFAULT(NOW()),
    FOREIGN KEY(AccountID) REFERENCES Accountdetails (AccountID)
    );
    select * from Transaction details;
    
    INSERT INTO Transactiondetails (AccountID, Transactiontype, Transactionammount)
    VALUES
    (1, 'Credit', 1000),
    (1, 'Debit', 500);
    
    -- Create Database (if not already created)
CREATE DATABASE IF NOT EXISTS practice;

USE practice;

-- Create Department Table
CREATE TABLE department (
    DepartmentID INT PRIMARY KEY,
    DeptName VARCHAR(50) NOT NULL
);

-- Create Employee Table
CREATE TABLE employee (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50) NOT NULL,
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) 
        REFERENCES department(DepartmentID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Insert into department
INSERT INTO department VALUES
(101, 'IT'),
(102, 'HR'),
(103, 'Sales');

-- Insert into employee
INSERT INTO employee VALUES
(1, 'Ram', 101),
(2, 'Sham', 102),
(3, 'Peter', 101),
(4, 'John', 103);


    SELECT * FROM employee;
SELECT * FROM department;

-- INNER JOIN
SELECT e.EmpID, e.EmpName, d.DeptName
FROM employee AS e
INNER JOIN department AS d
ON e.DepartmentID = d.DepartmentID;

SELECT *
FROM employee AS e
INNER JOIN department AS d
ON e.DepartmentID = d.DepartmentID;

-- LEFT OUTER JOIN
SELECT e.EmpID, e.EmpName, d.DepartmentID, d.DeptName
FROM employee AS e
LEFT JOIN department AS d
ON e.DepartmentID = d.DepartmentID;

-- RIGHT OUTER JOIN
SELECT e.EmpID, e.EmpName, d.DepartmentID, d.DeptName
FROM employee AS e
RIGHT JOIN department AS d
ON e.DepartmentID = d.DepartmentID;

-- RIGHT OUTER JOIN
SELECT e.EmpID, e.EmpName, d.DepartmentID, d.DeptName
FROM employee AS e
RIGHT JOIN department AS d
ON e.DepartmentID = d.DepartmentID;

-- FULL OUTER JOIN
SELECT e.EmpID, e.EmpName, d.DepartmentID, d.DeptName
FROM employee AS e
LEFT JOIN department AS d
ON e.DepartmentID = d.DepartmentID

UNION

SELECT e.EmpID, e.EmpName, d.DepartmentID, d.DeptName
FROM employee AS e
RIGHT JOIN department AS d
ON e.DepartmentID = d.DepartmentID;

SELECT e.EmpID, e.EmpName, d.DepartmentID, d.DeptName
FROM employee AS e
LEFT JOIN department AS d
ON e.DepartmentID = d.DepartmentID

UNION ALL

SELECT e.EmpID, e.EmpName, d.DepartmentID, d.DeptName
FROM employee AS e
RIGHT JOIN department AS d
ON e.DepartmentID = d.DepartmentID;

-- CROSS JOIN
SELECT e.EmpID, e.EmpName, d.DepartmentID, d.DeptName
FROM employee AS e
CROSS JOIN department AS d;

CREATE TABLE company (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    manager_id INT
);

INSERT INTO company VALUES
(1, 'john', 0),
(2, 'alice', 1),
(3, 'bob', 1),
(4, 'mary', 2);

-- Self Join (LEFT JOIN)
SELECT c.emp_name AS employee_name,
       m.emp_name AS manager_name
FROM company c
LEFT JOIN company m
ON c.manager_id = m.emp_id;

-- Self Join (INNER JOIN)
SELECT c.emp_name AS employee_name,
       m.emp_name AS manager_name
FROM company c
JOIN company m
ON c.manager_id = m.emp_id;

use besantbank;
select * from accountdetails;

CREATE TABLE Transactiondetails (
    TransactionID INT PRIMARY KEY AUTO_INCREMENT,
    AccountID INT,
    Transactiontype VARCHAR(10),
    Transactionamount INT,
    Transactiontime DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT chk_transactiontype 
    CHECK (Transactiontype IN ('Credit', 'Debit')),
    
    CONSTRAINT fk_account
    FOREIGN KEY (AccountID) 
    REFERENCES Accountdetails(AccountID)
    ON DELETE CASCADE
);

INSERT INTO Accountdetails 
(AccountID, NAME, Age, Accounttype, Currentbalance)
VALUES
(4, 'Sana', 23, 'Current', 500),
(5, 'John', 27, 'Saving', 1000),
(6, 'Peter', 25, 'Saving', 1500),
(7, 'Kiran', 27, 'Current', 5200),
(8, 'Priya', 21, 'Saving', 5500),
(9, 'Varun', 28, 'Current', 500),
(10, 'Sonu', 29, 'Saving', 2500),
(11, 'Kumar', 28, 'Saving', 2000),
(12, 'Jathin', 27, 'Current', 5000),
(13, 'Suma', 22, 'Saving', 1500);

INSERT INTO Transactiondetails (AccountID, Transactiontype, Transactionamount)
VALUES
(7, 'Credit',1000);
select DISTINCT(AccountID) from transactiondetails;

SELECT * FROM Accountdetails WHERE AccountID IN (1,7);

SELECT * FROM Accountdetails
WHERE AccountID In(
    select distinct(AccountID) FROM Transactiondetails);
    
    -- derive table
    
    select Currentbalance From Accountdetails
    ORDER BY Currentbalance DESC
    LIMIT 5;
    
    SELECT MIN(Currentbalance) 
    
    
    
    
    
    
    
    


















    
    