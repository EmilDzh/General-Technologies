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
    
    
    
    
    
    
   
   





					                            