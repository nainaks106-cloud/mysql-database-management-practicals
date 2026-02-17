CREATE DATABASE College;
 create database ABC_Company;
 
 DROP DATABASE abc_Company;
 
 USE College;
 
 CREATE TABLE student (
rollno INT,
sname VARCHAR(20),
age int
);
INSERT INTO student
VALUES
(01, "ADAM", 13),
(02, "ANNA", 14);

SELECT * FROM student;

CREATE DATABASE IF NOT EXISTS college;

CREATE DATABASE Instagram;

DROP DATABASE ABC_COMPANY;
DROP DATABASE IF EXISTS ABC_Company;

SHOW DATABASES;

SHOW TABLES;

USE college;

USE instagram;

-- using constraints check
CREATE TABLE user_information (
id INT,
age INT,
username VARCHAR(30) NOT NULL,
email VARCHAR(30) UNIQUE,
followers INT,
Ufollowing INT,
CONSTRAINT age_check CHECK (age >=18) 
);

-- adding primary key first way 
CREATE TABLE user_information1 (
id INT PRIMARY KEY,
age INT,
username VARCHAR(30) NOT NULL,
email VARCHAR(30) UNIQUE,
followers INT,
Ufollowing INT,
CONSTRAINT CHECK (age >=18) 
);

-- adding primary key secound way
CREATE TABLE user_information2 (
id INT,
age INT,
username VARCHAR(30) NOT NULL,
email VARCHAR(30) UNIQUE,
followers INT,
Ufollowing INT,
CONSTRAINT CHECK (age >=18),
PRIMARY KEY (ID)
);

-- adding foreign key
CREATE TABLE post (
p_id INT PRIMARY Key,
content VARCHAR (100),
user_id INT,
FOREIGN KEY (user_id) REFERENCES user_information2(id)
);

--
USE instagram;
-- creating table ,adding values  and primary key foreign key 
CREATE TABLE users (
id INT,
age INT,
username VARCHAR(30) NOT NULL,
email VARCHAR(30) UNIQUE,
followers INT DEFAULT 0,
unfollowing INT,
CONSTRAINT CHECK (age >=23),
PRIMARY KEY (ID)
);
select * from users;
ALTER TABLE users CHANGE COLUMN Ufollowing unfollowing INT;

insert into users
(id, age, username, email, followers, unfollowing)
VALUES
(1, 24, "ADAM", "ADAM@YAHOO.COM", 100, 400),
(2, 21, "EVA", "EVA@YAHOO.COM", 200, 500),
(3, 25, "EMILY", "EMILY@YAHOO.COM", 500, 400),
(4, 18, "AMIR", "AMIR@YAHOO.COM", 600, 300);

select * from users;

-- where clause
SELECT * FROM users 
WHERE unfollowing > 300;

-- change the sequence of column
SELECT unfollowing, email, username
FROM users
WHERE age < 24;

-- using operators in where clause
SELECT * FROM users
WHERE age+1= 25;
-- and operator
SELECT username, age
FROM users 
WHERE age> 22 AND followers > 300;

-- BETWEEN OPERATOR
SELECT username, age
FROM users 
WHERE age BETWEEN  20 AND 23;

-- IN OPERATOR
SELECT *
FROM users 
WHERE email IN ("ADAM@YAHOO.COM","EMILY@YAHOO.COM");

-- NOT IN OPERATOR
SELECT *
FROM users 
WHERE email NOT IN ("ADAM@YAHOO.COM","EMILY@YAHOO.COM");

-- LIMIT CLAUSE
SELECT * FROM users
LIMIT 3;

SELECT * FROM users
WHERE age >22
LIMIT 3;

-- order by clause
SELECT *
FROM users 
ORDER BY age;

SELECT *
FROM users 
ORDER BY age ASC;

SELECT *
FROM users 
ORDER BY age DESC;

-- aggregate function
SELECT MAX(age) 
FROM users;

SELECT MIN(age) 
FROM users;

SELECT count(age)
FROM users 
WHERE age = 24;

SELECT avg(followers)
FROM users;

SELECT sum(followers)
FROM users;

select * from users;

SELECT age, count(id)
from users
group by age;

SELECT age
from users
group by age;

SELECT age, max(followers)
FROM users
GROUP BY age
HAVING max(followers) > 50;

SELECT age, max(followers)
FROM users
GROUP BY age
HAVING max(followers)> 200
order by age DESC;
