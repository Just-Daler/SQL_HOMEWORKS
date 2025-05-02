--1Using the Employees and Departments tables, write a query to return the names and salaries of employees whose salary is greater than 50000, along with their department names.
-- Expected Columns: EmployeeName, Salary, DepartmentName

SELECT a.Name,
       a.Salary,
       b.DepartmentName
FROM Employees AS a
JOIN Departments AS b ON a.DepartmentID=b.DepartmentID
WHERE a.Salary>50000 
  --2 Using the Customers and Orders tables, write a query to display customer names and order dates for orders placed in the year 2023.

  SELECT a.FirstName,
         a.LastName,
         b.OrderDate
  FROM Customers AS a
  RIGHT JOIN Orders AS b ON a.CustomerID=b.CustomerID WHERE YEAR(b.OrderDate)=2023 
  --3 Using the Employees and Departments tables, write a query to show all employees along with their department names. Include employees who do not belong to any department.

  SELECT a.Name,
         b.DepartmentName
  FROM Employees AS a
  LEFT JOIN Departments AS b ON a.DepartmentID=b.DepartmentID 
  --4  Using the Products and Suppliers tables, write a query to list all suppliers and the products they supply. Show suppliers even if they don’t supply any product.

  SELECT a.SupplierName,
         b.ProductName
  FROM Suppliers AS a
  LEFT JOIN Products AS b ON a.SupplierID=b.SupplierID
  --5 Using the Orders and Payments tables, write a query to return all orders and their corresponding payments. Include orders without payments and payments not linked to any order.

  SELECT *
  FROM Orders AS a
  FULL JOIN Payments AS b ON a.OrderID=b.OrderID 
  --6 Using the Employees table, write a query to show each employee's name along with the name of their manager.

  SELECT emp_name.Name,
         managers.Name
  FROM Employees AS emp_name
  LEFT JOIN Employees AS managers ON emp_name.ManagerID=managers.EmployeeID 
  --7 using the Students, Courses, and Enrollments tables, write a query to list the names of students who are enrolled in the course named 'Math 101'.

  SELECT a.Name,
         c.CourseName
  FROM Students AS a
  JOIN Enrollments AS b ON a.StudentID=b.StudentID
  JOIN Courses AS c ON b.CourseID=c.CourseID WHERE c.CourseName like 'Math 101' 
  --8 Using the Customers and Orders tables, write a query to find customers who have placed an order with more than 3 items. Return their name and the quantity they ordered.

  SELECT a.FirstName,
         b.Quantity
  FROM Customers AS a
  JOIN Orders AS B ON A.CustomerID=B.CustomerID WHERE b.Quantity>3
  --9 Using the Employees and Departments tables, write a query to list employees working in the 'Human Resources' department.

  SELECT a.Name,
         b.DepartmentName
  FROM Employees AS a
  JOIN Departments AS b ON a.DepartmentID=b.DepartmentID WHERE b.DepartmentName like 'Human Resources' 
  --10 using the Employees and Departments tables, write a query to return department names that have more than 5 employees.

  SELECT b.DepartmentName,
         count(a.EmployeeID) AS EmployeeCount 
  FROM Employees AS a
  JOIN Departments AS b ON a.DepartmentID=b.DepartmentID 
GROUP BY b.DepartmentName
HAVING count(a.EmployeeID)>5 
  --11 Using the Products and Sales tables, write a query to find products that have never been sold.

SELECT a.ProductID,
       a.ProductName
FROM Products AS a
LEFT JOIN Sales AS b ON a.ProductID=b.ProductID 
WHERE b.SaleID IS NULL
  --12 Using the Customers and Orders tables, write a query to return customer names who have placed at least one order.

  SELECT a.FirstName,
         a.LastName,
         count(b.OrderID)
  FROM Customers AS a
  LEFT JOIN Orders AS b ON a.CustomerID=b.CustomerID 
GROUP BY a.FirstName,
         a.LastName
HAVING count(b.OrderID)>0 
  --13  Using the Employees and Departments tables, write a query to show only those records where both employee and department exist (no NULLs).

SELECT a.Name,
       b.DepartmentName
FROM Employees AS a 
JOIN Departments AS b ON a.DepartmentID=b.DepartmentID
  --14 Using the Employees table, write a query to find pairs of employees who report to the same manager.

SELECT emp.Name,
       emp2.Name,
       mang.EmployeeID 
FROM Employees AS emp
JOIN Employees AS emp2 ON emp.ManagerID=emp2.ManagerID
JOIN Employees AS mang ON mang.EmployeeID IN (emp.ManagerID, 
                                              emp2.ManagerID) 
