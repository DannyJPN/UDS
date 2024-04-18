--_______________________________________________________1
select mea.station_id , mea.substance_id,count(*) as overflow
from test.measurement mea
join test.substance sub on sub.substance_id = mea.substance_id and mea.concentration>sub.limit
where mea.station_id in
(
    select st.station_id 
    from test.station st 
    where st.city_id in	
    (
        select c.city_id
        from test.city c
        where c.city_name like '%Ostrava%'
    )
)
group by mea.station_id,mea.substance_id
having count(*) >=all
(
	select count(*) as overflow
	from test.measurement me
	join test.substance su on su.substance_id = me.substance_id and me.concentration>su.limit
	where me.station_id = mea.station_id  
	group by me.station_id,me.substance_id
	
)
order by mea.station_id,mea.substance_id


--__________________________________________________2
select st.station_id,
	(
		select count(*)
		from test.measurement mea
		where month(mea.meas_date) = 1
		and st.station_id = mea.station_id
	
	) counts,
	(
		select count(*)
		from test.measurement mea
		join test.substance sub on sub.substance_id = mea.substance_id and mea.concentration>sub.limit
		where month(mea.meas_date) = 1
		and st.station_id = mea.station_id
	
	) countsoverlimit,
	(
		select count(*)
		from test.measurement mea
		join test.substance sub on sub.substance_id = mea.substance_id and mea.concentration>sub.limit*1.5
		where month(mea.meas_date) = 1
		and st.station_id = mea.station_id
	
	) counts_overlimit_by_half,
	(
		select avg(mea.temperature)
		from test.measurement mea
		where month(mea.meas_date) = 1
		and st.station_id = mea.station_id
	
	) averages

	from test.station st
	where st.city_id in 
		(
			select c.city_id 
			from test.city c
			where c.city_name like '%Praha%'
	
		)

--_______________________________________________3
select me.substance_id,maxtab.maxcon,me.station_id,me.meas_date,me.temperature,su.substance_name,st.station_name
from test.measurement me 
join
(
	select mea.substance_id ,max(mea.concentration) maxcon
	from test.measurement mea
	where month(mea.meas_date) between 1 and 3
	group by mea.substance_id
)maxtab
on me.concentration = maxtab.maxcon and 
me.substance_id = maxtab.substance_id and
month(me.meas_date) between 1 and 3
join test.station st on st.station_id = me.station_id
right join test.substance su on su.substance_id = me.substance_id
order by me.substance_id


--_____________________TEST2___________________________
--_______________________________________________________1
select mea.station_id , mea.substance_id,count(*) as overflow
from test.measurement mea
join test.substance sub on sub.substance_id = mea.substance_id and mea.concentration>sub.limit
where mea.station_id in
(
    select st.station_id 
    from test.station st 
    where st.city_id in
    (
        select c.city_id
        from test.city c
        where c.city_name like '%Olomouc%'
    )
)
group by mea.station_id,mea.substance_id
having count(*) >=all
(
	select count(*) as overflow
	from test.measurement me
	join test.substance su on su.substance_id = me.substance_id and me.concentration>su.limit
	where me.station_id = mea.station_id  
	group by me.station_id,me.substance_id
	
)
order by mea.station_id,mea.substance_id


--__________________________________________________2
select st.station_id,
	(
		select count(*)
		from test.measurement mea
		where month(mea.meas_date) = 2
		and st.station_id = mea.station_id
	
	) counts,
	(
		select count(*)
		from test.measurement mea
		join test.substance sub on sub.substance_id = mea.substance_id and mea.concentration>sub.limit
		where month(mea.meas_date) = 2
		and st.station_id = mea.station_id
	
	) countsoverlimit,
	(
		select count(*)
		from test.measurement mea
		join test.substance sub on sub.substance_id = mea.substance_id and mea.concentration>sub.limit*1.5
		where month(mea.meas_date) = 2
		and st.station_id = mea.station_id
	
	) counts_overlimit_by_half,
	(
		select avg(mea.temperature)
		from test.measurement mea
		where month(mea.meas_date) = 2
		and st.station_id = mea.station_id
	
	) averages

	from test.station st
	where st.city_id in 
		(
			select c.city_id 
			from test.city c
			where c.city_name like '%Ostrava%'
	
		)

