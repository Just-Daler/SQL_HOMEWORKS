--1 
select  min(Price) as min_price from Products
--2
select max(Salary) as max_salary from Employees
--3
select count(*) from Customers
--4
select count( distinct Category) as count_cat from Products
--5
select sum(SaleAmount) as amount_sales from Sales
where CustomerID=7
--6
 select avg(Age) as avarage_age from Employees
 --7
 select count(EmployeeID),DepartmentName from Employees
 group by DepartmentName
 --8 
 select max(Price) as max_price, min(Price) as min_price, Category from Products
 group by Category
 --9 
 select sum(SaleAmount),CustomerID  from Sales
 group by CustomerID
 --10 
 select DepartmentName, count(EmployeeID) as count_employees from Employees
 group by DepartmentName
 having count(EmployeeID)>5
 --11
   select ProductID ,sum(SaleAmount) as total_sales , avg(SaleAmount) as avg_sales from Sales
 group by ProductID
 --12
   select DepartmentName,count(EmployeeID)   from Employees
   group by DepartmentName
   having DepartmentName='hr'
   --13
   select DepartmentName, max(Salary) as highest_salary, min(Salary) as lowest_salary from Employees
   group by DepartmentName
   --14
    select DepartmentName, avg(Salary) as avarage_salary from Employees
   group by DepartmentName
   --15
    select DepartmentName, count(EmployeeID) as count_employees,avg(Salary) as avarage_salary from Employees
   group by DepartmentName
   --16
   select Category,avg(Price) as avarage_price from Products
   group by  Category
   having avg(Price)>400
   --17
   select year(SaleDate) as year ,count(SaleID) as total_sales  from Sales
   group by year(SaleDate)
   --18
   select CustomerID, count(SaleID) as order_count from Sales
   group by CustomerID
   having count(SaleID)>3
   --19
   select DepartmentName,sum(Salary)  from Employees
   group by DepartmentName
   having sum(Salary)>500000
   --20
    select ProductID, avg(SaleAmount) as avg_sale from Sales
	group by ProductID
	having avg(SaleAmount)>200
	--21
	select CustomerID, sum(SaleAmount) from Sales
	group by CustomerID
	having sum(SaleAmount)>1500
	--22
	select DepartmentName, sum(Salary) as  total_salary, avg(Salary) as avg_salary from Employees
	group by DepartmentName
	having avg(Salary)>65000
	--23
	select CustomerID,max(SaleAmount)as max_sale , min(SaleAmount) as min_sale from Sales
	group by CustomerID
	having min(SaleAmount)>50
	--24
	select month(SaleDate) as in_month,count(ProductID)as product_sale,sum(SaleAmount) total_sales from Sales
	group by month(SaleDate)
	having count(ProductID)>8
	 --25
	select * from Orders
	  select year(OrderDate) as per_year, min(OrderID) as min_orders, max(OrderID) as max_orders from Orders
	  group by year(OrderDate)
