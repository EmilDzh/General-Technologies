-- Class WOrk nine

use hr;

SELECT * FROM employees;
use shop;

SELECT * FROM sellers;

/* 
Task one - print count of employees for each manager
*/

SELECT
COUNT(*) count_of_empl
FROM sellers
GROUP BY boss_id;

use hr;

SELECT
manager_id,
COUNT(*) AS count_of_empl
FROM employees
GROUP BY manager_id;

/*
Task two - print department name, count of employees for each department
 */

SELECT * FROM employees;
SELECT * FROM departments;
 
 SELECT
 t2.department_name,
 COUNT(*) AS count_epls
 FROM employees t1
 INNER JOIN departments t2
 ON t1.department_id = t2.department_id
 GROUP BY department_name;
 
 SELECT 
 t1.department_name,
 COUNT(t2.employee_id) AS empls_count
 FROM departments t1
 LEFT JOIN employees t2
 ON t1.department_id = t2.department_id
 GROUP BY department_name;
 
 /* 
 Task three - print max salary in each department, department_id ,max salary
 */
 
 SELECT
 department_id,
 MAX(salary) as MAX_SALARY
 FROM employees
 GROUP BY department_id;
 
 /* 
 Task four - print manager name, surname and count of employees for each manager
 */
 
SELECT * FROM employees;
 
 SELECT
#t1.employee_id,
#t2.employee_id as manager_id,
t2.first_name,
t2.last_name,
#COUNT(t1.employee_id) as employees_cnt
COUNT(*) as employees_cnt
FROM employees t1
INNER JOIN employees t2
ON t1.manager_id = t2.employee_id
GROUP BY t2.first_name, t2.last_name;

-- Home work

/*
Используйте базу данных hr;
Найти департамент с наибольшим 
количеством сотрудников(вывести название департамента и ид департамента)
 */
 
 use hr;
SELECT * FROM employees;
SELECT * FROM departments;


SELECT d.department_id, d.department_name
FROM departments d
WHERE d.department_id = (
    SELECT department_id
    FROM employees
    GROUP BY department_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
    
);



 

 