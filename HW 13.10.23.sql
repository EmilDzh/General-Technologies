-- Class Work 6

  /*
Task  2 . print name, surname employees and department name where he works,
but deparment must be IT, Treasury, IT Support
*/

  SELECT
    t1.first_name,
    t1.last_name,
    t2.department_name 
    FROM employees t1
    INNER JOIN departments t2
    ON t1.department_id = t2.department_id AND
    t2.department_name IN ('IT','Treasury','IT support');

use hr;

SELECT
department_id
FROM departments
WHERE department_name IN ('IT','Treasury','IT support');


 /* 
 SELECT
    t1.first_name,
    t1.last_name
    FROM employees t1
    WHERE t1.department_id IN (60,120,210);
    */
    
    SELECT * FROM employees;
    
    SELECT
    t1.first_name,
    t1.last_name
    FROM employees t1
    WHERE t1.department_id IN (
    SELECT
    department_id
    FROM departments
    WHERE department_name IN ('IT','Treasury','IT support'));
    
   SELECT
   t1.id,
   t1.name
   FROM
   (SELECT
    department_id id,
    department_name name
    FROM departments t1
    WHERE t1.department_name IN ('IT','Finance','IT support')) t1;
    
/*
Task 1 .print departments name without any workers
*/

SELECT * FROM employees;
SELECT * FROM departments;

SELECT
department_name
FROM departments
WHERE department_id IN(
SELECT
department_id
FROM employees
WHERE manager_id = null
);

/*
SELECT 
t2.department_name
FROM employees t1
INNER JOIN departments t2
ON t1.department_id != t2.department_id;
*/

SELECT 
t1.department_name,
t1.department_id,
t2.employee_id
FROM departments t1
LEFT JOIN employees t2
ON t1.department_id = t2.department_id
WHERE t2.employee_id is null;

SELECT 
department_name
FROM departments
WHERE department_id NOT IN (
SELECT DISTINCT department_id
FROM employees
WHERE department_id IS NOT NULL
);

/*
Task 2. Print name, surname, salary for employees who works in cities 
'Oxford', 'San Francisco'
*/

SELECT 
firt_name,
last_name,
salary
FROM employees
WHERE job_id IN (SELECT 
city
FROM locations
WHERE city IN ('Oxford', 'San Francisco'));

SELECT * FROM locations;


SELECT 
city
FROM locations
WHERE city IN ('Oxford', 'San Francisco');


SELECT DISTINCT department_id
FROM employees
WHERE department_id IS NOT NULL;

SELECT
t1.first_name,
t1.last_name,
t1.salary,
t1.department_id,
t2.department_id,
t3.city
FROM employees t1
INNER JOIN departments t2
ON t1.department_id = t2.department_id 
INNER JOIN locations t3
ON t3.location_id = t2.location_id
WHERE t3.city IN ('Oxford', 'South San Francisco');

SELECT 
t1.first_name,
t1.last_name,
t1.salary
FROM employees t1
WHERE t1.department_id IN (SELECT department_id FROM departments WHERE location_id
					IN(SELECT location_id FROM locations 
                    WHERE city IN ('Oxford', 'South San Francisco')));

SELECT department_id FROM departments WHERE location_id
					IN(SELECT location_id FROM locations 
                    WHERE city IN ('Oxford', 'South San Francisco'));

SELECT location_id FROM locations WHERE city IN ('Oxford', 'South San Francisco');

use shop;

SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM sellers;

SELECT 
t1.SNAME,
t2.SNAME BOSS_NAME
FROM sellers t1
LEFT JOIN sellers t2
ON t1.BOSS_ID = t2.SELL_ID;

-- Howe work

use shop;

/*
1.Выведите имена покупателей, которые совершили покупку на сумму больше 1000 условных единиц.
В выборке должно присутствовать два атрибута — cname, amt. 
*/

SELECT * FROM orders;
SELECT * FROM sellers;
SELECT * FROM customers;

SELECT
t3.CNAME,
t2.AMT
FROM sellers t1
INNER JOIN orders t2
ON t1.SELL_ID = t2.SELL_ID
INNER JOIN customers t3
ON t2.CUST_ID = t3.CUST_ID
WHERE t2.AMT >= 1000;

-- Error Code: 1054. Unknown column 't3.sname' in 'field list'

/*
3.Для каждого сотрудника выведите разницу между
 комиссионными его босса и его собственными.
 Если у сотрудника босса нет, выведите NULL.
Вывести : sname, difference.
 */
 
 SELECT
 t1.SNAME,
 CASE
    WHEN t2.COMM IS NULL THEN NULL
    ELSE t2.COMM - t1.COMM
    END AS difference
FROM sellers t1
LEFT JOIN sellers t2 
ON t1.BOSS_ID = t2.BOSS_ID;

/*
4.Выведите пары покупателей и обслуживших их продавцов из одного города.
Вывести: sname, cname, city
 */

SELECT 
t1.SNAME,
t3.CNAME,
t3.CITY
FROM sellers t1
INNER JOIN orders t2
ON t1.SELL_ID = t2.SELL_ID
INNER JOIN customers t3
ON t2.CUST_ID = t2.CUST_ID
WHERE t1.CITY = t3.CITY;

 
 
 
 



    

