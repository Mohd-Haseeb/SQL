delimiter &&
create procedure pre_filter_g_balance(IN minimum_balance int)
begin
	select * from bank_details
    where balance > minimum_balance ;
end &&


-- call pre_filter_g_balance(1400); 

delimiter &&
create procedure pre_filter_g_balance_job(IN minimum_balance int, IN job_name VARCHAR(30))
begin
	select * from bank_details
    where balance > minimum_balance and job =job_name ;
end &&

--  call pre_filter_g_balance_job(1400,'services')pre_filter_g_balance_jobpre_filter_g_balance