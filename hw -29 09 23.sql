-- Classwork 4

use learn;

drop table if exists students;

-- not null
-- check -- определенная значение от и до
-- unique
-- primary key -- for column id первичный ключь , это обьединение 2 канстрейнов -- not null + unique

CREATE TABLE students(
id integer primary key auto_increment,
name varchar(64) not null,
surname varchar(64) not null default '',
age integer check (age between 18 and 120),
phone varchar(32) unique
);

INSERT INTO students (id,name, surname, age, phone) VALUES(1,'Alex', 'ALexeev', 35,'777-888-999');
-- Error Code: 1062. Duplicate entry '1' for key 'students.PRIMARY'	0.000 sec


SELECT * FROM students;

INSERT INTO students (id,name, surname, age, phone) VALUES(2,'Alex', 'ALexeev', 35,'777-888-000');
-- Error Code: 1062. Duplicate entry '777-888-999' for key 'students.phone'	0.000 sec

SELECT * FROM students;

INSERT INTO students (id,name, surname, age, phone) VALUES(3,'Alex', null, 40,'777-888-001');
-- Error Code: 1048. Column 'surname' cannot be null


INSERT INTO students (id,name, age, phone) VALUES(3,'Alex', 40,'777-888-001');
-- Error Code: 1364. Field 'surname' doesn't have a default value	0.000 sec


-- Error Code: 3819. Check constraint 'students_chk_1' is violated.

INSERT INTO students (name, surname, age, phone) VALUES('Alex', 'ALexeev', 35,'777-888-000');

INSERT INTO students (name, surname, age, phone) VALUES('Alex', 'ALexeev', 40,'777-888-001');

SELECT * FROM students;

set sql_safe_updates = 0;

DELETE FROM students
WHERE age = 40;

DELETE FROM students;

TRUNCATE TABLE students;

INSERT INTO students (name, age, phone) VALUES('Alex',  35,'777-888-002');

/* Task 1
students :
name, lastname - ne null
avg_mark - from 0 to 5.   numeric(2,1)
gender "M" "F" 
*/


CREATE TABLE students(
name varchar(64) not null,
lastname varchar(64) not null,
avg_mark numeric(2,1) check(avg_mark between 0 and 5),
gender VARCHAR(128) CHECK (gender IN ('M', 'F'))
);

/*
Олег Петров 4.3 M

Семен Степанов 3.1 M 

Ольга Семенова 4.7 F 

Игорь Романов 3.1 M 

Ирина Иванова 2.2 F 
*/

INSERT INTO students (name, lastname, avg_mark, gender) VALUES('Oleg','Petrov',4.3,'M'),
                                                              ('Semen','Stepanov',3.1,'M'),
                                                              ('Olga','Semenova',4.7,'F'),
                                                              ('Igor','Romanov',3.1,'M'),
                                                              ('Irina','Ivanova', 2.2 ,'F');
                                                              
SELECT * FROM students;

ALTER TABLE students
ADD COLUMN id integer primary key auto_increment;

-- UNION, UNION ALL (add new strings to end of the table)

CREATE TABLE goods(
id integer primary key auto_increment,
title varchar(32),
quantity integer check(quantity > 0),
in_stock char(1) check(in_stock in('Y','N'))
);


CREATE TABLE goods_two(
id integer primary key auto_increment,
title varchar(32),
quantity integer check(quantity > 0),
price integer,
in_stock char(1) check(in_stock in('Y','N'))
);

insert into goods (title,quantity,in_stock) 
  values ('bike',2,'Y'),
    ('skates',4,'Y'),
    ('skis',2,'Y'),
    ('board',7,'N'),
    ('scooter',1,'N'),
	('bicycle',5,'Y');
                
