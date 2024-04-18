
select * from test.city 
select * from test.measurement 
select * from test.source 
select * from test.station
select * from test.substance

select * from test.city where test.city.city_id is null
select * from test.measurement where test.measurement.substance_id is null
select * from test.source where test.source.source_id is null
select * from test.station where test.station.station_id is null
select * from test.substance where test.substance.substance_id is null
-- Vypište všechny dvojice station_id substance_id kde došlo k překročení limitu dané látky na dané stanici alespoň v devíti různých měsících
select mea.station_ID,sub.substance_ID,count(distinct month(mea.meas_date)) as overflow
from test.measurement mea
join test.substance sub on mea.substance_id = sub.substance_id
where mea.concentration > sub.limit 
group by mea.station_id,sub.substance_id
having count(distinct month(mea.meas_date)) >=9
order by mea.station_id,sub.substance_id
-- Pro každou stanici v Ostravě nalezněte záznam(y) v tabulce measurement,
-- který představuje nejvyšší naměřenou koncentraci oxidu uhelnatého v “databázi” stanice.
-- Berte do úvahy pouze měření, kde byla teplota pod 10 stupňů

select *
from test.measurement me
join
(
select temper.station_id ,max(temper.concentration) as maxim
from 
(
	select *
	from test.measurement mea
	where mea.temperature <10
)temper
join test.station stat on stat.station_id = temper.station_id 
and
stat.city_id = (select c.city_id from test.city as c where c.city_name = 'Ostrava')
and
temper.substance_id = (select sub.substance_id from test.substance as sub where sub.substance_name like 'Oxid uhelnatý%')
group by temper.station_id
)final  on me.station_id = final.station_id and me.concentration = final.maxim


-- najdete latky u kterych koncentrace prekrocila limit v kvetnu na stanicich id 1 a 2


select sub.substance_name
from test.measurement mea 
join test.substance sub on sub.substance_id=mea.substance_id and mea.concentration>sub.limit and mea.station_id=1
where month(mea.meas_date)=5 
intersect
(select sub.substance_name
from test.measurement mea 
join test.substance sub on sub.substance_id=mea.substance_id and mea.concentration>sub.limit and mea.station_id=2
where month(mea.meas_date)=5 
)


--Stanice ve městech s minimálně 3 znečišťovateli a 4

select *
from test.station stat
where stat.city_id in(
select c.city_id
from test.city c
join test.source sou on sou.city_id = c.city_id
where sou.source_type like 'Prum%'
group by c.city_id
having count(c.city_id) >=4
)
and stat.city_id in(
select c.city_id
from test.city c
join test.source sou on sou.city_id = c.city_id
where sou.source_type like 'Lokál%'
group by c.city_id
having count(c.city_id) >=3
)

--ALTER
select c.city_id
from test.city c
join test.source sou on sou.city_id = c.city_id
group by c.city_id
having count(case when sou.source_type like 'Prum%' then 1 end)>=4 and count(case when sou.source_type like 'Lokál%' then 1 end)>=3