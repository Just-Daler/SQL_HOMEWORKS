--1.Write a query to assign a row number to each sale based on the SaleDate.
select ROW_NUMBER() over(order by saledate) as row_num,*
from ProductSales

--2  Write a query to rank products based on the total quantity sold. give the same rank for the same amounts without skipping numbers.
select ProductName, 
		sum(Quantity) as sum_quantity,
		dense_rank() over(order by sum(quantity)) as ranked 
from ProductSales
group by ProductName				

--3 Write a query to identify the top sale for each customer based on the SaleAmount.
select CustomerID,SaleAmount,
rank from(
			select *,ROW_NUMBER() over (partition by customerid order by saleamount desc ) as [rank] 
			from ProductSales ) as t
where rank=1
--4 Write a query to display each sale's amount along with the next sale amount in the order of SaleDate.
select SaleAmount,
		lead(SaleAmount) over(order by saledate) as next_sale_amn,
		SaleDate  
from ProductSales
--5 Write a query to display each sale's amount along with the previous sale amount in the order of SaleDate.
select SaleAmount,
				lag(SaleAmount) over(order by saledate),
					SaleDate 
from ProductSales
--6 Write a query to identify sales amounts that are greater than the previous sale's amount
SELECT *
FROM (
    SELECT 
        SaleAmount,
        LAG(SaleAmount) OVER (ORDER BY SaleDate) AS PreviousSaleAmount
    FROM ProductSales
) AS sales
WHERE SaleAmount > PreviousSaleAmount;
--7 Write a query to calculate the difference in sale amount from the previous sale for every product
select *,
		SaleAmount-(lag(SaleAmount) over(partition by productname order by saledate )) as diffrence 
from ProductSales
--8 Write a query to compare the current sale amount with the next sale amount in terms of percentage change.
select *,concat(
					cast(
							round(
									((lead(SaleAmount) over( order by saledate )-SaleAmount)*100)/SaleAmount
									,1
									) as decimal(5,1)
									),
									'%'
									) as diffrence from ProductSales


--9 Write a query to calculate the ratio of the current sale amount to the previous sale amount within the same product.
select SaleAmount,isnull(cast(
						round(
								lag(SaleAmount)  over (partition by productname order by saledate)/SaleAmount
								,1 
								) as decimal (5,1)
								),0) as ratio
						
						
from ProductSales

--10 Write a query to calculate the difference in sale amount from the very first sale of that product.
select ProductName,
				FIRST_VALUE(SaleAmount) over(partition by productname order by saledate) as first_sale,
					SaleAmount-FIRST_VALUE(SaleAmount) over(partition by productname order by saledate)
from ProductSales
--11 Write a query to find sales that have been increasing continuously for a product (i.e., each sale amount is greater than the previous sale amount for that product).

select * from(
			select*,
			lead(SaleAmount) over (partition by productname order by saledate asc ) as next_sale 
			from ProductSales) as t
where SaleAmount<next_sale

--12 Write a query to calculate a "closing balance"(running total) for sales amounts which adds the current sale amount to a running total of previous sales.
select *,
		sum(SaleAmount) over(order by saledate) as [closing balance]  
from ProductSales
--13 Write a query to calculate the moving average of sales amounts over the last 3 sales.
select*,
		avg(SaleAmount) over(order by saledate rows between 2 preceding and current row) 
from ProductSales
--14 Write a query to show the difference between each sale amount and the average sale amount.
select*,
		saleamount-avg(SaleAmount) over() as DifferenceFromAvg 
from ProductSales
--15 Find Employees Who Have the Same Salary Rank
WITH RankedEmployees AS (
    SELECT 
        EmployeeID,
        Name,
        Salary,
        DENSE_RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
    FROM Employees1
),
DuplicateRanks AS (
    SELECT SalaryRank
    FROM RankedEmployees
    GROUP BY SalaryRank
    HAVING COUNT(*) > 1
)
SELECT re.*
FROM RankedEmployees re
JOIN DuplicateRanks dr ON re.SalaryRank = dr.SalaryRank
ORDER BY re.SalaryRank, re.Salary DESC;

--16 Identify the Top 2 Highest Salaries in Each Department
with cte as(
		select *,rank() over(partition by department order by salary desc) as ranked from Employees1) 
		select department,salary from cte
where ranked<=2

--17  Find the Lowest-Paid Employee in Each Department
with cte as(
select *,rank() over(partition by department order by salary ) as ranked from Employees1)
select * from cte
where ranked =1

--18  Calculate the Running Total of Salaries in Each Department
select * ,sum(Salary) over(partition by department order by hiredate) from Employees1

--19Find the Total Salary of Each Department Without GROUP BY
with cte as(
select *,sum(Salary) over (partition by department) as summ from Employees1)
select distinct department,summ  from cte

--20 Calculate the Average Salary in Each Department Without GROUP BY
select distinct Department, avg(Salary) over(partition by department) as 'avg by dep' from Employees1
--21 Find the Difference Between an Employee’s Salary and Their Department’s Average
select *,Salary-avg(Salary) over (partition by department) as diff_salarys from Employees1
--22 Calculate the Moving Average Salary Over 3 Employees (Including Current, Previous, and Next)
select *,avg(salary) over (order by hiredate rows between 1 preceding and 1 following ) from Employees1
--23 Find the Sum of Salaries for the Last 3 Hired Employees
with cte as(
select *,DENSE_RANK() over (order by hiredate desc) as ranked from Employees1)
select sum(salary) as 'summ last 3 employees' from cte
where ranked <=3
