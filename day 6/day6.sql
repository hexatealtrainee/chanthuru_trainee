
--day 6
--1

--department
select
pr.department ,pr.gender ,
sum(case when pr.age<16 then 1 end) as under_15,
sum(case when pr.age>15 and pr.age<31 then 1 end) as b_16_to_30,
sum(case when pr.age>30 and pr.age<51 then 1 end) as b_30_to_50,
sum(case when pr.age>51 and pr.age<71 then 1 end) as b_50_to_60,
sum(case when pr.age>70 then 1 end) as above_70
from
patient_registration pr
group by
pr.gender ,
pr.department
order by 
pr.department;


--Demographics
select
pr.department , pr.state ,pr.city ,count(pr.state),pr.gender ,
sum(case when pr.age<16 then 1 end) as under_15,
sum(case when pr.age>15 and pr.age<31 then 1 end) as b_16_to_30,
sum(case when pr.age>30 and pr.age<51 then 1 end) as b_30_to_50,
sum(case when pr.age>51 and pr.age<71 then 1 end) as b_50_to_60,
sum(case when pr.age>70 then 1 end) as above_70
from
patient_registration pr
group by
pr.gender ,
pr.department,pr.city,pr.state
order by 
pr.department,pr.state,pr.city;

--payer mix
select pr.registration_type , count(pr.registration_type) 
from patient_registration pr 
group by pr.registration_type;

--catchment cities
select  pr.state ,pr.city ,count(pr.state) from  patient_registration pr 
group by pr.city,pr.state
order by pr.state ,pr.city;


--2
--Categories
select ps.branch , ps.drug_category ,count(ps.drug_category),pr.department,pr.gender,
sum(case when pr.age<16 then 1 end) as under_15,
sum(case when pr.age>15 and pr.age<31 then 1 end) as b_16_to_30,
sum(case when pr.age>30 and pr.age<51 then 1 end) as b_30_to_50,
sum(case when pr.age>51 and pr.age<71 then 1 end) as b_50_to_60,
sum(case when pr.age>70 then 1 end) as above_70
from pharmacy_sales ps 
join patient_registration pr on pr.patient_id =ps.patient_id 
group by ps.branch ,ps.drug_category,pr.gender,pr.department
order by ps.branch,ps.drug_category,pr.gender,pr.department;


---top drug
select pr.department,pr.gender,ps.drug_category ,count(ps.drug_category),
sum(case when pr.blood_group='A+' then 1 end) as A_p,
sum(case when pr.blood_group='A-' then 1 end) as A_n,
sum(case when pr.blood_group='B+' then 1 end) as B_p,
sum(case when pr.blood_group='B-' then 1 end) as B_n,
sum(case when pr.blood_group='O+' then 1 end) as O_p,
sum(case when pr.blood_group='O-' then 1 end) as O_n,
sum(case when pr.blood_group='AB+' then 1 end) as AB_p,
sum(case when pr.blood_group='AB-' then 1 end) as AB_n
from pharmacy_sales ps 
join patient_registration pr on pr.patient_id =ps.patient_id 
group by pr.department , pr.gender, ps.drug_category
order by pr.department,pr.gender, ps.drug_category;

--brach level
select
ps.branch ,
count(patient_id) as count_of_sales,
to_char(date(ps.sale_date), 'YYYY') as year_month,
sum(ps.total_amount) as total,
case
when sum(ps.total_amount)<= 150000 then 'low'
when sum(ps.total_amount) between 150000 and 250000 then 'median'
when sum(ps.total_amount)>20000 then 'high'
else 'not'
end as level_branch
from
pharmacy_sales ps
group by
ps.branch,
to_char(date(ps.sale_date), 'YYYY')
order by
ps.branch ,
year_month;	


--payment mix
select ps.payment_mode ,count(ps.payment_mode) from pharmacy_sales ps 
group by ps.payment_mode ;


--3

--Status mix
select ea.designation ,count(ea.designation) from employee_attendance ea 
group by ea.designation 
order by ea.designation;

--late_rate
select ea.status,DENSE_RANK() over(order by count(ea.status) desc),
count(ea.status)
from employee_attendance ea 
group by ea.status;

--department & shift coverage
select ea.department ,ea.id , ea.shift ,count(ea.shift), sum(ea.hours_worked) from employee_attendance ea 
group by ea.department ,ea.shift ,ea.id
order by ea.id,ea.department  ;





select distinct pr.blood_group from patient_registration pr 
order by blood_group ;
