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
