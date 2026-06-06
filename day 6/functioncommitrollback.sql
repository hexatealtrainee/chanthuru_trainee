--function where
create or replace  function  test (
p_patient_id varchar)
returns setof patient_registration
language plpgsql
as $$
begin
    return QUERY
    select *
    from patient_registration pr
    where pr.patient_id = p_patient_id;
end;
$$;
select * from test('PT01000');



--function delete
create or replace function test_1(
p_patient_id varchar)
returns setof patient_registration
language plpgsql
as $$ 
begin
	delete from patient_registration
	where patient_id=p_patient_id;

   return QUERY select * from patient_registration;
end;
$$;
drop function test_1;
select test_1('PT00003');



--function update
create or replace function test_2(
p_patient_id varchar)
returns setof patient_registration
language plpgsql
as $$ 
begin
	update  patient_registration
	set first_name='chanthuru'
	where patient_id=p_patient_id;

   return QUERY select * from patient_registration pr
	order by pr.patient_id;
end;
$$;
drop function test_2;
select test_2('PT00001');



--count the city
create or replace function count_by_city(
    p_city VARCHAR
)
returns int
language plpgsql
as $$
declare v_count int;
begin
    select count(*) into v_count
    from patient_registration
    where city = p_city;

    return v_count;
end;
$$;
select count_by_city('Coimbatore');



-- blood and location full table
create or replace function city_blood(
    p_city varchar,
    p_blood_group varchar
)
returns setof patient_registration
language plpgsql
as $$
declare v_count int;
begin
    return QUERY 
    select *
    from patient_registration pr
    where pr.city = p_city and pr.blood_group=p_blood_group;
end;
$$;

select * from  city_blood('Coimbatore','B+');



--only first_name,phone,blood,city
create or replace function city_blood(p_city varchar,p_blood_group varchar)
returns table(first_name varchar,city varchar,blood_group varchar,phone int8)
language plpgsql
as $$
begin
    return QUERY 
    select pr.first_name,pr.city,pr.blood_group,pr.phone
    from patient_registration pr
    where pr.city = p_city and pr.blood_group=p_blood_group;
end;
$$;
SELECT * FROM city_blood('Coimbatore','B+');
drop function city_blood;


--group age and boold count
create or replace function group_city_blood(p_city varchar,p_age int4,r_age int4)
returns table(city varchar,A_p int,A_n int,B_p int,B_n int,O_p int,O_n int,AB_p int,AB_n int
)
language plpgsql
as $$
begin
    return QUERY 
    select pr.city,
		sum(case when pr.blood_group='A+' then 1 end)::int as A_p,
		sum(case when pr.blood_group='A-' then 1 end)::int as A_n,
		sum(case when pr.blood_group='B+' then 1 end)::int as B_p,
		sum(case when pr.blood_group='B-' then 1 end)::int as B_n,
		sum(case when pr.blood_group='O+' then 1 end)::int as O_p,
		sum(case when pr.blood_group='O-' then 1 end)::int as O_n,
		sum(case when pr.blood_group='AB+' then 1 end)::int as AB_p,
		sum(case when pr.blood_group='AB-' then 1 end)::int as AB_n
    from patient_registration pr
    where pr.age>=p_age and pr.age<=r_age and pr.city=p_city
group by pr.city;
end;
$$;
SELECT * FROM group_city_blood('Coimbatore',20,50);




---age , city , blood
create or replace function age_city_blood(p_city varchar,p_age int4,r_age int4,p_blood varchar)
returns table(city varchar, c_blood int
)
language plpgsql
as $$
begin
    return QUERY 
    select pr.city,
		sum(case when pr.blood_group=p_blood then 1 end)::int as c_blood
    from patient_registration pr
    where pr.age>=p_age and pr.age<=r_age and pr.city=p_city
group by pr.city;
end;
$$;
SELECT * FROM age_city_blood('Coimbatore',20,50,'A+');




----state department
create or replace function city_department(p_city varchar,p_department varchar)
returns table(count_number int)
language plpgsql
as $$
begin
    return QUERY 
    select sum(case when pr.department=p_department and pr.city=p_city then 1 end)::int as count_number
    from patient_registration pr;
end;
$$;

select * FROM city_department('Coimbatore','Orthopedics');


---



drop function city_department;

begin;
commit;
rollback;

select * from patient_registration pr
order by pr.patient_id;







