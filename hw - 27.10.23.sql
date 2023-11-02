-- class wort eight

-- count(column_name) - count not null values;

-- count(*) all lines in result table

-- max(column_name) maxx value in the column

-- min(column_name) min value in the column

-- avg(column_name) average value in the column

-- sum(column_name) sum values in the column

use hr;

SELECT * FROM employees;

SELECT 
max(salary) AS max_salary,
min(salary) AS min_salary,
avg(salary) AS avg_salary,
sum(salary) AS sum_salary,
count(salary) AS count_employees
FROM employees;

SELECT 
count(commission_pct) AS count_commission,
count(*) AS count_employees
FROM employees;

-- print count employees whithout manager

SELECT  
COUNT(*) AS count_employees_without_manager
FROM employees
WHERE manager_id IS NULL;

SELECT 
COUNT(manager_id) AS count_employees_with,
COUNT(*) AS count_employees_without
FROM employees;

-- print name, surname employee(s) with max salary

SELECT
first_name AS name,
last_name AS surname,
salary AS salary
FROM employees
WHERE salary = (
      SELECT
      MAX(salary) AS max_salary
      FROM employees);
      
      /* 
	  TASK 1.print Max salary
      */
      
 SELECT
      MAX(salary) AS max_salary
      FROM employees;
      
      /* 
      TASK 2.print count of employees 
      */
      SELECT 
COUNT(*) AS count_employees_without
FROM employees;

/* 
TASK 3  print name, surname employee(s) with max salary
*/

SELECT
first_name AS name,
last_name AS surname,
salary AS salary
FROM employees
WHERE salary = (
      SELECT
      MAX(salary) AS max_salary
      FROM employees);
      
/* 
TASKE four print average salary by company
*/

SELECT
AVG(salary) AS avg_salaty
FROM employees;

/* 
TASK five print name, surname , salary from employees who get salary less than avg by company
*/

SELECT
first_name as name,
last_name as surname,
salary
FROM employees
WHERE salary < (SELECT 
avg(salary) avg_salary
FROM employees);

/* 
TASK six - print count of departments
*/

SELECT 
COUNT(*) AS departmnets_count
FROM departments;

/*
TASK seven - print count of departments without any workers
 */
 
 SELECT 
-- t1.department_name,
-- t2.department_id,
-- t2.first_name,
-- t2.department_id
COUNT(*) AS departments_count_WTH_workers
 FROM departments t1
LEFT JOIN employees t2
ON t1.department_id = t2.department_id
WHERE t2.department_id IS NULL;

SELECT 
department_id
FROM employees
WHERE department_id NOT IN (
				    SELECT 
                    department_id
					FROM employees);

SELECT
COUNT(DISTINCT department_id)
FROM employees;
      
      
/* 
TASK eight print avg salary in department with id = 90
*/

SELECT 
AVG(salary) AS avg_salary
FROM employees
WHERE department_id = 90;

/* 
TASK nine print max salary in departments with id 70,80
*/

SELECT
MAX(salary) AS max_salary_70_80
FROM employees
WHERE department_id IN (70,80);


/*
Task ten - print count employees from departments with id 100 who earn more than 5000
*/

SELECT
COUNT(salary > 5000) count_empl
FROM employees
WHERE department_id = 100;

SELECT
COUNT(*) as department_cnt_without_workers
FROM departments
WHERE department_id NOT IN ( SELECT department_id FROM employees WHERE department_id IS NOT NULL );

/*
Task eleven - print count of employees from department with id 60 who earn more than average salary by company
*/

SELECT 
-- COUNT(employee_id) AS employees_count
COUNT(*) AS employees_count 
FROM employees
WHERE department_id = 60 AND salary > (
          SELECT
          AVG(salary)  
          FROM employees);
          
/* 

100 (90)
200 (70)
300 (100)
100 (90)

sum(s) -> 700

s.   d_id
100 (90)/
200 (70)/
300 (100)
100 (90)

sum(s)

group by d_id

90 200
100 200
300 300
*/

/* 
TASK one print count of employees for each departmnent 
*/
SELECT
department_id,
COUNT(*) employees_count
FROM employees
GROUP BY department_id;

use shop;

SELECT * FROM orders;

/* 
TASK two - print count of orders for each client (use db shop)
*/

SELECT
cust_id,
COUNT(*) orders_count
FROM orders
GROUP BY cust_id;

/* 
TASK three -  print name, id and count or orders for each customer
*/

SELECT 
t1.cname,
t1.cust_id,
t2.orders_count
FROM customers t1
INNER JOIN (
    SELECT
    cust_id,
    COUNT(*) orders_count
    FROM orders
    GROUP BY cust_id
) t2
ON t1.cust_id = t2.cust_id;

use shop;

-- HW
use hr;

SELECT * FROM employees;

/* 
Найти сотрудников(вывести информацию о них - имя, фамилию), 
у которых наибольшая зарплата в их конкретном департаменте
*/

SELECT
first_name,
last_name,
salary,
department_id
FROM employees
WHERE (department_id ,salary) IN 
(SELECT 
department_id,
MAX(salary) AS max_SALARY
FROM employees
GROUP BY department_id);












