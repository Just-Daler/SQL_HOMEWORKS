--1
CREATE TABLE Employees (
    EmpID INT,
    Name VARCHAR(50),
    Salary DECIMAL(10, 2)
);
--2
INSERT INTO Employees (EmpID, Name, Salary)
VALUES 
 (1, 'Alice Johnson', 55000.00),
 (2, 'Bob Smith', 62000.50),
 (3, 'Charlie Brown', 48000.75);
--3
UPDATE Employees
SET Salary = 60000.00
WHERE EmpID = 1;
--4
DELETE FROM Employees
WHERE EmpID = 2;
--5
CREATE TABLE TestTable (
    ID INT,
    Name VARCHAR(50)
);
INSERT INTO TestTable (ID, Name) VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Charlie');
DELETE FROM TestTable
WHERE ID = 2;
TRUNCATE TABLE TestTable;
DROP TABLE TestTable;
--6
ALTER TABLE Employees
ALTER COLUMN Name VARCHAR(100);
--7
ALTER TABLE Employees
ADD Department VARCHAR(50);
--8
ALTER TABLE Employees
ALTER COLUMN Salary FLOAT;
select * from Employees
--9
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);
--10
TRUNCATE TABLE Employees;
--11
INSERT INTO Departments (DepartmentID, DepartmentName)
SELECT TOP 5 DepartmentID, DepartmentName
FROM OldDepartments;
--12
UPDATE Employees
SET Department = 'Management'
WHERE Salary > 5000;
--13
TRUNCATE TABLE employees;
--14
ALTER TABLE Employees
DROP COLUMN Department;
--15
EXEC sp_rename 'Employees', 'StaffMembers';
--16
DROP TABLE Departments;
--17
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Category VARCHAR(50),
    Price DECIMAL(10, 2),
    StockQuantity INT
);
--18
ALTER TABLE Products
ADD CONSTRAINT chk_price_positive CHECK (Price > 0);
--19
ALTER TABLE Products
ADD StockQuantity INT DEFAULT 50;
--20
EXEC sp_rename 'Products.Category', 'ProductCategory', 'COLUMN';
--21
INSERT INTO Products (ProductID, ProductName, ProductCategory, Price, StockQuantity)
VALUES (1, 'Laptop', 'Electronics', 799.99, 50),
  (2, 'Smartphone', 'Electronics', 499.99, 50),
  (3, 'Desk Chair', 'Furniture', 89.99, 50),
  (4, 'Book: SQL Basics', 'Books', 29.99, 50),
  (5, 'Coffee Maker', 'Home Appliances', 59.99, 50);
--22
SELECT * INTO Products_Backup
FROM Products;
select * from Products_Backup
--23
EXEC sp_rename 'Products_Backup', 'Inventory';
select * from Inventory
--24
ALTER TABLE Inventory
ALTER COLUMN Price FLOAT;
--25
ALTER TABLE Inventory
ADD ProductCode INT IDENTITY(1000, 5);
