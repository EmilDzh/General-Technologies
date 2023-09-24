-- Class Work 3

use learn;

drop table if exists students; -- удалит табличу только если оно есть

CREATE TABLE students(
name varchar(64),
surname varchar(64),
age integer,
rate numeric(8,3)
);

SELECT * FROM students;

INSERT INTO students VALUES('Alex', 'ALexeev', 35, 20);

INSERT INTO students (name, surname, age) VALUES('Alex', 'ALexeev', 35),
					                            ('Oleg', 'Olegov', 20), 
												('Maxim', 'Maximov', 40);
                                                
use hr;

CREATE TABLE students(
name varchar(64),
surname varchar(64),
age integer,
rate numeric(8,3)
);

INSERT INTO students (name, surname) (SELECT 
                                     first_name, 
									 last_name 
                                     FROM employees);

SELECT * FROM students;



use learn;



INSERT INTO students SET name = 'Elena', age = 25;

set sql_safe_updates = 0;

DELETE FROM students
WHERE rate is NULL;

TRUNCATE TABLE students; --- востановить таблицу нельзя

UPDATE students
SET rate = 0
WHERE rate is NULL;

UPDATE students
SET rate = rate + 10;

UPDATE students
SET rate = 50, age = 25
WHERE name = 'Oleg';

UPDATE students
SET rate = 40, age = 20
WHERE name = 'Alex';

SELECT * FROM students;



 
INSERT INTO students (name, surname, age) VALUES('Alex', 'Smirnov', 35),
					                            ('Oleg', 'Alexeev', 20), 
												('Maxim', 'Olegov', 40);
       
  CREATE TABLE new_students AS     
 SELECT *
 FROM students
 WHERE age < 25;                                               
                                                
 SELECT * FROM new_students;        
 
   CREATE TABLE new_students_v2 AS     
 SELECT 
 name, age
 FROM students
 WHERE age < 25;
 
 CREATE VIEW v_new_students_v2 AS     
 SELECT 
 name, age
 FROM students
 WHERE age < 25;
 
  SELECT * FROM  v_new_students_v2;
 /*
create two views - one with products with price less than 20000,other with price more than 20000
*/
  
  CREATE VIEW v_new_products AS
  SELECT *
  FROM products
  WHERE price > 20000;
  
  CREATE VIEW v2_new_products AS
  SELECT *
  FROM products
  WHERE price < 20000;
  
  SELECT * FROM v2_new_products;
  
  --------------------
  ALTER TABLE students
  ADD middlename varchar(64);
  
   ALTER TABLE students
  ADD COLUMN middlename varchar(64);
  
  ALTER TABLE students
  DROP COLUMN rate;
  
  ALTER TABLE students
  MODIFY middlename VARCHAR(10);
  
    ALTER TABLE students
  MODIFY middlename VARCHAR(128);
  
  ALTER TABLE students
  CHANGE middlename middle VARCHAR(128);
  
  
  SELECT * FROM students;
  
  -- Home Work ---
  
  /*
1) Создайте таблицу staff (
id целое число, 
name, строка
surname, строка
age, целое число
position - строка 
*/

CREATE TABLE staff(
id integer,
name varchar(64),
surname varchar(64),
age integer,
position varchar(64)
);

DROP TABLE staff;
/*
2) Заполните таблицу значениями из 10 строк по примеру :
1,'Alex','Alexeev',24,'worker'
2,'Oleg','Olegov',36,'administration'
……..
и так далее.
В качестве возможных значений в поле position используйте
 worker,administration, security
 */

INSERT INTO staff(id, name , surname,age, position) VALUES (1,'Alex','Alexeev',24,'worker'),
														   (2,'Oleg','Olegov',36,'administration'),
                                                           (3,'Roman','Romanenko',55,'security'),
                                                           (4,'Gleb','Romanenko',25,'administration'),
                                                           (5,'Boris','Arkadievich',22,'worker'),
                                                           (6,'Varya','Chernous',20,'administration'),
                                                           (7,'Semen','Lobanov',25,'worker'),
                                                           (8,'Alexander','Kerzhakov',30,'security'),
                                                           (9,'Philip','Kirkorov',40,'worker'),
                                                           (10,'Semen','Slepakov',35,'security');
 SELECT * FROM staff;
 
 /*3) Добавьте в уже готовую и заполненную таблицу поле salary - целое число. */
 
 ALTER TABLE staff
 ADD COLUMN salary integer;
 
 SELECT * FROM staff;
 
 /*
 4) Проставьте значение поля salary следующим образом :
если сотрудник категории worker - 1000
если сотрудник категории administration - 5000
если сотрудник категории security - 2000
*/
 
UPDATE staff
SET salary =
  CASE
    WHEN position = 'worker' 
    THEN 1000
    WHEN position = 'administration' 
    THEN 5000
    WHEN position = 'security' 
    THEN 2000
  END;
  
  -- Увеличьте всем сотрудникам зарплату в два раза.
  
  SELECT salary * 2 AS doubled_salary FROM staff;
  
  /* 6) Удалите из таблицы сотрудников, чей возраст больше чем 45.*/
  
  DELETE FROM staff
  WHERE age > 45;
  
  /*
  7) Создайте три представления :
  первое - хранит только сотрудников
   типа worker,
  второй - security,
  третье administratio
*/
  
  CREATE VIEW v_staff_v1 AS SELECT
  * FROM staff
  WHERE position = 'worker';
  
  SELECT * FROM v_staff_v1;
  
    CREATE VIEW v_staff_v2 AS SELECT
  * FROM staff
  WHERE position = 'security';
  
    SELECT * FROM v_staff_v2;
    
     CREATE VIEW v_staff_v3 AS SELECT
  * FROM staff
  WHERE position = 'administration';
  
      SELECT * FROM v_staff_v3;

 
  SELECT * FROM staff;
  
  /* 8) Создайте новую таблицу на основе выборки из таблицы staff,
      которая будет хранить только name,surname,position
      сотрудников , которые относятся к administration 
  */
  
  CREATE TABLE administration_staff AS 
  SELECT name, surname, position
  FROM staff
  WHERE position = 'administration';
  
  /* 
  Удалите колонку position из новой таблицы.
  */
  
ALTER TABLE administration_staff
DROP COLUMN position;
  
  SELECT * FROM administration_staff;
  
 
  
 
 

