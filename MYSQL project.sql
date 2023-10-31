DROP DATABASE IF EXISTS library;

-- Create the "library" database if it doesn't exist
CREATE DATABASE IF NOT EXISTS library;

-- Use the "library" database
USE library;

-- Create the "Branch" table
CREATE TABLE Branch (
    Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(255),
    Contact_no VARCHAR(15)
);

-- Create the "Employee" table
CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(255),
    Position VARCHAR(255),
    Salary DECIMAL(10, 2)
);

-- Create the "Customer" table
CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(255),
    Customer_address VARCHAR(255),
    Reg_date DATE
);

-- Create the "Books" table
CREATE TABLE Books (
    ISBN VARCHAR(13) PRIMARY KEY,
    Book_title VARCHAR(255),
    Category VARCHAR(255),
    Rental_Price DECIMAL(10, 2),
    Status ENUM('yes', 'no'),
    Author VARCHAR(255),
    Publisher VARCHAR(255)
);

-- Create the "IssueStatus" table
CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issued_book_name VARCHAR(255),
    Issue_date DATE,
    Isbn_book VARCHAR(13),
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);

-- Create the "ReturnStatus" table
CREATE TABLE ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(255),
    Return_date DATE,
    Isbn_book2 VARCHAR(13),
    FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);

SELECT Book_title, Category, Rental_Price
FROM Books
WHERE Status = 'yes';

SELECT Emp_name, Salary
FROM Employee
ORDER BY Salary DESC;

SELECT B.Book_title, C.Customer_name
FROM IssueStatus AS I
INNER JOIN Books AS B ON I.Isbn_book = B.ISBN
INNER JOIN Customer AS C ON I.Issued_cust = C.Customer_Id;

SELECT Category, COUNT(*) AS BookCount
FROM Books
GROUP BY Category;

SELECT Emp_name, Position
FROM Employee
WHERE Salary > 50000;

SELECT Customer_name
FROM Customer
WHERE Reg_date < '2022-01-01' AND Customer_Id NOT IN (SELECT DISTINCT Issued_cust FROM IssueStatus);

ALTER TABLE Employee
ADD Branch_ID INT,
ADD FOREIGN KEY (Branch_ID) REFERENCES Branch(Branch_no);

SELECT Branch_ID, COUNT(*) AS EmployeeCount
FROM Employee
GROUP BY Branch_ID;

SELECT DISTINCT C.Customer_name
FROM Customer AS C
INNER JOIN IssueStatus AS I ON C.Customer_Id = I.Issued_cust
WHERE YEAR(Issue_date) = 2023 AND MONTH(Issue_date) = 6;

SELECT Book_title
FROM Books
WHERE Category = 'history';

SELECT E.Branch_ID, COUNT(*) AS EmployeeCount
FROM Employee AS E
GROUP BY E.Branch_ID
HAVING EmployeeCount > 5;




