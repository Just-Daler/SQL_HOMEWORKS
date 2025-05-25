---1
WITH CTN AS (
   SELECT 1 AS NUM 
   UNION ALL
   SELECT NUM+1
   FROM CTN
   WHERE NUM<1000
)
SELECT * FROM CTN
OPTION (MAXRECURSION 1000);
---2

;WITH GROUPED AS(
    SELECT EmployeeID,SUM(SalesAmount) AS SUM_SAL FROM Sales
    GROUP BY EmployeeID
    )
SELECT Employees.EmployeeID,(SELECT GROUPED.SUM_SAL FROM GROUPED WHERE GROUPED.EmployeeID=Employees.EmployeeID) AS TOTAL_SALES FROM Employees

--3
;with avgr as (
select avg(Salary) as avarage_salary from Employees)
select * from avgr
--4
;with max_sales as(
select ProductID,max(SalesAmount) as 'max' from sales
group by ProductID)

select a.ProductID,a.ProductName,isnull(b.max,0) as highest_sales from Products as a
left join max_sales as b
on a.ProductID=b.ProductID


select a.ProductID,a.ProductName,isnull(b.max,0) as highest_sales from Products as a
left join (
   select ProductID,max(SalesAmount) as 'max' from sales
   group by ProductID) as b
on a.ProductID=b.ProductID

--5

with dubbling as( select 1 as num
     union all
    select num*2 from dubbling
    where dubbling.num<=1000000
)

select * from dubbling
OPTION (MAXRECURSION 1000);

--6
;with cnt as (
    select EmployeeID,count(SalesID) as counted from Sales
    group by EmployeeID
    having count(SalesID)>5
    )


select a.EmployeeID,a.FirstName,b.counted from Employees as a
left join cnt as b
on b.EmployeeID=a.EmployeeID
---7
;with greather as ( select ProductID,sum(SalesAmount) as total 
     from Sales
     group by ProductID
     having sum(SalesAmount)>$500
     )
select a.ProductID,a.ProductName,isnull(b.total,0) from Products as a
left join greather as b
on a.ProductID=b.ProductID

--8
;with avg_slr as (
    select avg(Salary) as avg_s from Employees
    )
select EmployeeID,Salary from Employees
where Salary>(select avg_s from avg_slr)

--9
SELECT TOP 5 A.EmployeeID,A.FirstName,B.cnt_sales FROM Employees AS A
JOIN (select EmployeeID,count(SalesID) as cnt_sales 
  from Sales AS A
  GROUP BY EmployeeID) AS B
ON A.EmployeeID=B.EmployeeID
ORDER BY B.cnt_sales
--10
;with sum_sal as (select ProductID as id,SalesAmount as sum_ from Sales )

SELECT a.CategoryID,sum(b.sum_) as sales FROM Products as a
left join sum_sal as b
on a.ProductID=b.id
group by a.CategoryID
--11
   select * from Numbers1

   declare @son int=1
   declare @son2 int=1
   while @son2=5
   begin
   select  @son
   set @son2=@son2+1
   set @son=@son*@son2
   end
--12
declare @bir varchar(100) = '1234566789';

with split as (
				select 
						1 as a,
						substring(@bir,1,1) as char1
						where len(@bir)>=1
	union all
				select a+1,
				substring(@bir,a+1,1)
				from split
				where a+1<=len(@bir)
			)
select a from split



select * from Example
declare @num_ int=1
declare @num2 int=1
set @num2=@num2+1

;with sep_val as
				( select substring(String,@num2,@num_) as  character from Example
				where len(String)>1 and Id=1
			union all

			select SUBSTRING(String,@num2,1) from Example
			where  @num2<=len(String) and Id=1)
	
	select character from sep_val



---13
;with current_m as ( select ProductID,SalesAmount,SaleDate from Sales
									
					)
 select SUM(A.SalesAmount) AS PREV_MONT,SUM(B.SalesAmount) AS CUR_MONTH,SUM(B.SalesAmount)-SUM(A.SalesAmount) AS DIFFRENCE from Sales as a
 join current_m as b
		on a.ProductID=b.ProductID
where month(a.SaleDate)=4 and MONTH(b.SaleDate)=MONTH(GETDATE())	

--14
select sal.EmployeeID,sum(sal.SalesAmount) as sales_by_quarter,a.quarter from Sales as sal
join (select SaleDate, datepart(QUARTER,SaleDate) as quarter from Sales
		group by SaleDate) as a
on sal.SaleDate=a.SaleDate
group by sal.EmployeeID,a.quarter
having sum(sal.SalesAmount)>45000

--15

; WITH FIBONACCI_NUM AS(
						SELECT 0 AS N, 0 AS FIB, 1 AS NEXT_FIB
						UNION ALL
						SELECT N+1,NEXT_FIB,FIB+NEXT_FIB FROM FIBONACCI_NUM
						WHERE N<30
						)
	SELECT FIB FROM FIBONACCI_NUM	

--16
;WITH SAME AS (SELECT *,CASE
					WHEN LEN(REPLACE(Vals,SUBSTRING(Vals,1,1),''))=0 THEN  1
					ELSE 2
					END AS SAME_CHAR
				FROM FindSameCharacters)

SELECT Vals FROM SAME
WHERE SAME_CHAR=1 AND LEN(Vals)>1

--17
declare @son_  int =6

;with numbers as(
					select
					1 as num,
					cast('1' as varchar(100)) as javob
					union all
					select num+1,
					cast(javob+cast(num+1 as varchar(10)) as varchar(100))
					from numbers
					where num+1<=@son_
					)
select * from numbers
OPTION (MAXRECURSION 100);

--18
select a.EmployeeID,a.FirstName,a.LastName,b.SaleDate,b.summ from Employees as a
join  (SELECT EmployeeID,SaleDate,SUM(SalesAmount) as summ FROM Sales
GROUP BY EmployeeID,SaleDate
having MONTH(SaleDate)>month(dateadd(MONTH,-6,max(SaleDate)))) as b
on a.EmployeeID=b.EmployeeID
order by b.summ desc
--19
select concat(parsename(replace (Pawan_slug_name,'-','.'),2),b.removed)
		from RemoveDuplicateIntsFromNames as a
join (
			select PawanName, case 
							when (len(int_part)-len(REPLACE(int_part,substring(int_part,1,1),'')))>2 then REPLACE(int_part,substring(int_part,1,1),'')
							when len(int_part)=1 then ''
							else int_part
							end as removed
			from (select PawanName,parsename(replace (Pawan_slug_name,'-','.'),1)as int_part from RemoveDuplicateIntsFromNames) as nums
			) as b
on a.PawanName=b.PawanName
