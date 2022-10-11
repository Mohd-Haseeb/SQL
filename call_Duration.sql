select * from `practice`.call_details;

-- select t1.call_number from `prac-- tice`.call_details t1,`practice`.call_details t2
-- where t1.call_number = t2.call_number;
with cte as (
select call_number,
sum(case
	when call_type='OUT' then call_duration
    else null 
end) as out_duration,
sum(case
	when call_type='INC' then call_duration
    else null 
end) as in_duration

from `practice`.call_details
group by call_number
)

select call_number,out_duration,in_duration from cte
where out_duration is not null and in_duration is not null
and out_duration > in_duration

-- select call_number
-- from `practice`.call_details
-- group by call_number

