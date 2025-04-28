--1
SELECT Category,
       count(ProductID) AS total_number
FROM Products
GROUP BY Category 
--2
SELECT Category,
       avg(Price)
FROM Products
GROUP BY Category
HAVING Category= 'electronics'
--3
SELECT *
FROM Customers
WHERE City like 'L%' 
--4
  SELECT *
  FROM Products WHERE ProductName like '%er' 
  --5
  SELECT *
  FROM Customers WHERE Country like '%A'
  --6
  SELECT ProductName,
         max(Price)
  FROM Products
GROUP BY ProductName
ORDER BY max(Price) DESC
--7
SELECT *,
       iif(stockquantity<30, 'Low Stock',('Sufficient'))
FROM Products 
---8
SELECT Country,
       count(CustomerID) AS total_number_of_customers
FROM Customers
GROUP BY Country 
--9
SELECT max(Quantity) AS maximum_quantity_ordered,
       min(Quantity) AS minimum_quantity_ordered
FROM Orders
ORDER BY max(Quantity),
         min(Quantity) 
--10
SELECT DISTINCT CustomerID,
                OrderDate
FROM Orders
WHERE year(OrderDate)=2023
EXCEPT
SELECT DISTINCT CustomerID,
                InvoiceDate
FROM Invoices
WHERE year(InvoiceDate)=2023 
--11
  SELECT ProductName
  FROM Products
UNION ALL
SELECT ProductName
FROM Products_Discounted 
--12
SELECT ProductName
FROM Products
UNION
SELECT ProductName
FROM Products_Discounted
--13
SELECT year(OrderDate),
       avg(TotalAmount) AS avg_order_amount
FROM Orders
GROUP BY year(OrderDate) 
--14
SELECT ProductName,
       CASE
           WHEN price<100 THEN 'Low'
           WHEN price <500 THEN 'Mid'
           ELSE 'High'
       END AS price_group
FROM Products
ORDER BY Price DESC 
--15
SELECT DISTINCT City
FROM Customers
ORDER BY City 
--16
SELECT ProductID,
       sum(SaleAmount) AS total_sales_per_product_Id
FROM Sales
GROUP BY ProductID 
--17
SELECT ProductName
FROM Products
WHERE ProductName like '%oo%' 
--18 
  SELECT ProductID
  FROM Products INTERSECT
  SELECT ProductID
  FROM Products_Discounted 
 --19
  SELECT top 3 CustomerID,
             sum(TotalAmount) AS highest_total_invoice
  FROM Invoices
GROUP BY CustomerID
ORDER BY sum(TotalAmount) DESC 
--20 
SELECT ProductID,
       ProductName
FROM Products
EXCEPT
SELECT ProductID,
       ProductName
FROM Products_Discounted 
--21
select Products.ProductName, count(Sales.SaleID) as times_sold
from Products
join Sales on Products.ProductID = Sales.ProductID
group by Products.ProductName
order by times_sold desc;
--22
SELECT top 5 ProductID,
           sum(Quantity) AS highest_order_quantities
FROM Orders
GROUP BY ProductID
ORDER BY sum(Quantity) DESC
