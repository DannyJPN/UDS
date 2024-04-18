--najdete latky u kterych koncentrace prekrocila limit v kvetnu SOUCASNE na stanicich id 1 a 2

select sub.substance_id,sub.substance_name
from test.substance sub
where exists
(
select *
from test.measurement mea
join test.substance su on su.substance_id = mea.substance_id and su.limit<mea.concentration
where mea.station_id = 1 and month(mea.meas_date) = 5 and mea.substance_id = sub.substance_id
)
and exists
(
select *
from test.measurement mea
join test.substance su on su.substance_id = mea.substance_id and su.limit<mea.concentration
where mea.station_id = 2 and month(mea.meas_date) = 5 and mea.substance_id = sub.substance_id
)




--vypi�t� stanice kter� maj� vyv��en� nad 20 metr� a po�et z�znam� pod limit v�t�� ne� nad limit
select *
from(
select *,
(
	select count(*)--,mea.station_id
	from test.measurement mea 
	join test.substance sub on sub.substance_id = mea.substance_id and mea.concentration>sub.limit
	group by mea.station_id
	having mea.station_id = st.station_id
) overflow
,
(
	select count(*)--,mea.station_id
	from test.measurement mea 
	join test.substance sub on sub.substance_id = mea.substance_id and mea.concentration<=sub.limit
	group by mea.station_id
	having mea.station_id = st.station_id
)underflow
from test.station st 
)overunder
where overunder.overflow>overunder.underflow and overunder.elevation>20


--Resp. pro ka�dou stanici vypsat po�et z�znam�
select *,
(
select count(*)
from test.measurement mea
where mea.station_id = st.station_id
)num
from test.station st
order by num desc