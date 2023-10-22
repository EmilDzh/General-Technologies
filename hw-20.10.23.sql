-- classwork seven

-- Date 20.10.2023
-- Time 19:06
-- Year 2023
-- DateTime date+time
-- Timestamp 

use shop;

SELECT curdate(); -- only date

SELECT now(); -- date + time when run script

SELECT sysdate(); -- date + time function run

-- convert string to date 

SELECT str_to_date("2023-10-20 19:20:55", "%Y-%m-%d %H:%i:%s");

SELECT str_to_date("2023-10-20 19:20:55", "%Y-%m-%d");

SELECT str_to_date("20-10-23 19:20:55", "%d-%m-%Y");

-- extract data from date

SELECT extract(hour from "2023-10-20 19:20:55");
SELECT extract(year from "2023-10-20 19:20:55");
SELECT extract(month from "2023-10-20 19:20:55");

SELECT extract(month from "2023-10-20");

SELECT date_add("2023-10-20 19:20:55", interval 5 day); -- add some interval to date

SELECT date_add("2023-10-20 19:20:55", interval -5 day); -- substract some interval from date 

SELECT date_add("2023-10-20 19:20:55", interval -5 month);

SELECT datediff("2023-10-20", "2023-10-05"); -- difference between to dates in days

-- use database shop

/* 
1.print all orders in march
*/

SELECT * FROM orders;

SELECT * 
FROM orders
WHERE MONTH(ODATE) = 3;

/* 
2.print all orders from 10.04.2022 to 10.05.2022
*/

SELECT * 
FROM orders
WHERE ODATE between '2022-04-10' and '2022-05-10';

/* 
3.print count of orders in June
*/

-- COUNT all lines in result table

SELECT count(*)
FROM orders
WHERE MONTH(ODATE) = 6;

/* 
4.print avarage amount for orders in march
*/

-- AVG -count average from column

SELECT AVG(AMT)
FROM orders
WHERE MONTH(ODATE) = 3;

SELECT AVG(ODATE)
FROM orders
WHERE MONTH(ODATE) = 3;

/* 
5.print all orders in thuesday
*/

SELECT * 
FROM orders
WHERE WEEKDAY(ODATE) = 1;

/* 
6,7 example with group
*/

---------------- ------------------

CREATE DATABASE uni;

use uni;

create table Students(
  id integer primary key auto_increment,
    name varchar(128) not null,
    age integer
);

create table Teachers(
  id integer primary key auto_increment,
    name varchar(128) not null,
    age integer
);

create table Competencies(
  id integer primary key auto_increment,
    title varchar(128) not null
);

create table Teachers2Competencies(
  id integer primary key auto_increment,
    teacher_id integer,
    competencies_id integer
);

create table Courses(
  id integer primary key auto_increment,
    teacher_id integer,
    title varchar(128) not null,
    headman_id integer
);

create table Students2Courses(
  id integer primary key auto_increment,
    student_id integer,
    course_id integer
);

insert into students (name, age) values ('Анатолий', 29);
insert into students (name, age) values ('Олег', 25);
insert into students (name, age) values ('Семен', 27);
insert into students (name, age) values ('Олеся', 28);
insert into students (name, age) values ('Ольга', 31);
insert into students (name, age) values ('Иван', 22);

insert into teachers (name, age) values ('Петр', 39);
insert into teachers (name, age) values ('Максим', 35);
insert into teachers (name, age) values ('Антон', 37);
insert into teachers (name, age) values ('Всеволод', 38);
insert into teachers (name, age) values ('Егор', 41);
insert into teachers (name, age) values ('Светлана', 32);

insert into Competencies (title) values ('Математика');
insert into Competencies (title) values ('Информатика');
insert into Competencies (title) values ('Программирование');
insert into Competencies (title) values ('Графика');

insert into Teachers2Competencies (teacher_id, competencies_id) values (1, 1);
insert into Teachers2Competencies (teacher_id, competencies_id) values (2, 1);
insert into Teachers2Competencies (teacher_id, competencies_id) values (2, 3);
insert into Teachers2Competencies (teacher_id, competencies_id) values (3, 2);
insert into Teachers2Competencies (teacher_id, competencies_id) values (4, 1);
insert into Teachers2Competencies (teacher_id, competencies_id) values (5, 3);