insert into goods_two (title,quantity,price,in_stock) 
  values ('bike',2,500,'Y'),
   ('skis',2,100,'Y'),
    ('board',7,300,'N'),
    ('scooter',1,200,'N'),
	('form',10,35,'Y');
    
    SELECT * FROM goods;
    SELECT * FROM goods_two;
    
    SELECT title
    FROM goods
    UNION ALL -- union all get all strings with duplicates;
    SELECT title
    FROM goods_two;
    
        SELECT title
    FROM goods
    UNION  -- union all get all strings without duplicates;
    SELECT title
    FROM goods_two;
    
    SELECT id, title , quantity FROM goods
    UNION ALL
    SELECT id, title , quantity, price FROM goods_two;
    
   -- Error Code: 1222. The used SELECT statements have a different number of columns
   
	SELECT id, title, 0 as new_price, quantity FROM goods
    UNION ALL
    SELECT id, title, price , quantity FROM goods_two;
    
    SELECT  title, id, price, quantity FROM goods_two
    UNION ALL
    SELECT  title, id,  0 as new_price , quantity FROM goods;
    
    SELECT * FROM students;
    
    -- Задача 4. Поменять тип у gender на char(1)(вспоминаем modify)
    ALTER TABLE students
    MODIFY gender char(1);
    
    -- Задача 5. переименовать поле name на firstname
    
    ALTER TABLE students
    CHANGE COLUMN name firstname varchar(255);
    
    /*
    Задача 6. Выборки

	найти учеников, у которых оценка больше 4

    найти учеников, у которых не входит в диапазон от 3 до 4

    найти учеников, у которых имя начинается на И

	найти учеников, у которых оценка 2.2 или 3.1 или 4.7
    */
    
    SELECT * FROM students;
    
    SELECT * FROM students
    WHERE avg_mark > 4;
    
    
     SELECT * FROM students
    WHERE avg_mark NOT BETWEEN 3 AND 4;
    
     SELECT * FROM students
    WHERE firstname LIKE 'I%';
    
     SELECT * FROM students
    WHERE avg_mark IN (2.2, 3.1, 4.7);
    
    -- Задача 7. Создать представление, которое содержит всех мужчин
    
    CREATE VIEW male_students AS
    SELECT * FROM students
    WHERE gender = 'M';
    
    SELECT * FROM male_students;
    
    -- Задача 8. Создать представление, которое содержит всех женщин
    
    CREATE VIEW female_students AS
    SELECT * FROM students
    WHERE gender = 'F';
    
    SELECT * FROM female_students;
    
    -- Задача 9. Найти набор уникальных оценок
    
    SELECT DISTINCT avg_mark FROM students;
    
    /*
    Задача 10. Увеличить всем учащимся оценку в 10 раз 
    (предварительно нужно сделать drop check на колонке с оценками,
     а так же изменить тип колонки на более большой numeric(3,1))
    */
    
    ALTER TABLE students
    MODIFY avg_mark numeric(3,1);
    
    UPDATE students
    SET avg_mark = avg_mark * 10;
    
    -- Задача 11. Поменяйте у Олега Петрова фамилию на Сидоров
    
    UPDATE students
    SET lastname = 'Sidorov'
    WHERE firstname = 'Oleg' AND lastname = 'Petrov'; 
    
    -- Задача 12. Для всех учеников, у которых оценка не больше 31 увеличить на 10
    
    UPDATE students
    SET avg_mark = avg_mark + 10
    WHERE avg_mark <= 31;
    
    SELECT * FROM students;
    
    -- INNER JOIN
    
    use learn;
    
    CREATE TABLE stud (
    id integer primary key auto_increment,
    name varchar(128) not null,
    surname varchar(128) not null
    );
    
    CREATE TABLE ages (
    student_id integer unique,
    age integer
    );
    
   INSERT INTO stud (name , surname) VALUES ('ALEX', 'ALEXEEV'),
											('Oleg', 'Olegov'),
											('Maxim', 'Maximov');
                                            
   SELECT * FROM stud;    
   
   /*
   Alex Alexeev 20 id 1 Algo
   Oleg Olegov 34  id 2 Java
   Maxim Maximov 25 id 3 Sql
   */
   
   INSERT INTO ages (student_id, age) VALUES (1,20),(2,34),(3,25);
   
     INSERT INTO ages (student_id, age) VALUES (5,54);
   
   SELECT * FROM ages;
   
   INSERT INTO stud (name , surname) VALUES ('Petr', 'Petrov');
   
   SELECT 
   t1.id,
   t1.name,
   t1.surname,
   t2.age
   FROM stud t1 
   INNER JOIN ages t2
   ON t1.id = t2.student_id;
   
     /*
   Alex Alexeev 20 id 1 Algo
   Oleg Olegov 34  id 2 Java
   Maxim Maximov 25 id 3 Sql
   */
   
   CREATE TABLE curses (
   id integer primary key auto_increment,
   name varchar(128)
   );
   
   INSERT INTO curses (name) VALUES ('JAVA'), ('ALGO'), ('SQL');
   
    INSERT INTO curses (name) VALUES ('JS');
   
   SELECT * FROM curses;
   
   CREATE TABLE course2student (
   student_id integer,
   course_id integer
   );
    /*
    id 1 - JAVA, ALGO
    id 2 - ALGO
    id 3 - SQL, ALGO
    
    */
    
    INSERT INTO course2student (student_id, course_id) VALUES (1,1),(1,2), (2,2),(3,3),(3,2);
    
     INSERT INTO course2student (student_id, course_id) VALUES (6,4);
     
    SELECT
    t1.id,
    t1.name,
    t1.surname,
    t3.name course_name
    FROM stud t1
    INNER JOIN course2student t2
    ON t1.id = t2.student_id
    INNER JOIN curses t3
    ON t3.id = t2.course_id;
    
    CREATE TABLE contacts (
    student_id integer unique,
    phone long
    );
    
    INSERT INTO contacts (student_id,phone) VALUES (1,1234),(2,2222),(3,3333),(4,4444);
    INSERT INTO contacts (student_id,phone) VALUES (4,5555);
    
    SELECT * FROM contacts;
    
    SELECT 
    t1.id,
    t1.name,
    t1.surname,
    t2.phone PHONE
    FROM stud t1
    INNER JOIN contacts t2
    ON t1.id = t2.student_id;
    
    /*
    
    CREATE TABLE contacts (
    student_id integer,
    phone varchar(128)
    )
    
    INSERT INTO contacts (student_id, phone) VALUES (1,'1234'),(2,'2222'),(4,'3333'),(4,'4444');
     SELECT 
    t1.id,
    t1.name,
    t1.surname,
    t2.phone PHONE
    FROM stud t1
    INNER JOIN contacts t2
    ON t1.id = t2.student_id;
    
    */
    
    -- LEFT JOIN
    
      SELECT 
    t1.id,
    t1.name,
    t1.surname,
    t2.phone PHONE
    FROM stud t1
    LEFT JOIN contacts t2
    ON t1.id = t2.student_id;
    
    -- RIGHT JOIN
    
	SELECT 
    t1.id,
    t1.name,
    t1.surname,
    t2.age
    FROM stud t1
    RIGHT JOIN ages t2
    ON t1.id = t2.student_id;
    
    use hr;
    
    SELECT * FROM employees;
    
    SELECT * FROM departments;
    
    /*
Task  1 . print name, surname employees and department name where he works
*/
    
    SELECT
    t1.first_name,
    t1.last_name,
    t2.department_name 
    FROM employees t1
    INNER JOIN departments t2
    ON t1.department_id = t2.department_id;
   
   
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
    ON t1.department_id = t2.department_id
    WHERE t2.department_name IN ('IT','Treasury','IT support');
    
    SELECT
    t1.first_name,
    t1.last_name,
    t2.department_name 
    FROM employees t1
    INNER JOIN departments t2
    ON t1.department_id = t2.department_id AND t2.department_name IN ('IT','Treasury','IT support');
    
    
