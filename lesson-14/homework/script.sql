------------Easy Tasks-------------
--1

SELECT *,
       SUBSTRING(Name, 1, CHARINDEX(',', Name, 1)-1) AS NAME,
       SUBSTRING(Name, CHARINDEX(',', Name, 1)+1, 50) AS SURNAME
FROM TestMultipleColumns 
--2

SELECT *
FROM TestPercent
WHERE PATINDEX('%[%]%', Strs)>0
 --3

  SELECT *,
         SUBSTRING(Vals, 1, CHARINDEX('.', VALS, 1)-1),
         SUBSTRING(Vals, CHARINDEX('.', VALS, 1)+1, CHARINDEX('.', VALS, 1)-1),
         SUBSTRING(Vals, LEN(SUBSTRING(Vals, 1, CHARINDEX('.', VALS, 1))+SUBSTRING(Vals, CHARINDEX('.', VALS, 1), CHARINDEX('.', VALS, 1)))+1, 50)
  FROM Splitter 
--4

  SELECT replace(replace(replace(replace(replace(replace(Replace(replace(REPLACE('1234ABC123456XYZ1234567890ADS', '1', 'X'), '2', 'X'), '3', 'X'), '4', 'X'), '5', 'X'), '6', 'X'), '7', 'X'), '8', 'X'), '9', 'X') 
--5

  SELECT*
  FROM testDots WHERE LEN(VALS)-LEN(REPLACE(Vals, '.', ''))>2
 --6

  SELECT *,
         LEN(texts)-LEN(REPLACE(TEXTS, ' ', ''))
  FROM CountSpaces
 --7

  SELECT a.Name
  FROM Employee AS a
  LEFT JOIN Employee AS b ON a.ManagerId=b.Id WHERE a.Salary>b.Salary 
--8

  SELECT EMPLOYEE_ID,
         FIRST_NAME,
         LAST_NAME,
         HIRE_DATE,
         DATEDIFF(YEAR, HIRE_DATE, GETDATE())
  FROM Employees WHERE HIRE_DATE>=DATEADD(YEAR, -15, GETDATE())
  AND HIRE_DATE<=DATEADD(YEAR, -10, GETDATE())
  SELECT EMPLOYEE_ID,
         FIRST_NAME,
         LAST_NAME,
         HIRE_DATE,
         DATEDIFF(YEAR, HIRE_DATE, GETDATE())
  FROM Employees WHERE DATEDIFF(YEAR, HIRE_DATE, GETDATE())<15
  AND DATEDIFF(YEAR, HIRE_DATE, GETDATE())>10 ----MEDIUM TASKS-----
--1

  SELECT REPLACE('rtcfvty34redt', SUBSTRING('rtcfvty34redt', PATINDEX('%[0-9]%[0-9]%', 'rtcfvty34redt'), 2), '') AS STRING_VALUE,
         SUBSTRING('rtcfvty34redt', PATINDEX('%[0-9]%[0-9]%', 'rtcfvty34redt'), 2) AS INT_VALUE
  SELECT VALUE
  FROM string_split('rtcfvty34redt', '') --2--write a SQL query to find all dates' Ids with higher temperature compared to its previous (yesterday's) dates.(weather)

  SELECT a.Id,
         a.Temperature
  FROM weather AS A
  LEFT JOIN WEATHER AS B ON b.RecordDate<a.RecordDate
  AND b.Id=a.Id-1 WHERE a.Temperature>b.Temperature
 --3

  SELECT player_id,
         min(event_date) AS login_date
  FROM Activity
GROUP BY player_id
 --4

