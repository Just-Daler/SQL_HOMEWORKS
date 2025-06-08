
--1 Compute Running Total Sales per Customer
select customer_id,
  sum(quantity_sold) over(partition by customer_id  order by order_date) as 'Total Sales per'
from sales_data 
---2 Count the Number of Orders per Product Category
select product_category,
  count(*) over(partition by product_category  ) as 'Total Sales per'
from sales_data 
--3 Find the Maximum Total Amount per Product Category
select *,
  max(total_amount) over (partition by product_name) as 'Maximum Total Amount per Product Category'
from sales_data
--4. Find the Minimum Price of Products per Product Category
select *,
  min(total_amount) over (partition by product_name) as 'Minimum Price of Products per Product Category'
from sales_data
--5. Compute the Moving Average of Sales of 3 days (prev day, curr day, next day)
select *, 
  avg(total_amount) over(order by order_date  ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as 'Average of Sales of 3 days' 
from sales_data
--6 Find the Total Sales per Region
select *, 
  SUM(total_amount) OVER (PARTITION BY REGION) AS 'Total Sales per Region'
from sales_data
---7 Compute the Rank of Customers Based on Their Total Purchase Amount
SELECT customer_id,SUM(TOTAL_AMOUNT) AS SUMM,  RANK() OVER (ORDER BY SUM(TOTAL_AMOUNT)) AS ' Rank of Customers Based on Their Total Purchase Amount' FROM sales_data
GROUP BY customer_id
--8 Calculate the Difference Between Current and Previous Sale Amount per Customer
;WITH FILTRED AS(
SELECT customer_id AS CST_ID,
    total_amount AS CUR_AMOUNT,
     LAG(total_amount,1,0) OVER (PARTITION BY CUSTOMER_ID ORDER BY order_date) AS PREV_AMON 
  FROM sales_data)

SELECT CST_ID,
  CUR_AMOUNT,
   PREV_AMON,
   CUR_AMOUNT-PREV_AMON AS DIFF 
FROM FILTRED
--9 Find the Top 3 Most Expensive Products in Each Category
WITH CTE AS(
   SELECT product_category AS PROD_CAT,
    product_name AS PROD_NAM,
     ROW_NUMBER() OVER (PARTITION BY PRODUCT_CATEGORY ORDER BY UNIT_PRICE DESC) AS RANKED 
     FROM sales_data
   )
SELECT  * FROM CTE
WHERE RANKED<4

--10 Compute the Cumulative Sum of Sales Per Region by Order Date
SELECT  * FROM sales_data
SELECT *,
  SUM(total_amount) OVER(PARTITION BY REGION ORDER BY ORDER_DATE )
FROM sales_data
--11 Compute Cumulative Revenue per Product Category
SELECT *,
  SUM(total_amount) OVER(PARTITION BY PRODUCT_CATEGORY ORDER BY ORDER_DATE )
FROM sales_data
--12
SELECT *, SUM(id) OVER(ORDER BY ID  ) FROM sample_ids
--13 Sum of Previous Values to Current Value
SELECT *,
  SUM(VALUE) OVER(ORDER BY [VALUE] ROWS 1 PRECEDING) 
FROM OneColumn
--14 Generate row numbers for the given data. The condition is that the first row number for every partition should be odd number.For more details please check the sample input and expected output.
;WITH Numbered AS (
    SELECT 
        *,
        ROW_NUMBER() OVER (PARTITION BY Id ORDER BY Vals) AS rn,
        DENSE_RANK() OVER (ORDER BY Id) AS group_rn
    FROM Row_Nums
),
Offset AS (
    SELECT
        Id,
        group_rn,
        COUNT(*) AS count_in_group
    FROM Numbered
    GROUP BY Id, group_rn
),
Accumulated AS (
    SELECT 
        o.Id,
        o.count_in_group,
        o.group_rn,
        SUM(o.count_in_group) OVER (
            ORDER BY o.group_rn
            ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING
        ) * 2 + 1 AS start_row
    FROM Offset o
)
SELECT 
    n.Id,
    n.Vals,
    a.start_row + n.rn - 1 AS RowNumber
FROM Numbered n
JOIN Accumulated a ON n.Id = a.Id
ORDER BY RowNumber;


--15 Find customers who have purchased items from more than one product_category
SELECT 
    customer_id,
    customer_name,
    COUNT(DISTINCT product_category) AS category_count
FROM 
    sales_data
GROUP BY 
    customer_id, customer_name
HAVING 
    COUNT(DISTINCT product_category) > 1;


--16
WITH RegionalAverages AS (
    SELECT 
        region,
        AVG(total_amount) AS avg_spending_per_sale
    FROM sales_data
    GROUP BY region
),
CustomerTotals AS (
    SELECT 
        customer_id,
        customer_name,
        region,
        SUM(total_amount) AS total_spent
    FROM sales_data
    GROUP BY customer_id, customer_name, region
)
SELECT 
    ct.customer_id,
    ct.customer_name,
    ct.region,
    ct.total_spent,
    ra.avg_spending_per_sale
FROM 
    CustomerTotals ct
JOIN 
    RegionalAverages ra ON ct.region = ra.region
WHERE 
    ct.total_spent > ra.avg_spending_per_sale
ORDER BY 
    ct.region, ct.total_spent DESC;

--17
WITH CustomerSpending AS (
    SELECT 
        customer_id,
        customer_name,
        region,
        SUM(total_amount) AS total_spent
    FROM sales_data
    GROUP BY customer_id, customer_name, region
)
SELECT 
    customer_id,
    customer_name,
    region,
    total_spent,
    RANK() OVER (PARTITION BY region ORDER BY total_spent DESC) AS spending_rank
FROM CustomerSpending
ORDER BY region, spending_rank;


------------------------
---18   Calculate the running total (cumulative_sales) of total_amount for each customer_id, ordered by order_date.
with cte as (
select customer_id as id,sum(total_amount) over(partition by customer_id order by order_date) as total from sales_data)
select id,Max(total) as total from cte
group by id
---19 Calculate the sales growth rate (growth_rate) for each month compared to the previous month.
WITH CTE AS (
select order_date AS OR_DAT,sum(total_amount) OVER(PARTITION BY MONTH(ORDER_DATE) ORDER BY ORDER_DATE) AS TOTAL_AMOUNT_MONTH from sales_data)
SELECT *,(TOTAL_AMOUNT_MONTH-LAG(TOTAL_AMOUNT_MONTH,1,0)OVER(ORDER BY OR_DAT ))AS 'growth_rate' FROM CTE
--20 Identify customers whose total_amount is higher than their last order''s total_amount.(Table sales_data)
with cte as (
SELECT customer_name AS NAME , total_amount AS TOTAL_AMOUNT,LAG(total_amount) OVER(ORDER BY CUSTOMER_NAME) AS LAST_ORDER_TOTAL FROM sales_data)
SELECT * FROM CTE
WHERE TOTAL_AMOUNT>LAST_ORDER_TOTAL

--21 Identify Products that prices are above the average product price
SELECT *,AVG(unit_price) OVER( ) , CASE 
          WHEN unit_price>AVG(unit_price) OVER() THEN 1
          ELSE ''
          END
FROM sales_data



--22 In this puzzle you have to find the sum of val1 and val2 for each group and put that value at the beginning of the group in the new column. The challenge here is to do this in a single select. For more details please see the sample input and expected output.
SELECT *, SUM(VAL1) OVER(PARTITION BY GRP ORDER BY ID DESC) ,SUM(Val2) OVER(PARTITION BY GRP ORDER BY ID DESC) , ROW_NUMBER () OVER(PARTITION BY GRP ORDER BY GRP),
   CASE 
   WHEN (ROW_NUMBER () OVER(PARTITION BY GRP ORDER BY GRP))=1 THEN  SUM(VAL1) OVER(PARTITION BY GRP ORDER BY GRP)+SUM(Val2) OVER(PARTITION BY GRP ORDER BY GRP)
   ELSE NULL
   END
   FROM MyData

--23. Here you have to sum up the value of the cost column based on the values of Id. For Quantity if values are different then we have to add those values.Please go through the sample input and expected output for details.
SELECT* FROM TheSumPuzzle
WITH CTE AS (
SELECT ID AS ID,Cost AS COS,Quantity AS QUAN, RANK() OVER(ORDER BY ID) AS RANK1,RANK() OVER(ORDER BY COST) AS RANK2  FROM TheSumPuzzle)
SELECT  ID, SUM(COS) OVER (PARTITION BY ID ORDER BY RANK) AS COST,SUM(QUAN) OVER (PARTITION BY ID ORDER BY RANK) AS Quantity
FROM CTE


SELECT ID,SUM(Cost) OVER( PARTITION BY ID),SUM(Quantity) OVER( PARTITION BY COST)  FROM TheSumPuzzle

--24 
WITH MinMax AS (
    SELECT MIN(SeatNumber) AS MinSeat, MAX(SeatNumber) AS MaxSeat FROM Seats
),
AllSeats AS (
    SELECT TOP (
        SELECT MaxSeat FROM MinMax
    ) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS SeatNumber
    FROM master.dbo.spt_values
),
MissingSeats AS (
    SELECT a.SeatNumber
    FROM AllSeats a
    LEFT JOIN Seats s ON a.SeatNumber = s.SeatNumber
    WHERE s.SeatNumber IS NULL
),
GroupedGaps AS (
    SELECT 
        SeatNumber,
        SeatNumber - ROW_NUMBER() OVER (ORDER BY SeatNumber) AS grp
    FROM MissingSeats
),
FinalGaps AS (
    SELECT 
        MIN(SeatNumber) AS GapStart,
        MAX(SeatNumber) AS GapEnd
    FROM GroupedGaps
    GROUP BY grp
)
SELECT * FROM FinalGaps ORDER BY GapStart;

--25

;WITH Ordered AS (
  SELECT 
    *,
    ROW_NUMBER() OVER (PARTITION BY Id ORDER BY Vals) AS rn_in_group,
    DENSE_RANK() OVER (ORDER BY Id) AS group_rnk
  FROM Sample
),
GroupSize AS (
  SELECT 
    Id,
    group_rnk,
    COUNT(*) AS cnt
  FROM Ordered
  GROUP BY Id, group_rnk
),
OffsetCalc AS (
  SELECT 
    Id,
    group_rnk,
    cnt,
    SUM(cnt) OVER (ORDER BY group_rnk 
                   ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING) * 1 + 2 AS base_row
  FROM GroupSize
)
SELECT 
  o.Id,
  o.Vals,
  oc.base_row + o.rn_in_group - 1 AS Changed
FROM Ordered o
JOIN OffsetCalc oc ON o.Id = oc.Id
ORDER BY Changed;