/*
Task  3 . print name, surname employees and name and surname his manager
*/

-- self JOIN
SELECT 
  t1.first_name,
  t1.last_name,
  t2.first_name manager_name,
  t2.last_name manager_last_name
FROM employees t1
INNER JOIN employees t2
ON t1.manager_id = t2.employee_id;

SELECT 
  t1.first_name,
  t1.last_name,
  t2.first_name manager_name,
  t2.last_name manager_last_name
FROM employees t1
LEFT JOIN employees t2
ON t1.manager_id = t2.employee_id;

use hr;

SELECT * FROM employees;

-- 1.Вывести job_id тех 
-- сотрудников, которые зарабатывают больше своего менеджера(прием SELF join)

SELECT
t1.job_id
FROM employees t1
INNER JOIN employees t2
ON t1.manager_id = t2.employee_id
WHERE t1.salary > t2.salary;

-- 2.Вывести имя, фамилию и город сотрудников, 
-- которые работают в Seattle или Toronto (участвуют три таблицы)

SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM countries;
SELECT * FROM locations;

SELECT
t1.first_name,
t1.last_name,
t3.city
FROM employees t1
INNER JOIN departments t2
ON t1.department_id = t2.department_id
INNER JOIN locations t3
ON t2.location_id = t3.location_id
WHERE t3.city IN ('Seattle', 'Toronto');

-- 3.Вывести имя, фамилию,
-- название департамента и название должности сотрудника(участвуют три таблицы)

SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM jobs;

SELECT
t1.first_name,
t1.last_name,
t2.department_name,
t3.job_title
FROM employees t1
INNER JOIN departments t2
ON t1.department_id = t2.department_id
INNER JOIN jobs t3
ON t1.job_id = t3.job_id;





    
 
    



    
    
    
    
    
    
    
    
    
    
    
    
    
    
   
   





					                            