--_______________________________________________3
select me.substance_id,maxtab.maxcon,me.station_id,me.meas_date,me.temperature,su.substance_name,st.station_name
from test.substance su join test.measurement me on su.substance_id = me.substance_id
join

(select mea.substance_id ,max(mea.concentration) maxcon
from test.measurement mea
where month(mea.meas_date) between 4 and 6
group by mea.substance_id
)maxtab
on me.concentration = maxtab.maxcon and me.substance_id = maxtab.substance_id
join test.station st on st.station_id = me.station_id
order by me.substance_id

 --TEST3
 --________________________________________________1
 select overflows.*,stt.city_id from
 (
	select mea.station_id,st.station_name, count(*) overflow
	from  test.measurement mea 
	join test.substance sub on sub.substance_id = mea.substance_id and mea.concentration>sub.limit
	join test.station st on mea.station_id = st.station_id
	where month(mea.meas_date) = 4
	group by mea.station_id,st.station_name
 ) overflows
 join test.station stt on overflows.station_id = stt.station_id
 join test.city c on stt.city_id = c.city_id
 where overflows.overflow >=all
 (
	select count(*) ov
	from  test.measurement me 
	join test.substance su on su.substance_id = me.substance_id and me.concentration>su.limit
	join test.station s on me.station_id = s.station_id
	where month(me.meas_date) = 4 and s.city_id = stt.city_id 
	group by me.station_id,s.station_name
 
 )
 --________________________________________________2
 select *
 from test.station st
 where exists
 (
    select avg(mea.concentration) 
    from test.measurement mea
    join test.substance sub on sub.substance_id = mea.substance_id
    where sub.substance_name like '%PM10%' and month(mea.meas_date) = 8
    group by mea.station_id
    having avg(mea.concentration) >40 and mea.station_id = st.station_id
 )
 and
  exists
 (
    select max(me.temperature) 
    from test.measurement me
    where month(me.meas_date) = 8
    group by me.station_id
    having max(me.temperature) >45 and me.station_id = st.station_id


 )
 
 --________________________________________________3
 select *
 from test.station st
  
 where st.station_id not in
 (
    select  mea.station_id
    from test.measurement mea
    join test.substance sub on sub.substance_id = mea.substance_id and sub.limit<mea.concentration
    where  sub.substance_name like '%Dioxin%' and mea.temperature<=5
	
 )
 and st.station_id in
 (
	select me.station_id from test.measurement me
 )



 
 --TEST4
 --______________________________________________________1
 select overflows.*,stt.city_id from
 (
	select mea.station_id,st.station_name, count(*) overflow
	from  test.measurement mea 
	join test.substance sub on sub.substance_id = mea.substance_id and mea.concentration>sub.limit
	join test.station st on mea.station_id = st.station_id
	where month(mea.meas_date) = 5
	group by mea.station_id,st.station_name
 ) overflows
 join test.station stt on overflows.station_id = stt.station_id
 join test.city c on stt.city_id = c.city_id
 where overflows.overflow >=all
 (
	select count(*) ov
	from  test.measurement me 
	join test.substance su on su.substance_id = me.substance_id and me.concentration>su.limit
	join test.station s on me.station_id = s.station_id
	where month(me.meas_date) = 5 and s.city_id = stt.city_id 
	group by me.station_id,s.station_name
 
 ) 
 
 --______________________________________________________2
 select *
 from test.station st
 where exists
 (
    select avg(mea.concentration) 
    from test.measurement mea
    join test.substance sub on sub.substance_id = mea.substance_id
    where sub.substance_name like '%PM10%' and month(mea.meas_date) = 1
    group by mea.station_id
    having avg(mea.concentration) <50 and mea.station_id = st.station_id
 )
 and
 exists
 (
    select min(me.temperature) 
    from test.measurement me
    where month(me.meas_date) = 1
    group by me.station_id
    having min(me.temperature) <10 and me.station_id = st.station_id


 )
 
 --______________________________________________________3
 select *
 from test.station st
 where st.station_id not in
 (
    select mea.station_id
    from test.measurement mea
    join test.substance sub on sub.substance_id = mea.substance_id and sub.limit<mea.concentration
    where mea.temperature <=2  and sub.substance_name like '%SO2%'
 )

 --TEST5
 --_________________________________________1
 select mea.station_id,mea.substance_id,st.station_name,sub.substance_name,abs(max(mea.concentration)-min(mea.concentration)) as rozptyl
 from test.measurement mea
 join test.station st on st.station_id = mea.station_id
 join test.substance sub on sub.substance_id = mea.substance_id
 where month(mea.meas_date) = 1
 group by mea.station_id,mea.substance_id,st.station_name,sub.substance_name
 having abs(max(mea.concentration)-min(mea.concentration)) >=all
 (
    select abs(max(me.concentration)-min(me.concentration)) as rozptyl
    from test.measurement me
    where month(me.meas_date) = 1
    group by me.station_id,me.substance_id
    having  mea.substance_id = me.substance_id
 
 )  

 
 --_________________________________________2
 select *
 from test.city c
 where exists
 (
    select count(*) 
    from test.source so
    where so.source_type like '%Lokální%topenište%'
    group by so.city_id
    having so.city_id = c.city_id and count(*)>=2
 )
 and not exists
 (
    select *
    from test.station st
    where st.elevation >60
    and c.city_id = st.city_id
 )
 
 --_________________________________________3
 select *
 from test.station st
 where exists
 (
    select *
    from test.measurement mea
    join test.substance sub on sub.substance_id = mea.substance_id and mea.concentration>sub.limit
    where month(mea.meas_date) = 1 and st.station_id = mea.station_id    and sub.substance_name like '%Oxid%uhelnatý%'
     
 )
 and 
 exists
 (
    select *
    from test.measurement mea
    join test.substance sub on sub.substance_id = mea.substance_id and mea.concentration>sub.limit
    where month(mea.meas_date) = 2 and st.station_id = mea.station_id    and sub.substance_name like '%Oxid%uhelnatý%'
     
 )
 
 
 --TEST6
 --_______________________________________1
 select mea.station_id,mea.substance_id,st.station_name,sub.substance_name,abs(max(mea.concentration)-min(mea.concentration)) as rozptyl
 from test.measurement mea
 join test.station st on st.station_id = mea.station_id
 join test.substance sub on sub.substance_id = mea.substance_id
 where month(mea.meas_date) = 2
 group by mea.station_id,mea.substance_id,st.station_name,sub.substance_name
 having abs(max(mea.concentration)-min(mea.concentration)) >=all
 (
    select abs(max(me.concentration)-min(me.concentration)) as rozptyl
    from test.measurement me
    where month(me.meas_date) = 2
    group by me.station_id,me.substance_id
    having mea.station_id = me.station_id
 
 )  

 --_______________________________________2
 select *
 from test.city c
 where exists
 (
    select count(*) 
    from test.source so
    group by so.city_id
    having so.city_id = c.city_id and count(*)>=6
 )
 and not exists
 (
    select *
    from test.station st
    where st.elevation <10
    and c.city_id = st.city_id
 )
 
 --_______________________________________3
 select *
 from test.station st
 where exists
 (
    select *
    from test.measurement mea
    join test.substance sub on sub.substance_id = mea.substance_id and mea.concentration>sub.limit
    where month(mea.meas_date) = 3 and sub.substance_name like '%NO2%'  and st.station_id = mea.station_id  
     
 )
 and 
  exists
 (
    select *
    from test.measurement mea
    join test.substance sub on sub.substance_id = mea.substance_id and mea.concentration>sub.limit
    where month(mea.meas_date) = 4   and sub.substance_name like '%NO2%' and st.station_id = mea.station_id  
     
 )
  
  --TEST7
  --________________________________________1
