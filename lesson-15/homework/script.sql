--1--Retrieve employees who earn the minimum salary in the company. Tables: employees (columns: id, name, salary)
select * from employees as emp
where salary=(select min(salary) from employees  )

--2--Task: Retrieve products priced above the average price. Tables: products (columns: id, product_name, price)
select * from products as pr
where price>(select  avg(price)from products as pp)
--3-Find Employees in Sales Department Task: Retrieve employees who work in the "Sales" department. Tables: employees (columns: id, name, department_id), departments (columns: id, department_name)
select * from employees
where department_id=(select id from departments where department_name like 'sales')
--4--Retrieve customers who have not placed any orders. Tables: customers (columns: customer_id, name), orders (columns: order_id, customer_id)
select * from customers as cst
where customer_id not in(
select customer_id from orders)
---5 Find Products with Max Price in Each Category
select * from products as nam
where price in 
(select max(price) from products
group by category_id  )
--6
select * from employees
		where salary<=(select avg(salary) from employees)
order by salary desc

SELECT e.*
FROM employees e
JOIN (
    SELECT TOP 1 department_id
    FROM employees
    GROUP BY department_id
    ORDER BY AVG(salary) DESC
) AS top_dept
ON e.department_id = top_dept.department_id;

---7--Retrieve employees earning more than the average salary in their department. Tables: employees (columns: id, name, salary, department_id)
;select emp.*
from employees as emp
where emp.salary>(
					select avg(avg_sal.salary) 
					from employees as avg_sal
					where emp.department_id=avg_sal.department_id
					)
--8 Task: Retrieve students who received the highest grade in each course. Tables: students (columns: student_id, name), grades (columns: student_id, course_id, grade)
select a.name,b.course_id,max(b.grade) from students as a
left join grades as b
on a.student_id=b.student_id
group by a.name,b.course_id

--9  Find Third-Highest Price per Category Task: Retrieve products with the third-highest price in each category. Tables: products (columns: id, product_name, price, category_id)
SELECT * FROM products
;WITH RankedProducts AS (
    SELECT 
        id,
        product_name,
        price,
        category_id,
        DENSE_RANK() OVER (
            PARTITION BY category_id 
            ORDER BY price DESC
        ) AS price_rank
    FROM products
)
SELECT 
    id,
    product_name,
    price,
    category_id
FROM RankedProducts
WHERE price_rank = 3;

--10

select * from employees as a
join (SELECT AVG(salary) AS AVG_COMP FROM  employees) as b
on a.salary>b.AVG_COMP
join (SELECT department_id,MAX(salary) AS  MAX_DEP FROM  employees
			GROUP BY department_id) as c
on a.salary<c.MAX_DEP
