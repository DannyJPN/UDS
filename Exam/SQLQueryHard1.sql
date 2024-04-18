--_________________________________________1
select tab.station_id,count(tab.substance_id) substance_count
from
(
	select s.station_id,me.substance_id,maxcon
	from test.measurement me
	join 
	(
		select mea.substance_id,max(mea.concentration) maxcon
		from test.measurement mea
		group by mea.substance_id
	
	
	)maxi on me.concentration = maxi.maxcon
	right join test.station s on s.station_id = me.station_id
)tab	
group by tab.station_id




--_________________________________________2
select *,
(
	select avg(mea.concentration) as averPM10
	from test.measurement mea
	join test.substance sub on sub.substance_id = mea.substance_id
	where sub.substance_name like '%PM10%'
	group by mea.station_id
	having mea.station_id = st.station_id
)averPM10,
(
	select avg(mea.concentration) as averPM10
	from test.measurement mea
	join test.substance sub on sub.substance_id = mea.substance_id 
	where sub.substance_name like '%PM2,5%'
	group by mea.station_id
	having mea.station_id = st.station_id
)averPM25


from test.station st
where st.city_id in
(
	select so.city_id
	from test.source so
	where so.source_type like '%Lokální%'
	group by so.city_id
	having count(*)>=2
)


--_________________________________________3
select *
from test.substance su
where su.substance_id not in
(
	select mea.substance_id 
	from test.measurement mea 
	join test.substance sub on sub.substance_id = mea.substance_id and sub.limit<mea.concentration
	join test.station st on st.station_id = mea.station_id
	where month(mea.meas_date)=1 and st.elevation >20 and st.city_id in
	(
		select c.city_id
		from test.city c
		where c.city_name like '%Brno%'
	)
)
