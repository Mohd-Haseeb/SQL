use practice;

-- Create table Employees
-- (
--  ID int,
--  FirstName varchar(50),
--  LastName varchar(50),
--  Gender varchar(50),
--  Salary int
-- )

select * from employees order by salary desc;

-- HIGHEST SALARY
select max(salary) from employees;

-- 2nd HIGHEST SALARY
select max(salary) from employees
where salary < (select max(salary) from employees);

-- Nth HGHEST SALARY USING SUB QUERY ; NOTE : here N=4
select salary from 
(select distinct salary from employees order by salary desc limit 4) res
order by salary
limit 1;

-- Nth HIGHEST SALARY USING CTE
with result as (
select salary, DENSE_RANK() over(order by salary desc) myRank from employees
)

select salary from result
where myRank = 4
limit 1




