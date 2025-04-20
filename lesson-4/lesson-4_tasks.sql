--1
 SELECT TOP (5) * FROM Employees 
 --2
 SELECT DISTINCT  ProductName FROM Products
 --3
 SELECT Price FROM Products_Discounted
 WHERE Price >100
 --4
 SELECT * FROM Customers
 WHERE FirstName LIKE 'A%'
 --5
 SELECT * FROM Products
 ORDER BY  Price  ASC
 --6
 SELECT* FROM Employees
 WHERE Salary >=60000 AND DepartmentName='HR'
 --7
SELECT 
    EmployeeID,
    FirstName,
    LastName,
    ISNULL(Email, 'noemail@example.com') AS Email
FROM 
    Employees;
--8
SELECT* FROM Products
WHERE Price BETWEEN 50 AND 100
--9
SELECT DISTINCT Category,ProductName FROM Products
--10
SELECT DISTINCT Category,ProductName FROM Products
ORDER BY ProductName DESC
--11
SELECT TOP 10 ProductName,Price FROM Products
ORDER BY Price DESC
--12
SELECT TOP 1
    COALESCE(FirstName, LastName) AS NONNULL
FROM 
    Employees;
--13
SELECT DISTINCT Category,Price 
FROM Products;
--14
SELECT* FROM Employees
WHERE  AGE BETWEEN 30 AND 40 OR DepartmentName='MARKETING'
--15
SELECT * FROM Employees
ORDER BY SALARY DESC
OFFSET 11 ROWS
FETCH NEXT 9 ROWS ONLY;
--16
SELECT* FROM Products
WHERE Price<=1000 AND StockQuantity>50
ORDER BY StockQuantity ASC;
--17
SELECT* FROM Products
WHERE ProductName LIKE '%E%'
--18
SELECT FirstName,DepartmentName FROM Employees
WHERE DepartmentName IN ('HR','IT','FINANCE')
--19
SELECT * FROM Customers
ORDER BY City ASC, PostalCode DESC 
--20
SELECT TOP 10 ProductID,SaleAmount FROM Sales
ORDER BY SaleAmount DESC
--21
SELECT (FirstName+' '+LastName) AS FULL_NAME
FROM Employees
--22
SELECT DISTINCT  Category,ProductName,Price FROM Products
WHERE Price  >50
--23
SELECT PRICE FROM Products
WHERE Price < (SELECT AVG(PRICE)*0.10 FROM Products)
--24
select * 
from Employees
where Age<30 and DepartmentName='hr'
--25
SELECT* FROM Customers
WHERE  Email LIKE '%@gmail.com'
--26
SELECT * 
FROM Employees
WHERE Salary > ALL (
    SELECT Salary 
    FROM Employees
    WHERE DepartmentName = 'Marketing'
);

--27
SELECT * FROM Orders
WHERE OrderDate BETWEEN DATEADD(DAY,-180,GETDATE()) AND CAST(GETDATE() AS DATE)
ORDER BY  OrderDate DESC