SELECT fruit_list,
       SUBSTRING(SUBSTRING(fruit_list, CHARINDEX(',', fruit_list)+1, 100), CHARINDEX(',', SUBSTRING(fruit_list, CHARINDEX(',', fruit_list)+1, 100))+1, len(SUBSTRING(SUBSTRING(fruit_list, CHARINDEX(',', fruit_list)+1, 100), CHARINDEX(',', SUBSTRING(fruit_list, CHARINDEX(',', fruit_list)+1, 100))+1, 100))-len(SUBSTRING(SUBSTRING(SUBSTRING(fruit_list, CHARINDEX(',', fruit_list)+1, 100), CHARINDEX(',', SUBSTRING(fruit_list, CHARINDEX(',', fruit_list)+1, 100))+1, 100), charindex(',', SUBSTRING(SUBSTRING(fruit_list, CHARINDEX(',', fruit_list)+1, 100), CHARINDEX(',', SUBSTRING(fruit_list, CHARINDEX(',', fruit_list)+1, 100))+1, 100)), 100)))
FROM fruits
SELECT *,
       parsename(REPLACE(fruit_list, ',', '.'), 2)
FROM fruits 

--5 Write a SQL query to create a table where each character from the string will be converted into a row.(sdgfhsdgfhs@121313131)
 DECLARE @str NVARCHAR(MAX) = 'sdgfhsdgfhs@121313131';

WITH chars AS
  (SELECT 1 AS pos,
          SUBSTRING(@str, 1, 1) AS ch
   UNION ALL SELECT pos + 1,
                    SUBSTRING(@str, pos + 1, 1)
   FROM chars
   WHERE pos < LEN(@str))
SELECT ch
FROM chars OPTION (MAXRECURSION 0);

---6 You are given two tables: p1 and p2. Join these tables on the id column. The catch is: when the value of p1.code is 0, replace it with the value of p2.code.(p1,p2)

SELECT a.code,
       b.code,
       REPLACE(a.code, 0, b.code)
FROM p1 AS a
JOIN p2 AS b ON a.id=b.id
SELECT b.code,
       CASE
           WHEN a.code=0 THEN b.code
           ELSE a.code
       END AS answer
FROM p1 AS a
JOIN p2 AS b ON a.id=b.id 
--7  Write an SQL query to determine the Employment Stage for each employee based on their HIRE_DATE. The stages are defined as follows:

SELECT EMPLOYEE_ID,
       concat(FIRST_NAME, ' ', LAST_NAME) AS fullname,
       HIRE_DATE,
       CASE
           WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE())<1 THEN 'New Hire'
           WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE())<5 THEN 'Junior'
           WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE())<10 THEN 'Mid-Level'
           WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE())<20 THEN 'Senior'
           ELSE 'veteran'
       END AS stage
FROM Employees
 ------difficult tasks
 --1In this puzzle you have to swap the first two letters of the comma separated string.(MultipleVals)

SELECT CONCAT(REVERSE(SUBSTRING(VALS, 1, PATINDEX('%,%', Vals)+1)), '', RIGHT(VALS, 2)) AS SWAPED
FROM MultipleVals 
--2--Write a SQL query that reports the device that is first logged in for each player.(Activity)

SELECT player_id,
       device_id
FROM Activity AS A
WHERE event_date=
    (SELECT MIN(event_date)
     FROM Activity
     WHERE player_id=A.player_id) 
--3

  SELECT *
  FROM WeekPercentagePuzzle;

WITH WeeklySales AS
  (SELECT area,
          DATEPART(YEAR, Date) AS sales_year,
          DayOfWeek AS sales_week,
          SUM(SalesLocal+SalesRemote) AS area_week_sales
   FROM WeekPercentagePuzzle
   GROUP BY area,
            DATEPART(YEAR, Date),
            DayOfWeek),
     TotalWeeklySales AS
  (SELECT sales_year,
          sales_week,
          SUM(area_week_sales) AS total_week_sales
   FROM WeeklySales
   GROUP BY sales_year,
            sales_week)
SELECT ws.sales_year,
       ws.sales_week,
       ws.area,
       ws.area_week_sales,
       tws.total_week_sales,
       ROUND((CAST(ws.area_week_sales AS FLOAT) / tws.total_week_sales) * 100, 2) AS weekly_percentage
FROM WeeklySales ws
JOIN TotalWeeklySales tws ON ws.sales_year = tws.sales_year
AND ws.sales_week = tws.sales_week
ORDER BY ws.sales_year,
         ws.sales_week,
         ws.area;