select * 
from test.city ci
where not exists
(	select * 
	from
	(	select st.*,c.city_name, 
		(
			select count(*) as overflows
			from test.measurement mea
			join test.substance sub on sub.substance_id = mea.substance_id and mea.concentration > sub.limit
			where month(mea.meas_date) = 3
			and mea.station_id = st.station_id
		)overflows,
		(
		    select count(*) as underflows
			from test.measurement mea
			join test.substance sub on sub.substance_id = mea.substance_id and mea.concentration <= sub.limit
			where month(mea.meas_date) = 3 
			and mea.station_id = st.station_id
		)underflows
		from test.station st
		join test.city c on c.city_id = st.city_id
	) flowchart
	where flowchart.overflows > flowchart.underflows and flowchart.city_id = ci.city_id
)
 --_______________________________________2
select mea.substance_id,mea.station_id,count(*)
from test.measurement mea
join test.substance sub on sub.substance_id = mea.substance_id and mea.concentration>sub.limit
where month(mea.meas_date) = 1
group by mea.substance_id,mea.station_id
having count(*)>= all
(
    select count(*)
    from test.measurement me
    join test.substance su on su.substance_id = me.substance_id and me.concentration>su.limit
    where month(me.meas_date) = 1
    group by me.substance_id,me.station_id
    having mea.substance_id = me.substance_id

)
order by mea.substance_id                                             
  --________________________________________3
