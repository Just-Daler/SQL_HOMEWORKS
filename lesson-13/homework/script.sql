--1

SELECT concat(EMPLOYEE_ID, '-', FIRST_NAME, ' ', LAST_NAME)
FROM Employees 
--2
SELECT
REPLACE (PHONE_NUMBER,
         124,
         999)
FROM Employees
--3
SELECT FIRST_NAME,
       LEN(FIRST_NAME) AS LENGTH,
       SUBSTRING(FIRST_NAME, 1, 1) AS FIRST_LATTERS
FROM Employees
WHERE SUBSTRING(FIRST_NAME, 1, 1) IN ('A',
                                      'J',
                                      'M')
ORDER BY FIRST_NAME 
--4

SELECT MANAGER_ID,
       sum(SALARY)
FROM Employees
GROUP BY MANAGER_ID
--5

SELECT Year1,
       CASE
           WHEN max1>max2
                AND max1>Max3 THEN Max1
           WHEN max2>max1
                AND max2>Max3 THEN Max2
           ELSE Max3
       END AS MAX_VALUE
FROM TestMax
--6

SELECT *
FROM cinema
WHERE description<>'BORING'
  AND id%2=1 
  --7

  SELECT *
  FROM SingleOrder
ORDER BY IIF(ID=0, 2, 1) 
--8

SELECT COALESCE(ID, SSN, PASSPORTID, ITIN)
FROM person
--9

SELECT PARSENAME(REPLACE(FullName, ' ', '.'), 3) AS name,
       PARSENAME(REPLACE(FullName, ' ', '.'), 2) AS midname,
       PARSENAME(REPLACE(FullName, ' ', '.'), 1) AS surename
FROM Students 
--10

SELECT CustomerID,
       DeliveryState
FROM Orders
ORDER BY CASE
             WHEN DeliveryState='ca' THEN 1
             WHEN DeliveryState='tx' THEN 2
             ELSE 3
         END 
--11

SELECT string_agg(String,' ') AS concatenate
FROM DMLTable 
--12

SELECT concat(FIRST_NAME, ' ', LAST_NAME)
FROM Employees
WHERE patindex('%a%a%a%', concat(FIRST_NAME, ' ', LAST_NAME))>0 
--13

  SELECT DEPARTMENT_ID,
         COUNT(*) AS Total_Employees, -- Count of employees with more than 3 years
 SUM(CASE
         WHEN HIRE_DATE <= DATEADD(YEAR, -3, GETDATE()) THEN 1
         ELSE 0
     END) AS Employees_Over_3_Years, -- Percentage of those employees
 CAST(100.0 * SUM(CASE
                      WHEN HIRE_DATE <= DATEADD(YEAR, -3, GETDATE()) THEN 1
                      ELSE 0
                  END) / COUNT(*) AS DECIMAL(5, 2)) AS Percentage_Over_3_Years
  FROM Employees
GROUP BY DEPARTMENT_ID;

--14
WITH exp_aust AS
  (SELECT JobDescription,
          max(MissionCount) AS max_c,
          min(MissionCount) AS min_c
   FROM Personal
   GROUP BY JobDescription
   HAVING JobDescription='astrogator')
SELECT a.SpacemanID,
       a.JobDescription,
       a.MissionCount
FROM Personal AS a
JOIN exp_aust ON exp_aust.JobDescription=a.JobDescription
WHERE a.MissionCount IN (exp_aust.max_c,
                         exp_aust.min_c)
  AND a.JobDescription=exp_aust.JobDescription 
 --15
DECLARE @string varchar(100)='tf56sd#%OqH' ;

;

WITH string_splitter AS
  (SELECT 1 AS POS,
          substring(@string, 1, 1) AS char
   WHERE len(@string)>=1
   UNION ALL SELECT pos + 1,
                    SUBSTRING(@string, pos + 1, 1)
   FROM string_splitter
   WHERE pos + 1 <= LEN(@string))
SELECT STRING_AGG(CASE
                      WHEN char LIKE '[A-Z]' THEN char
                      ELSE ''
                  END, '') AS UPPER_LATERS,
       STRING_AGG(CASE
                      WHEN char LIKE '[a-z]' THEN char
                      ELSE ''
                  END, '') AS LOWER_LATERS,
       STRING_AGG(CASE
                      WHEN char LIKE '[0-9]' THEN char
                      ELSE ''
                  END, '') AS NUMBERS,
       STRING_AGG(CASE
                      WHEN char NOT LIKE '[A-Za-z0-9]' THEN char
                      ELSE ''
                  END, '') AS CHARACTERS
FROM string_splitter
--16

SELECT a.StudentID,
       a.Grade+isnull(b.Grade, 0) AS summ
FROM Students AS a
LEFT JOIN Students AS b ON (a.StudentID-1)=b.StudentID
SELECT StudentID,
       Grade,
       GRADE+LAG(GRADE) OVER (
                              ORDER BY STUDENTID) AS PREVIOUS_GRADE
FROM Students 
--17
DECLARE @SON INT=1
WHERE @SON=LEN(Equation)
  SELECT @SON ;

WITH numbers AS(
SELECT CASE WHEN (SUBSTRING(Equation, @SON+1, 1) LIKE '[0-9]' THEN TotalSum ELSE ''
                  FROM Equations )
--18

SELECT a.StudentName,
       b.StudentName,
       C.StudentName
FROM Student AS a
JOIN Student AS b ON a.Birthday=b.Birthday
JOIN Student AS c ON a.Birthday=c.Birthday
WHERE a.StudentName<>b.StudentName
  AND b.StudentName<>c.StudentName
  AND a.StudentName<>c.StudentName
GROUP BY a.StudentName,
         b.StudentName,
         C.StudentName
SELECT StudentName,
       Birthday
FROM Student
WHERE Birthday IN
    (SELECT Birthday
     FROM Student
     GROUP BY Birthday
     HAVING COUNT(StudentName)>1)
ORDER BY Birthday 
--19

SELECT A.PlayerA,
       A.PlayerB,
       A.Score+ISNULL(B.Score, 0) AS SCORES
FROM PlayerScores AS A
LEFT JOIN
  (SELECT PlayerB AS B,
          PlayerA AS A,
          Score
   FROM PlayerScores) AS B ON A.PlayerB=B.A
AND A.PlayerA=B.B
WHERE A.PlayerA<A.PlayerB
