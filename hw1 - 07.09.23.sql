create database learn;


use learn;

create table products(
id integer primary key auto_increment,
title varchar(128),
price integer,
discount decimal(2,1)
);

insert into products (title,price,discount)
values ('bike', 50000,0.9),
('skates', 15000,0.1),
('skis', 25000,null),
('board', 30000,0.9),
('scooter', 10000,0.8);

select *
from products;

select 
   title, 
   price,
   discount
from products;

select 
   title as name, 
   price as original_price,
   discount,
   price * discount as price_with_discount,
   'new year action' as sale
from products;

select 
   title, 
   price,
   discount
from products
where title = 'bike';

select 
   title, 
   price,
   discount
from products
where price > 20000;

select 
   title, 
   price,
   discount
from products
where title = 'bike' or title = 'board' or title = 'skis';

select 
   title, 
   price,
   discount
from products
where title in ('bike','board','skis');

select 
   title, 
   price,
   discount
from products
where title not in ('bike','board','skis');

select * from products;

select 
   title, 
   price,
   discount
from products
where title in ('bike','board','skis') and price >= 30000;


select 
   title, 
   price,
   discount
from products
where  price <= 30000 and price >=15000;


select 
   title, 
   price,
   discount
from products
where  price between 15000 and 30000;

select 
   title, 
   price,
   discount
from products
where  price not between 15000 and 30000;

select * from products;

select 
   title, 
   price,
   discount
from products
where title like 'b%';

select 
   title, 
   price,
   discount
from products
where title like '%sk%';

select 
   title, 
   price,
   discount
from products
where title like '%t%';

select 
   title, 
   price,
   discount
from products
where title like '%i_';

insert into products (title,price,discount)
values (null, 45000,0.9);

insert into products (title,price,discount)
values ('', 55000,0.9);

select * from products;

select * 
from products
where title = '';

select * 
from products
where title is null;

select * 
from products
where title is not null;

use hr;

select * from employees;
/*1) найти всех сотрудников, c jobid = ITPROG*/

select *
from employees
where job_id = 'IT_PROG';

/*2) найти сотрудников, с зп больше 10 000*/

select *
from employees
where salary >= 10000;

/*3) найти сотрудников, с зп от 10 000 до 20 000 (включая концы)*/

select * 
from employees
where salary between 10000 and 20000;

/*4) найти сотрудников не из 60, 30 и 100 департамента */

select * 
from employees
/*where department_id <> 60 or department_id <> 30 or department_id <> 100;*/
where department_id not in (60,30,100);

/*5) найти сотрудников, у которых фамилия кончается на a */

select *
from employees
where last_name like '%a';

/* 6) вывести зарплату сотрудника с именем ‘Lex’ и фамилией ‘De Haan' */

select 
salary
from employees
where first_name = 'Lex' and last_name = 'De Haan';

/*1) найти всех сотрудников, работающих в департаменте с id 90 */

select *
from departments
where department_id = 90;

/*2) найти все департаменты, у которых location_id 1700 */

select *
from departments
where location_id = 1700;

use hr;

select * from locations;

use learn;

select 
title,
price,
discount
from products
where title is not null;

SELECT 
title,
price,
discount
FROM products
WHERE title IS NOT NULL
AND price > 20000;

SELECT * FROM products;

SELECT
title,
price,
CASE
    WHEN price <= 10000
	THEN 1
    WHEN price <= 20000
	THEN 2
     WHEN price <= 30000
	THEN 3
	ELSE 4 
END AS price_group
from products;

use hr;

SELECT * FROM employees;

SELECT
first_name,
last_name,
salary,
CASE
WHEN salary <= 10000
	THEN 0
    ELSE 1
END AS salary_group
FROM employees;

use learn;

SELECT * FROM products;


SELECT 
title,
price,
price *(CASE
			WHEN discount IS NULL
            THEN 1
            ELSE discount
            END) AS price_with_discount
FROM products;

SELECT 
title,
price,
price * COALESCE(discount, 1) AS price_with_discount
FROM products;

SELECT 
title,
price,
price * COALESCE(discount, 1) AS price_with_discount
FROM products
ORDER BY price DESC, title; /* сортировка */

use hr;

SELECT * FROM employees;

SELECT DISTINCT /* убирает дубликаты */
job_id
FROM employees;

SELECT 
first_name,
last_name
FROM employees
ORDER BY first_name DESC, last_name DESC;

SELECT *
FROM employees
WHERE department_id IN (60,90,110)
ORDER BY last_name;

use learn;
-- MAth
SELECT 
SQRT(price)
price,
price * 2 AS double_price,
price - 5000 AS price_one,
price + 5000 AS price_two,
price / 5000 AS price_three,
price % 2 AS price_four,
price * discount AS new_price
FROM products;

