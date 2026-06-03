
--1.Department-wise and State-wise Patient Count
select pr.department , pr.state, count(pr.state) from patient_registration pr 
group by pr.department , pr.state
order by pr.department;


--2. Minimum, Maximum, and Average Age
select min(pr.age),max(pr.age) , round(avg(pr.age)) from patient_registration pr;


--3. Patients Younger Than 30
select pr.first_name ,pr.age from patient_registration pr 
where pr.age<30
order by pr.first_name;


--4. Patients Aged Between 5 and 25
select pr.first_name ,pr.age from patient_registration pr 
where pr.age>5 and pr.age<25
order by pr.first_name;


--5. Patients Younger Than 5 or Older Than 30
select pr.first_name ,pr.age from patient_registration pr 
where pr.age<5 or pr.age>30
order by pr.first_name;


--6. Blood Group Distribution by Gender
select pr.gender, pr.blood_group , count(pr.blood_group) from patient_registration pr
group by pr.gender,pr.blood_group ;


--7. Patients from Chennai or Hyderabad
select pr.first_name,pr.city  from patient_registration pr 
where pr.city='Chennai' or pr.city='Hyderabad';


--8. Insurance Provider-wise Patient Count
select pr.insurance_provider ,count(pr.insurance_provider)  as number_count from patient_registration pr 
group by pr.insurance_provider
order by number_count DESC;


--9. Registration Type Count by Department
select pr.department , pr.registration_type ,count(pr.registration_type ) as regitration_count from patient_registration pr 
group by pr.department , pr.registration_type 
order by regitration_count desc;


saravana sir given question


--display the 7 cycle add the before days and show
select ps.sale_id , ps.sale_date , to_char(ROUND(cast(sum(ps.total_amount) 
over (order by ps.sale_id rows between 6 preceding and current row )as numeric ),2),'99,99,99,99,999.00') as running
from pharmacy_sales ps ;


--running total
select ps.sale_id , ps.sale_date , to_char(ROUND(cast(sum(ps.total_amount)
over (order by ps.sale_id ) as numeric ),2),'99,99,99,99,999.00') as running
from pharmacy_sales ps  


--extra 
select pr.registration_date,count(pr.first_name) as total  from public.patient_registration pr 
left join public.pharmacy_sales ps on ps.patient_id =pr.patient_id
group by  pr.registration_date
order by  pr.registration_date;