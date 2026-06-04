
--index
index
create index pharmacy_sales_2 on pharmacy_sales using HASH (patient_id);

select * from pharmacy_sales ps 
where sale_id between 'SL000001' and 'SL000010';

--percent_rank
select e.id , percent_rank(e.salary) over(order by e.id) from employees e;

--total revenu	
select sum(ps.total_amount) as total from pharmacy_sales ps 

--avg trasaction
select avg(ps.total_amount) as avg_amount from pharmacy_sales ps  

--revenue by category and branch
select ps.branch,ps.drug_category, sum(ps.total_amount) from pharmacy_sales ps 
group by ps.branch ,ps.drug_category ;

--top payment mode
select ps.payment_mode ,	 count(ps.payment_mode) from pharmacy_sales ps 
group by ps.payment_mode
order by count(ps.payment_mode) desc 
limit 1;

--all these in one query 
select ps.branch ,ps.drug_category , 
to_char(avg(ps.quantity)::numeric , '99,99,999.99') as avg_quantity , 
to_char(sum(ps.total_amount)::numeric , '99,99,999.99') sum_total,
to_char(avg(ps.total_amount)::numeric , '99,99,999.99') as avg_total , 
sum(case when ps.payment_mode='Card' then 1 else 0 end ) as card,
sum(case when ps.payment_mode = 'Insurance' then 1 else 0 end) as insurance,
sum(case when ps.payment_mode = 'UPI' then 1 else 0 end) as upi,
sum(case when ps.payment_mode ='Cash' then 1 else 0 end) as cash
from pharmacy_sales ps 
group by  ps.drug_category ,ps.branch
order by ps.branch,ps.drug_category;