WHERE emp.Name<>emp2.Name 
  --15 Using the Orders and Customers tables, write a query to list all orders placed in 2022 along with the customer name.

  SELECT b.OrderID, 
         b.OrderDate, 
         a.FirstName, 
         a.LastName
  FROM Customers AS a
  JOIN Orders AS B ON A.CustomerID=B.CustomerID WHERE year(b.OrderDate)=2022 
  --16 Using the Employees and Departments tables, write a query to return employees from the 'Sales' department whose salary is above 60000.

  SELECT a.Name, 
         a.Salary, 
         b.DepartmentName
  FROM Employees AS a
  JOIN Departments AS b ON a.DepartmentID=b.DepartmentID WHERE b.DepartmentName like 'Sales'
  AND a.Salary>60000 
  --17 Using the Orders and Payments tables, write a query to return only those orders that have a corresponding payment.

  SELECT a.OrderID,
         a.OrderDate,
         b.PaymentDate,
         b.Amount
  FROM Orders AS a
  JOIN Payments AS b ON a.OrderID=b.OrderID 
  --18 Using the Products and Orders tables, write a query to find products that were never ordered.

  SELECT a.ProductID,
         a.ProductName
  FROM Products AS a
  LEFT JOIN Orders AS b ON a.ProductID=b.ProductID WHERE b.OrderID IS NULL 
  --19 Using the Employees table, write a query to find employees whose salary is greater than the average salary in their own departments.

  SELECT e.EmployeeID,
         e.Name,
         e.DepartmentID,
         e.Salary
  FROM Employees e
  JOIN
    (SELECT DepartmentID,
            AVG(Salary) AS AvgSalary
     FROM Employees
     GROUP BY DepartmentID) dept_avg ON e.DepartmentID = dept_avg.DepartmentID WHERE e.Salary > dept_avg.AvgSalary;


SELECT e.EmployeeID,
       e.Name,
       e.DepartmentID,
       e.Salary
FROM Employees e
WHERE e.Salary >
    (SELECT AVG(Salary)
     FROM Employees
     WHERE DepartmentID = e.DepartmentID);

--20 Using the Orders and Payments tables, write a query to list all orders placed before 2020 that have no corresponding payment.

SELECT a.OrderID,
       a.OrderDate
FROM Orders AS a
LEFT JOIN Payments AS b ON a.OrderID=b.OrderID
WHERE year(a.OrderDate)<2020
  AND b.OrderID IS NULL 
  --21 Using the Products and Categories tables, write a query to return products that do not have a matching category.

  SELECT a.ProductID,
         a.ProductName
  FROM Products AS a
  LEFT JOIN Categories AS b ON a.Category=b.CategoryID WHERE b.CategoryID IS NULL 
  --22 Using the Employees table, write a query to find employees who report to the same manager and earn more than 60000.

  SELECT a.Name,
         a.Salary,
         b.Name,
         B.Salary,
         c.Name,
         c.Salary
  FROM Employees AS A
  JOIN Employees AS B ON B.ManagerID=A.ManagerID
  JOIN Employees AS c ON a.ManagerID=c.EmployeeID WHERE A.Name<>B.Name
  AND a.Salary> 60000
  AND b.Salary> 60000 
  --23 Using the Employees and Departments tables, write a query to return employees who work in departments which name starts with the letter 'M'.

  SELECT a.Name,
         b.DepartmentName
  FROM Employees AS a
  JOIN Departments AS b ON a.DepartmentID=b.DepartmentID WHERE b.DepartmentName like 'M%' 
  --24 Using the Products and Sales tables, write a query to list sales where the amount is greater than 500, including product names.

  SELECT b.SaleID,
         a.ProductName,
         b.SaleAmount
  FROM Products AS a
  JOIN Sales AS b ON a.ProductID=b.ProductID WHERE b.SaleAmount>500 
  --25 Using the Students, Courses, and Enrollments tables, write a query to find students who have not enrolled in the course 'Math 101'.

  SELECT a.StudentID,
         a.Name
  FROM Students AS a
  LEFT JOIN Enrollments AS b ON a.StudentID=b.StudentID
  LEFT JOIN Courses AS c ON b.CourseID=c.CourseID
  AND c.CourseName = 'Math 101' WHERE c.CourseName IS NULL
  SELECT a.StudentID,
         a.Name
  FROM Students AS a WHERE a.StudentID NOT IN
    (SELECT b.StudentID
     FROM Enrollments AS b
     JOIN Courses AS c ON b.CourseID=c.CourseID
     WHERE c.CourseName= 'Math 101');

--26 Using the Orders and Payments tables, write a query to return orders that are missing payment details

SELECT a.OrderID,
       a.OrderDate,
       b.PaymentID
FROM Orders AS a
LEFT JOIN Payments AS b ON a.OrderID=b.OrderID
WHERE b.PaymentID IS NULL 
  ---27 Using the Products and Categories tables, write a query to list products that belong to either the 'Electronics' or 'Furniture' category.

  SELECT a.ProductID,
         a.ProductName,
         b.CategoryName
  FROM Products AS a
  LEFT JOIN Categories AS b ON a.Category = b.CategoryID WHERE b.CategoryName IN ('Electronics',
                                                                                  'Furniture');
