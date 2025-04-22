--1
SELECT ProductName AS Name
FROM Products;
--2
select* from Customers as client
--3
select ProductName from Products
union
select ProductName 
from Products_Discounted
--4 
select * from Products
intersect 
select * from Products_Discounted
--5
select distinct  FirstName,Country
from Customers
--6
select *,
case 
when Price>1000 then 'high'
else'low'
end as point
from Products
--7 Use IIF to create a column that shows 'Yes' if Stock > 100, and 'No' otherwise (Products_Discounted table, StockQuantity column).
select *, iif( [stockquantity]>100, 'yes','no') as 'stocked'
from Products_Discounted
--8 
select ProductName
from Products
union
select ProductName
from OutOfStock
--9 
select *
from Products
except
select*
from  Products_Discounted
--10 
select *,
iif( [price]>1000,'Expensive','Affordable') as 'affordable_list'
from Products
--11 
 select * from Employees
 where Age<25 or Salary>60000

 --12
 select (EmployeeID),(DepartmentName),(Salary),(Salary+(Salary*0.1)) as 'updated salary'
 from Employees
 
 --13 
 select ProductName from Products
 intersect 
 select ProductName from Products_Discounted
 --14 
 select *, case 
 when SaleAmount>500 then 'Top Tier'
 when SaleAmount>200 then 'Mid Tier'
 else 'Low Tier'
 end as 'tiers' 
 from Sales
 order by SaleAmount desc 

 --15 
 select (CustomerID) from Customers
 except
 select (CustomerID) from Invoices
 --16
 select(CustomerID),(Quantity) ,
 case when Quantity=1 then '3%'
 when Quantity<=3 then '5%'
 else '7%'
 end as 'discount percentage'
 from Orders
