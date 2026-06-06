--view
create view test_1 as
select pr.patient_id,pr.first_name,pr.date_of_birth,pr.blood_group from patient_registration pr;


select * from test_1 t1
where t1.blood_group='A+';


drop view test_1;


--day 5
select
	ps.branch ,
	count(ps.sale_id) as count_of_sales,
	to_char(date(ps.sale_date), 'YYYY-MM') as year_month,
	sum(ps.total_amount) as total,
	to_char(avg(ps.total_amount)::numeric, '99,99,99.99'),
	case
		when sum(ps.total_amount)<= 10000 then 'low'
		when sum(ps.total_amount) between 10000 and 20000 then 'median'
		when sum(ps.total_amount)>20000 then 'high'
		else 'not'
	end as level_branch
from
	pharmacy_sales ps
group by
	ps.branch,
	to_char(date(ps.sale_date), 'YYYY-MM')
order by
	ps.branch ,
	year_month;	




select
	ps.branch ,
	count(ps.sale_id) as count_of_sales,
	sum(ps.total_amount) as total,
	case
		when sum(ps.total_amount)<= 10000 then 'low'
		when sum(ps.total_amount) between 10000 and 20000 then 'median'
		when sum(ps.total_amount)>20000 then 'high'
		else 'not'
	end as level_branch
from
	pharmacy_sales ps
group by
	ps.branch
order by
	ps.branch
limit 5;


------ optimed query

select f.origin_state_nm ,f.dest_state_nm from flight f
where op_carrier_fl_num='6067';

--5017

select count(op_carrier_fl_num) from flight f;


CREATE INDEX flight_1
ON flight(op_carrier_fl_num);
drop index flight_1;


CREATE INDEX flight_2
ON flight(op_unique_carrier);


drop index flight_2;


select
	f.origin_state_nm ,
	f.dest_state_nm
from
	flight f
where
	op_carrier_fl_num = '6067';


select
	f.month ,
	count(f.op_carrier_fl_num)
from
	flight f
group by
	f.month;


select
	f.op_unique_carrier,
	AVG(f.arr_delay)
from
	flight f
group by
	f.op_unique_carrier;


select
	f.op_unique_carrier,
	count(f.op_unique_carrier)
from
	flight f
group by
	f.op_unique_carrier;


select
	f.month,
	sum(f.carrier_delay) as sum_carrier_delay,
	sum(f.weather_delay) as sum_weathre_delay
from
	flight f
group by
	f.month;

drop index flight_2;


select f.op_unique_carrier ,count(f.op_unique_carrier) from flight f 
group by f.op_unique_carrier;


select
	*
from
	flight
where
	arr_delay is not null;


select
	f.crs_dep_time ,
	f.dep_time ,
	round(f.crs_arr_time -f.dep_time )
from
	flight f ;


SELECT pg_is_in_recovery();


select
	f.op_carrier_fl_num ,
	sum(f.distance) over(partition by f.op_carrier_fl_num)
from
	flight f; 


SELECT f.op_carrier_fl_num, SUM(f.distance) AS total_distance
FROM flight f
GROUP BY f.op_carrier_fl_num;


SELECT ctid, arr_delay
FROM flight
ORDER BY ctid;


select f.op_carrier_fl_num ,count(f.op_carrier_fl_num) from flight f
group by f.op_carrier_fl_num;


select f.op_unique_carrier ,count(f.cancellation_code) from flight f 
WHERE f.cancellation_code IN ('A','B','C','D')
group by f.op_unique_carrier;


select distinct f.cancellation_code   from flight f ;


select f.month , f.day_of_month, count(f.taxi_in),count(f.taxi_out) from flight f 
group by f.month,f.day_of_month ;


select f.op_unique_carrier ,count(f.cancelled)  from flight f 
where f.cancelled !='0'
group by f.op_unique_carrier;


select f.op_unique_carrier ,count(f.cancelled)  from flight f 
group by f.op_unique_carrier;


select f.op_unique_carrier ,count(f.late_aircraft_delay) from flight f 
where f.late_aircraft_delay!='0'
group by f.op_unique_carrier;


select  * from flight f;	






