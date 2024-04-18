--Vyber stanici, která mìla nejvyšší poèet pøekroèení PM10, která se nachází v mìstì s minimálnì 3 prùmyslovými zneèišovateli


select st.station_id,st.station_name,count(*)
from test.station st
join test.measurement mea
on mea.station_id = st.station_id 
join test.substance sub
on sub.substance_id = mea.substance_id and mea.concentration > sub.limit
where substance_name like '%PM10%' and st.city_id in
(
	   select so.city_id
		from test.source so
		where so.source_type = 'Prumysl'
		group by so.city_id
		having count(*)>3
	
)
group by st.station_id,st.station_name
having count(*)>=all
(
	select count(*)
	from test.station s
	join test.measurement me
	on me.station_id = s.station_id 
	join test.substance su
	on su.substance_id = me.substance_id and me.concentration > su.limit
	where substance_name like '%PM10%' and s.city_id in
	(
		select sou.city_id
		from test.source sou
		where sou.source_type = 'Prumysl'
		group by sou.city_id
		having count(*)>3
	
	)
	group by s.station_id
	having s.station_id != st.station_id
)