insert into courses (teacher_id, title, headman_id) values (1, 'Алгебра логики', 2);
insert into courses (teacher_id, title, headman_id) values (2, 'Математическая статистика', 3);
insert into courses (teacher_id, title, headman_id) values (4, 'Высшая математика', 5);
insert into courses (teacher_id, title, headman_id) values (5, 'Javascript', 1);
insert into courses (teacher_id, title, headman_id) values (5, 'Базовый Python', 1);

insert into students2courses (student_id, course_id) values (1, 1);
insert into students2courses (student_id, course_id) values (2, 1);
insert into students2courses (student_id, course_id) values (3, 2);
insert into students2courses (student_id, course_id) values (3, 3);
insert into students2courses (student_id, course_id) values (4, 5);


SELECT * FROM students;

SELECT * FROM teachers;

SELECT * FROM courses;

SELECT * FROM competencies;

SELECT * FROM Students2courses;

SELECT * FROM teachers2competencies;

/* 
1.print all students names and their courses;
*/

SELECT
-- t1.*,
-- t2.*,
-- t3.*
t1.name,
t3.title
FROM Students t1
INNER JOIN Students2courses t2
ON t1.id = t2.student_id
INNER JOIN Courses t3
ON t3.id = t2.course_id;


/* 
print all teachers name with their competencies;
*/

SELECT 
-- t1.*,
-- t2.*,
-- t3.*
t1.name,
t3.title
FROM teachers t1
LEFT JOIN teachers2competencies t2
ON t1.id = t2.teacher_id
LEFT JOIN competencies t3
ON t2.competencies_id = t3.id;

/* 
3.print teacher name without any competencies;
*/

SELECT 
t1.*,
t2.*
FROM teachers t1
LEFT JOIN teachers2competencies t2
ON t1.id = t2.teacher_id
WHERE t2.competencies_id IS NULL;

/* 
4.print student name without any courses
*/

SELECT
-- t1.*,
-- t2.*
t1.name
FROM students t1
LEFT JOIN Students2courses t2
ON t1.id = t2.student_id
WHERE t2.course_id IS NULL;

/* 
5.print courses without any students
*/

SELECT
-- t1.*,
-- t2.*
t1.title
FROM courses t1
LEFT JOIN Students2courses t2
ON t1.id = t2.course_id
WHERE t2.student_id IS NULL;

/* 
6. print competencies without any teachers;
*/

SELECT 
t1.*,
t2.*
FROM competencies t1
LEFT JOIN teachers2competencies t2
ON t1.id = t2.competencies_id
WHERE t2.teacher_id IS NULL;

/* 
7.print course name and headman name
*/

SELECT
t1.title,
t2.name
FROM courses t1
INNER JOIN students t2
ON t1.headman_id = t2.id;

/* 
8. 7. вывести имя студента и имена  старост, которые есть на курсах, которые он проходит
*/

use uni;

SELECT
    t1.name,
    t3.headman_id,
    t3.title
FROM students t1
LEFT JOIN Students2courses t2
 ON t1.id = t2.student_id
LEFT JOIN courses t3
ON t2.course_id = t3.id
LEFT JOIN students t4
ON t3.headman_id = t4.id;


SELECT * FROM courses;
SELECT * FROM students;
SELECT * FROM Students2courses;


use shop;
SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM sellers;

/*
2.Используем БД shop :
Выведите имена покупателей, которые сделали заказ.
Предусмотрите в выборке также имена продавцов.
Примечание: покупатели и продавцы должны быть из разных городов.
В выборке должно присутствовать два атрибута — cname, sname.
 */
 
 SELECT
 t1.CNAME,
 t3.SNAME
 FROM customers t1
 INNER JOIN orders t2
 ON t1.cust_id = t2.cust_id
 INNER JOIN sellers t3
 ON t2.sell_id = t3.sell_id
 WHERE t1.city <> t3.city;
 
 /*
 3..Используем БД shop :
Вывести имена покупателей которые ничего никогда не покупали.
Решить задачу двумя способами : через join и через подзапрос
 */
 
 SELECT 
 t1.cname
 FROM customers t1
 LEFT JOIN orders t2
 ON t1.cust_id = t2.cust_id
 WHERE t2.order_id IS NULL;
 
 SELECT 
 CNAME
 FROM customers
 WHERE cust_id NOT IN (SELECT cust_id FROM orders);



