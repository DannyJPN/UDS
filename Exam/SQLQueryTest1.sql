select * from test.city
select * from test.measurement
select * from test.source
select * from test.station
select * from test.substance

--_________________________________________
--v�echna m�sta,v nich� byl nam��en libovoln� oxid.
select distinct stat.city_id,sub.substance_name
from test.substance sub
join test.measurement mes on mes.substance_id = sub.substance_id
join test.station stat on stat.station_id = mes.station_id
where sub.substance_name like 'Oxid%'
order by stat.city_id

--___________________________________________
--stanice,kter� nam��ily teplotu nad 30� ,v�tr pod 20 v�ce ne� jednou
select distinct stat.station_name 
from test.station stat 
join test.measurement mes on mes.station_id = stat.station_id
where mes.wind<20 and mes.temperature >30
