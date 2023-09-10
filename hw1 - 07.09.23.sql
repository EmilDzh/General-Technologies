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


