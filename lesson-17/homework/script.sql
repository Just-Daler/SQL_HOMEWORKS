--1
select distinct a.Region, b.Distributor,isnull(c.Sales,0) from  #RegionSales as a
cross join #RegionSales as b
 left join #RegionSales as c
 on a.Region=c.Region and b.Distributor=c.Distributor
 order by b.Distributor

 --2
select  a.name from Employee as a
join Employee as b
on a.id=b.managerId
group by a.name
having count(b.id)>=5
--3
select a.product_name,sum(b.unit) from Products as a
join(select *from Orders
where year(order_date)=2020 and month(order_date)=02
) as b
on a.product_id=b.product_id 
group by a.product_name
having  sum(b.unit)>=100
--4
with cte as (
select Vendor,CustomerID,
						sum([Count]) as sum ,
						rank() over( partition by CustomerID order by sum([Count]) desc) as rank
						from Orders 
						group by Vendor,CustomerID
						)
select CustomerID,Vendor from cte
where rank=1

--5
DECLARE @Check_Prime INT = 91;
DECLARE @i INT = 2;
DECLARE @IsPrime BIT = 1;

IF @Check_Prime <= 1
    SET @IsPrime = 0;

WHILE @i * @i <= @Check_Prime AND @IsPrime = 1
BEGIN
    IF @Check_Prime % @i = 0
        SET @IsPrime = 0;
    SET @i = @i + 1;
END

IF @IsPrime = 1
    PRINT 'This number is prime';
ELSE
    PRINT 'This number is not prime';

--6
WITH LocationRanks AS (
    SELECT 
        Device_id,
        Locations,
        COUNT(*) AS SignalCount,
        RANK() OVER (PARTITION BY Device_id ORDER BY COUNT(*) DESC) AS rnk
    FROM Device
    GROUP BY Device_id, Locations
),
TopLocations AS (
    SELECT 
        Device_id,
        Locations AS Most_Signal_Location,
        SignalCount
    FROM LocationRanks
    WHERE rnk = 1
),
TotalStats AS (
    SELECT 
        Device_id,
        COUNT(*) AS Total_Signals,
        COUNT(DISTINCT Locations) AS Location_Count
    FROM Device
    GROUP BY Device_id
)
SELECT 
    t.Device_id,
    s.Location_Count,
    t.Most_Signal_Location,
    t.SignalCount AS Most_Signals,
    s.Total_Signals
FROM TopLocations t
JOIN TotalStats s ON t.Device_id = s.Device_id;

--7
select e.EmpID,e.EmpName,e.Salary from Employee as e
where e.Salary>=(select avg(Salary) from Employee where DeptID=e.DeptID)

--8
WITH CTE AS(
SELECT TicketID, SUM(CASE 
				WHEN Number IN (25,45,78) THEN 1
				ELSE 0
				END
				) AS COUNTS
FROM Tickets
GROUP BY TicketID )

SELECT SUM( 
			CASE 
				WHEN COUNTS=3 THEN 100
				WHEN COUNTS>0 THEN 10
				ELSE 0
				END) AS TODAYS_WINNINGS
 FROM CTE

 --9
WITH Platforms AS (
    SELECT
        User_id,
        Spend_date,
        MAX(CASE WHEN Platform = 'Mobile' THEN 1 ELSE 0 END) AS Used_Mobile,
        MAX(CASE WHEN Platform = 'Desktop' THEN 1 ELSE 0 END) AS Used_Desktop,
        SUM(Amount) AS Total_Amount
    FROM Spending
    GROUP BY User_id, Spend_date
),
Classified AS (
    SELECT
        Spend_date,
        CASE 
            WHEN Used_Mobile = 1 AND Used_Desktop = 1 THEN 'Both'
            WHEN Used_Mobile = 1 THEN 'Mobile Only'
            WHEN Used_Desktop = 1 THEN 'Desktop Only'
        END AS Usage_Type,
        Total_Amount
    FROM Platforms
)
SELECT
    Spend_date,
    Usage_Type,
    COUNT(*) AS Total_Users,
    SUM(Total_Amount) AS Total_Amount
FROM Classified
GROUP BY Spend_date, Usage_Type
ORDER BY Spend_date, 
         CASE Usage_Type
             WHEN 'Mobile Only' THEN 1
             WHEN 'Desktop Only' THEN 2
             WHEN 'Both' THEN 3
         END;


--10 
WITH Recurse AS (
  SELECT Product, 1 AS Quantity
  FROM Grouped
  WHERE Quantity >= 1

  UNION ALL

  SELECT r.Product, r.Quantity + 1
  FROM Recurse r
  JOIN Grouped g ON g.Product = r.Product
  WHERE r.Quantity + 1 <= g.Quantity
)
SELECT Product, 1 AS Quantity
FROM Recurse
ORDER BY Product;