select *
from
(
select *,
(
    select count(*) 
    from test.measurement me
    join test.substance sub on sub.substance_id = me.substance_id and sub.limit<me.concentration
    where sub.substance_name like '%NO2%' and month(me.meas_date) = 1
    and me.station_id = st.station_id

) as NOOver,
(
    select count(*)
    from test.measurement me
    join test.substance sub on sub.substance_id = me.substance_id and sub.limit<me.concentration
    where sub.substance_name like '%SO2%' and month(me.meas_date) = 1
    and me.station_id = st.station_id
) as SOOver
from test.station st 
)comparer
where  NOOver>SOOver 
  
 
  --TEST8vynechán-analogické
  --___________________________________________________1
   --___________________________________________________2
  --___________________________________________________3

--TEST9
--____________________________________________________1

	select *
	from test.measurement me
	join (
			select mea.station_id,mea.substance_id,   min(mea.meas_date) firstdate
			from test.measurement mea
			join test.substance sub on  mea.substance_id = sub.substance_id 
			group by mea.station_id,mea.substance_id
			--order by mea.station_id,mea.substance_id
	)firsts on firsts.firstdate = me.meas_date
	join test.substance su on su.substance_id = me.substance_id and su.limit*1.5>me.concentration
	
	--nedokonèeno,nevím jak vyfiltrovat stanice,když jedna látka není mìøena
--____________________________________________________2
select *,
(
	select count(*)
	from test.measurement mea
	where month(mea.meas_date) between 1 and 3 and mea.station_id = st.station_id
) meacount,
(
	select count(*)
	from test.measurement mea
	where mea.station_id = st.station_id and mea.temperature > 
	(
		select avg(me.temperature) from test.measurement me
	)
	or mea.pressure > 
	(
		select avg(me.pressure) from test.measurement me
	)
	



) temppres
from test.station st
where st.elevation >=40
--____________________________________________________3

select *,
(
	select count(*)
	from test.measurement mea
	join test.substance sub on sub.substance_id = mea.substance_id and sub.limit<mea.concentration
	where month(mea.meas_date)=1 and st.station_id = mea.station_id and (sub.substance_name like '%PM10%' or sub.substance_name like '%PM2,5%' )
	
)
from test.station st
where st.city_id in
(
	select c.city_id
	from test.city c
	where c.city_name like '%Olomouc%'
)
 
    