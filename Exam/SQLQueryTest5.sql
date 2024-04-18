
select mea.station_id,mea.substance_id,count(*) as overflow
from test.measurement mea 
join test.substance sub on sub.substance_id = mea.substance_id and mea.concentration>sub.limit
join test.station st on st.station_id = mea.station_id 
join test.city c on c.city_id = st.city_id
where c.city_name = 'Ostrava'
group by mea.station_id,mea.substance_id
order by mea.station_id,mea.substance_id





