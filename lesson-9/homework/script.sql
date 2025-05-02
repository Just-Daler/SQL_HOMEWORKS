--1
select a.ProductName, b.SupplierName from Products as a
cross join Suppliers as b
--2
select a.DepartmentName, b.Name from Departments as a
cross join Employees as b
--3
select b.SupplierName,a.ProductName from Products as a
join Suppliers as b
on a.SupplierID=b.SupplierID
--4
select a.FirstName,b.OrderID from Customers as a
join Orders as b
on a.CustomerID=b.CustomerID
--5
select a.CourseName,b.Name from Courses as a
cross join Students as b
--6
Select a.ProductName, b.Quantity from Products as a
join Orders as b
on a.ProductID=b.ProductID
--7
Select a.DepartmentID,b.Name  from Departments as a
 join Employees as b
on a.DepartmentID=b.DepartmentID
--8
select a.Name , b.CourseID from Students as a
join Enrollments as b
on a.StudentID=b.StudentID
--9
select a.OrderID from Orders as a
join Payments as b
on a.OrderID=b.OrderID 
--10
select a.OrderID, b.ProductName from Orders as a
join Products as b
on a.ProductID=b.ProductID
where b.Price>100
--11
select a.Name,b.DepartmentName from Employees as a 
join Departments as b
on  a.DepartmentID<>b.DepartmentID
--12
select a.Quantity,b.StockQuantity from Orders as a
join Products as b
 on  a.ProductID=b.ProductID
 where a.Quantity>b.StockQuantity
--13
 select a.FirstName,b.ProductID from Customers as a
 join Sales as b
 on a.CustomerID=b.CustomerID
 where b.SaleAmount>=500
 --14
select a.Name,c.CourseName  from Students as a
join Enrollments as b
on a.StudentID=b.StudentID
join Courses as c
on b.CourseID=c.CourseID
--15
select b.ProductName,a.SupplierName from Suppliers as a
join  Products as b
on a.SupplierID=b.SupplierID
where a.SupplierName like '%tech%'
--16
SELECT a.OrderID, b.Amount AS PaidAmount, a.TotalAmount 
FROM Orders AS a
join Payments as b
on a.OrderID=b.OrderID
where b.Amount<a.TotalAmount
--17
select employer.Name from Employees as employer
join Employees as managers
on employer.ManagerID=managers.EmployeeID
where managers.Salary<employer.Salary
--18
select a.ProductName from Products as a
join Categories as b
on a.Category=b.CategoryID
where b.CategoryName  in('Electronics','Furniture')
--19
select a.CustomerID,b.FirstName,b.Country from Sales as a
join Customers as b
on a.CustomerID=b.CustomerID
where b.Country like 'USA'
--20
select a.CustomerID, b.FirstName,b.Country from Orders as a
join Customers as b
on a.CustomerID=b.CustomerID
where b.Country like 'Germany' and a.TotalAmount>100
--21 Using Employees table List all pairs of employees from different departments.
select * from Employees
--22
select a.OrderID,a.Amount as paid_amount ,(b.Quantity * c.Price) as expected_amount from Payments as a
join Orders as b
on a.OrderID=b.OrderID
join Products as c
on b.ProductID=c.ProductID
where  a.Amount<>(b.Quantity * c.Price) 
--23
select a.Name from Students as a
left join Enrollments as b
on a.StudentID=b.StudentID
where b.StudentID is null
--24
select employees.Name,managers.Name from Employees as employees
join Employees as managers
on employees.EmployeeID=managers.ManagerID
where managers.Salary<=employees.Salary
--25
select a.CustomerID,c.FirstName,a.OrderID,b.PaymentID from Orders a
left join Payments as b
on a.OrderID=b.OrderID
join Customers as c
on a.CustomerID=c.CustomerID
where b.OrderID is null

select a.CustomerID,c.FirstName,a.OrderID from Orders a
left join Payments as b
on a.OrderID=b.OrderID
inner join Customers as c
on a.CustomerID=c.CustomerID
where b.PaymentID is null