-- base funktion

SELECT -1 AS value;
SELECT ABS(-2) AS value; -- по модулю
SELECT POW(3,2) AS value; -- возведение в степень
SELECT SQRT(144) AS value; -- корень
SELECT ROUND(3.6) AS value; -- округление

-- string function

SELECT CONCAT('HELLO','', 'WORLD' );

SELECT CONCAT_WS('-', 'hello', 'world', 2023);

SELECT LENGHT('HeLLO'); -- 1 byte for English letters	
SELECT LENGHT('Привет'); -- 2 byte for Cirilish

SELECT TRIM('    hello world       '); -- обрезает пробелы с 2 сторон
SELECT LTRIM('    hello world       ');
SELECT RTRIM('    hello world       ');

SELECT LOWER('HeLLo');
SELECT UPPER('HeLLo');

SELECT SUBSTRING('hello world',7);

SELECT REPLACE('49-555-666-777','-','');

SELECT INSERT('hello world',7,5,'class');

-- airport database

use airport;

SELECT * FROM airliners;

SELECT 
model_name,
production_year,
distance,
CASE

    WHEN distance < 1000 
	THEN 'walk'
    
	WHEN distance > 1000 
		AND distance <= 2500
	THEN 'short'
    
    WHEN distance > 2500
		AND distance <= 6000
	THEN 'medium'
    
	WHEN distance > 6000
	THEN 'long'

END AS category
FROM airliners;

use airport;
SELECT * FROM tickets;

/*  Используйте бд airport :
1) Выведите данные о билетах разной ценовой категории. Среди билетов экономкласса (Economy)
 добавьте в выборку билеты с ценой от 10 000 до 11 000 включительно. 
Среди билетов комфорт-класса (PremiumEconomy) — билеты с ценой от 20 000 
до 30 000 включительно. 
Среди билетов бизнес-класса (Business) — с ценой строго больше 100 000.
 В решении необходимо использовать оператор CASE.
В выборке должны присутствовать три атрибута — id, service_class, price. */

SELECT 
id, 
service_class, 
price,
CASE
     WHEN service_class = 'Economy' AND price BETWEEN 10000 AND 11000
	 THEN 'Economy'
     
     WHEN service_class = 'PremiumEconomy' AND price BETWEEN 20000 AND 30000
	 THEN 'PremiumEconomy'
     
     WHEN service_class = 'Business' AND price > 100000
	 THEN  'Business'
     ELSE 'Other'


END AS Price_group
FROM tickets;

/*2) Разделите самолеты на три класса по возрасту.
 Если самолет произведен раньше 2000 года, то отнесите его к классу 'Old'.
 Если самолет произведен между 2000 и 2010 годами включительно, 
 то отнесите его к классу 'Mid'. Более новые самолеты отнесите к классу 'New'. 
 Исключите из выборки дальнемагистральные самолеты с максимальной дальностью 
 полета больше 10000 км. Отсортируйте выборку по классу возраста в порядке возрастания.
В выборке должны присутствовать два атрибута — side_number, age. */

SELECT * FROM airliners;

SELECT 
side_number,
production_year,
CASE
	WHEN production_year < 2000 
	THEN 'Old'
    WHEN production_year BETWEEN 2000 AND 2010 
	THEN 'Mid'
    ELSE 'New'

END AS Age
FROM airliners
WHERE distance < 10000
ORDER BY Age;

/*3)Руководство авиакомпании снизило цены на билеты рейсов 
LL4S1G8PQW, 0SE4S0HRRU и JQF04Q8I9G. Скидка на билет экономкласса (Economy)
 составила 15%, на билет бизнес-класса (Business) — 10%, 
 а на билет комфорт-класса (PremiumEconomy) — 20%. Определите цену билета в каждом
 сегменте с учетом скидки.
В выборке должны присутствовать три атрибута — id, tripid, newprice. */

SELECT * FROM tickets;

SELECT 
id,
trip_id,
CASE
	WHEN trip_id = 'LL4S1G8PQW' AND service_class = 'Economy'
    THEN price * 0.8
    
    WHEN trip_id = '0SE4S0HRRU' AND service_class = 'Business'
    THEN price * 0.9
    
     WHEN trip_id = 'JQF04Q8I9G' AND service_class = 'PremiumEconomy'
    THEN price * 0.85

END AS New_price
FROM tickets;

/*База HR:
1) Вывести сотрудников, чьи имена начинаются на букву D и 
отсортировать их в алфавитном порядке по фамилии */

use hr;

SELECT * FROM employees;

SELECT 
first_name,
last_name
FROM employees
WHERE first_name LIKE 'D%'
ORDER BY last_name;












