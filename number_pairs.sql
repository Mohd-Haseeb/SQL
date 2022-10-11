-- select * from `practice`.number_pairs 

-- insert into `practice`.number_pairs values(4,2)

select a,b from(

select t1.a, t1.b from `practice`.number_pairs t1
inner join `practice`.number_pairs t2
on t1.a = t2.b and t1.b = t2.a
where t1.a < t2.a
) t

