--1

SELECT a.OrderID,
       b.FirstName,
       OrderDate
FROM Orders AS a
JOIN Customers AS b ON a.CustomerID=b.CustomerID
AND year(a.OrderDate)>2022
ORDER BY a.OrderDate DESC 
  --2

SELECT a.Name,
       b.DepartmentName
FROM Employees AS a
JOIN Departments AS b ON a.DepartmentID=b.DepartmentID
AND b.DepartmentName IN('Sales ',
                        'Marketing' )
  --3

SELECT *
FROM Departments
SELECT b.DepartmentName,
       max(a.Salary) AS MaxSalary
FROM Employees AS a
JOIN Departments AS b ON a.DepartmentID=b.DepartmentID
GROUP BY b.DepartmentName 
  
  --4 List all customers from the USA who placed orders in the year 2023.

SELECT a.FirstName,
       b.OrderID,
       b.OrderDate
FROM Customers AS a
JOIN Orders AS b ON a.CustomerID=b.CustomerID
AND a.Country='USA'
AND year(b.OrderDate)=2023 
  
  --5

SELECT b.FirstName,
       count(a.OrderID) AS total_orders,
       sum(a.Quantity) AS total_quantiti
FROM Orders AS a
JOIN Customers AS b ON a.CustomerID=b.CustomerID
GROUP BY b.FirstName 
  --6

SELECT a.ProductName,
       b.SupplierName
FROM Products AS a
JOIN Suppliers AS b ON a.SupplierID=b.SupplierID
AND b.SupplierName IN('Gadget Supplies',
                      'Clothing Mart')
ORDER BY b.SupplierName DESC 
  --7

SELECT A.FirstName,
       MAX(B.OrderDate) AS MostRecentOrderDate
FROM Customers AS A
LEFT JOIN Orders AS B ON A.CustomerID=B.CustomerID
GROUP BY A.FirstName
ORDER BY MAX(B.OrderDate) DESC
  --8

SELECT CONCAT(A.FirstName, ' ', A.LastName),
       B.TotalAmount AS OrderTotal
FROM Customers AS A
JOIN Orders AS B ON A.CustomerID=B.CustomerID
AND B.TotalAmount>500 
  --9

SELECT a.ProductName,
       b.SaleDate,
       b.SaleAmount
FROM Products AS a
JOIN Sales AS b ON a.ProductID=b.ProductID
WHERE year(b.SaleDate)=2022
  OR b.SaleAmount>400
  --10

  SELECT a.ProductName,
         sum(b.SaleAmount) AS totalsaleamount
  FROM Products AS a
  JOIN Sales AS b ON a.ProductID=b.ProductID
GROUP BY a.ProductName 
  --11

SELECT a.Name,
       b.DepartmentName,
       a.Salary
FROM Employees AS a
JOIN Departments AS b ON a.DepartmentID=b.DepartmentID
AND b.DepartmentName='human resources'
AND a.Salary>60000 
  --12

SELECT a.ProductName,
       b.SaleDate,
       a.StockQuantity
FROM Products AS a
JOIN Sales AS b ON a.ProductID=b.ProductID
AND year(b.SaleDate)=2023
AND a.StockQuantity>100 
  --13

SELECT a.Name,
       b.DepartmentName,
       a.HireDate
FROM Employees AS a
JOIN Departments AS b ON a.DepartmentID=b.DepartmentID
WHERE b.DepartmentName='sales'
  OR year(a.HireDate)>2020 
  --14

  SELECT concat(a.FirstName, ' ', a.LastName),
         b.OrderID,
         a.Address,
         b.OrderDate
  FROM Customers AS a
  JOIN Orders AS b ON a.CustomerID=b.CustomerID
  AND a.Country='usa' WHERE a.Address like '____%'
  --15

  SELECT a.ProductName,
         a.Category,
         b.SaleAmount
  FROM Products AS a
  JOIN Sales AS b ON a.ProductID=b.ProductID WHERE a.Category=1
  OR b.SaleAmount>350 
  --16

  SELECT B.CategoryName,
         COUNT(A.ProductID) AS ProductCount
  FROM Products AS a
  JOIN Categories AS b ON a.Category=B.CategoryID
GROUP BY B.CategoryName
SELECT B.CategoryName,
       SUM(A.StockQuantity) AS ProductCount
FROM Products AS a
JOIN Categories AS b ON a.Category=B.CategoryID
GROUP BY B.CategoryName 
  --17

SELECT concat(a.FirstName, ' ', a.LastName)AS FULLNAME,
       B.OrderID,
       A.City,
       B.TotalAmount
FROM Customers AS a
JOIN Orders AS b ON a.CustomerID=b.CustomerID
AND a.City='LOS ANGELES'
AND B.TotalAmount>300 
  --18

SELECT a.Name,
       b.DepartmentName,
       a.Salary
FROM Employees AS a
JOIN Departments AS b ON a.DepartmentID=b.DepartmentID
WHERE b.DepartmentName='human resources'
  OR b.DepartmentName='Finance'
  OR (LEN(a.Name) - LEN(REPLACE(LOWER(a.Name), 'a', ''))) + (LEN(a.Name) - LEN(REPLACE(LOWER(a.Name), 'e', ''))) + (LEN(a.Name) - LEN(REPLACE(LOWER(a.Name), 'i', ''))) + (LEN(a.Name) - LEN(REPLACE(LOWER(a.Name), 'o', ''))) + (LEN(a.Name) - LEN(REPLACE(LOWER(a.Name), 'u', ''))) >= 4;

--19

SELECT a.Name,
       b.DepartmentName,
       a.Salary
FROM Employees AS a
JOIN Departments AS b ON a.DepartmentID=b.DepartmentID
AND A.Salary>60000
WHERE b.DepartmentName='SALES'
  OR b.DepartmentName='MARKETING'
