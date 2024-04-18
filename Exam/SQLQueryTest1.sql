select * from test.city
select * from test.measurement
select * from test.source
select * from test.station
select * from test.substance

--_________________________________________
--všechna mìsta,v nichž byl namìøen libovolný oxid.
select distinct stat.city_id,sub.substance_name
from test.substance sub
join test.measurement mes on mes.substance_id = sub.substance_id
join test.station stat on stat.station_id = mes.station_id
where sub.substance_name like 'Oxid%'
order by stat.city_id

--___________________________________________
--stanice,které namìøily teplotu nad 30° ,vítr pod 20 více než jednou
select distinct stat.station_name 
from test.station stat 
join test.measurement mes on mes.station_id = stat.station_id
where mes.wind<20 and mes.temperature >30
