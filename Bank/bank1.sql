-- show databases

-- create database bank

use bank;

create table if not exists bank_details(age int, job varchar(30), marital varchar(30),
 education varchar(30), `default` varchar(30), balance int,
 housing varchar(30), loan varchar(30), contact varchar(30), 
 `day` int, `month` varchar(30), 
 duration int, campaign int, pdays int, previous int , poutcome varchar(30), `y` varchar(30));
 
 show tables;
 
 describe bank_details;
 
--  insert into bank_details values (
--  30,"unemployed","married","primary","no",1787,"no","no","cellular",19,"oct",79,1,-1,0,"unknown","no"
--  );

-- select * from bank_details;

select * from bank_details
where education = 'primary' or balance<100;

select distinct job from bank_details;

select count(job) from bank_details;

select * from bank_details
order by balance desc;

select sum(balance) from bank_details;

select * from bank_details
where balance = (select 
min(balance) from bank_details
);
 
--  set sql_safe_updates = 0;
--  update bank_details
--  set balance = 0
--  where job = 'unknown';

-- delete from bank_details where job = 'unknown';
 
 
delimiter &&
 create procedure my_first_procedure()
 begin
	select * from bank_details;
 end &&
 

 
 
 call my_first_procedure();
 
 my_first_procedure
 
 call pre_filter_g_balance(1400);
 
 
 

 call pre_filter_g_balance_job(1400,'services');
 


