
select * from test.station
select * from test.substance
Select * from test.measurement
--_______________________________________1




alter table test.measurement
alter column wind integer null

insert into test.measurement (meas_id,meas_date,humidity,wind,pressure,temperature,station_id,substance_id,concentration)
values((select count(*)+1 from test.measurement )
,GETDATE(),0,NULL,0,0,1,  
 (select test.substance.substance_id from test.substance where test.substance.substance_name like '%Oxid%uhelnatý%'),
 (select test.substance.limit/2 from test.substance where test.substance.substance_name like '%Oxid%uhelnatý%')
 )

insert into test.measurement (meas_id,meas_date,humidity,wind,pressure,temperature,station_id,substance_id,concentration)values((select count(*)+1 from test.measurement ),GETDATE(),0,NULL,0,0,2,   (select test.substance.substance_id from test.substance where test.substance.substance_name like '%Oxid%uhelnatý%'), (select test.substance.limit/2 from test.substance where test.substance.substance_name like '%Oxid%uhelnatý%'))
insert into test.measurement (meas_id,meas_date,humidity,wind,pressure,temperature,station_id,substance_id,concentration)values((select count(*)+1 from test.measurement ),GETDATE(),0,NULL,0,0,3,   (select test.substance.substance_id from test.substance where test.substance.substance_name like '%Oxid%uhelnatý%'), (select test.substance.limit/2 from test.substance where test.substance.substance_name like '%Oxid%uhelnatý%'))
insert into test.measurement (meas_id,meas_date,humidity,wind,pressure,temperature,station_id,substance_id,concentration)values((select count(*)+1 from test.measurement ),GETDATE(),0,NULL,0,0,4,   (select test.substance.substance_id from test.substance where test.substance.substance_name like '%Oxid%uhelnatý%'), (select test.substance.limit/2 from test.substance where test.substance.substance_name like '%Oxid%uhelnatý%'))
insert into test.measurement (meas_id,meas_date,humidity,wind,pressure,temperature,station_id,substance_id,concentration)values((select count(*)+1 from test.measurement ),GETDATE(),0,NULL,0,0,5,   (select test.substance.substance_id from test.substance where test.substance.substance_name like '%Oxid%uhelnatý%'), (select test.substance.limit/2 from test.substance where test.substance.substance_name like '%Oxid%uhelnatý%'))
insert into test.measurement (meas_id,meas_date,humidity,wind,pressure,temperature,station_id,substance_id,concentration)values((select count(*)+1 from test.measurement ),GETDATE(),0,NULL,0,0,6,   (select test.substance.substance_id from test.substance where test.substance.substance_name like '%Oxid%uhelnatý%'), (select test.substance.limit/2 from test.substance where test.substance.substance_name like '%Oxid%uhelnatý%'))
insert into test.measurement (meas_id,meas_date,humidity,wind,pressure,temperature,station_id,substance_id,concentration)values((select count(*)+1 from test.measurement ),GETDATE(),0,NULL,0,0,7,   (select test.substance.substance_id from test.substance where test.substance.substance_name like '%Oxid%uhelnatý%'), (select test.substance.limit/2 from test.substance where test.substance.substance_name like '%Oxid%uhelnatý%'))
insert into test.measurement (meas_id,meas_date,humidity,wind,pressure,temperature,station_id,substance_id,concentration)values((select count(*)+1 from test.measurement ),GETDATE(),0,NULL,0,0,8,   (select test.substance.substance_id from test.substance where test.substance.substance_name like '%Oxid%uhelnatý%'), (select test.substance.limit/2 from test.substance where test.substance.substance_name like '%Oxid%uhelnatý%'))
insert into test.measurement (meas_id,meas_date,humidity,wind,pressure,temperature,station_id,substance_id,concentration)values((select count(*)+1 from test.measurement ),GETDATE(),0,NULL,0,0,9,   (select test.substance.substance_id from test.substance where test.substance.substance_name like '%Oxid%uhelnatý%'), (select test.substance.limit/2 from test.substance where test.substance.substance_name like '%Oxid%uhelnatý%'))
insert into test.measurement (meas_id,meas_date,humidity,wind,pressure,temperature,station_id,substance_id,concentration)values((select count(*)+1 from test.measurement ),GETDATE(),0,NULL,0,0,10,   (select test.substance.substance_id from test.substance where test.substance.substance_name like '%Oxid%uhelnatý%'), (select test.substance.limit/2 from test.substance where test.substance.substance_name like '%Oxid%uhelnatý%'))
insert into test.measurement (meas_id,meas_date,humidity,wind,pressure,temperature,station_id,substance_id,concentration)values((select count(*)+1 from test.measurement ),GETDATE(),0,NULL,0,0,11,   (select test.substance.substance_id from test.substance where test.substance.substance_name like '%Oxid%uhelnatý%'), (select test.substance.limit/2 from test.substance where test.substance.substance_name like '%Oxid%uhelnatý%'))
insert into test.measurement (meas_id,meas_date,humidity,wind,pressure,temperature,station_id,substance_id,concentration)values((select count(*)+1 from test.measurement ),GETDATE(),0,NULL,0,0,12,   (select test.substance.substance_id from test.substance where test.substance.substance_name like '%Oxid%uhelnatý%'), (select test.substance.limit/2 from test.substance where test.substance.substance_name like '%Oxid%uhelnatý%'))
insert into test.measurement (meas_id,meas_date,humidity,wind,pressure,temperature,station_id,substance_id,concentration)values((select count(*)+1 from test.measurement ),GETDATE(),0,NULL,0,0,13,   (select test.substance.substance_id from test.substance where test.substance.substance_name like '%Oxid%uhelnatý%'), (select test.substance.limit/2 from test.substance where test.substance.substance_name like '%Oxid%uhelnatý%'))
insert into test.measurement (meas_id,meas_date,humidity,wind,pressure,temperature,station_id,substance_id,concentration)values((select count(*)+1 from test.measurement ),GETDATE(),0,NULL,0,0,14,   (select test.substance.substance_id from test.substance where test.substance.substance_name like '%Oxid%uhelnatý%'), (select test.substance.limit/2 from test.substance where test.substance.substance_name like '%Oxid%uhelnatý%'))
insert into test.measurement (meas_id,meas_date,humidity,wind,pressure,temperature,station_id,substance_id,concentration)values((select count(*)+1 from test.measurement ),GETDATE(),0,NULL,0,0,15,   (select test.substance.substance_id from test.substance where test.substance.substance_name like '%Oxid%uhelnatý%'), (select test.substance.limit/2 from test.substance where test.substance.substance_name like '%Oxid%uhelnatý%'))
insert into test.measurement (meas_id,meas_date,humidity,wind,pressure,temperature,station_id,substance_id,concentration)values((select count(*)+1 from test.measurement ),GETDATE(),0,NULL,0,0,16,   (select test.substance.substance_id from test.substance where test.substance.substance_name like '%Oxid%uhelnatý%'), (select test.substance.limit/2 from test.substance where test.substance.substance_name like '%Oxid%uhelnatý%'))
insert into test.measurement (meas_id,meas_date,humidity,wind,pressure,temperature,station_id,substance_id,concentration)values((select count(*)+1 from test.measurement ),GETDATE(),0,NULL,0,0,17,   (select test.substance.substance_id from test.substance where test.substance.substance_name like '%Oxid%uhelnatý%'), (select test.substance.limit/2 from test.substance where test.substance.substance_name like '%Oxid%uhelnatý%'))
insert into test.measurement (meas_id,meas_date,humidity,wind,pressure,temperature,station_id,substance_id,concentration)values((select count(*)+1 from test.measurement ),GETDATE(),0,NULL,0,0,18,   (select test.substance.substance_id from test.substance where test.substance.substance_name like '%Oxid%uhelnatý%'), (select test.substance.limit/2 from test.substance where test.substance.substance_name like '%Oxid%uhelnatý%'))
insert into test.measurement (meas_id,meas_date,humidity,wind,pressure,temperature,station_id,substance_id,concentration)values((select count(*)+1 from test.measurement ),GETDATE(),0,NULL,0,0,19,   (select test.substance.substance_id from test.substance where test.substance.substance_name like '%Oxid%uhelnatý%'), (select test.substance.limit/2 from test.substance where test.substance.substance_name like '%Oxid%uhelnatý%'))
insert into test.measurement (meas_id,meas_date,humidity,wind,pressure,temperature,station_id,substance_id,concentration)values((select count(*)+1 from test.measurement ),GETDATE(),0,NULL,0,0,20,   (select test.substance.substance_id from test.substance where test.substance.substance_name like '%Oxid%uhelnatý%'), (select test.substance.limit/2 from test.substance where test.substance.substance_name like '%Oxid%uhelnatý%'))

--_______________________________________2
UPDATE  mea
SET mea.concentration = mea.concentration/2
from test.measurement mea
where mea.substance_id in 
(
	select sub.substance_id
	from test.substance sub 
	where sub.substance_name like '%Oxid%uhelnatý%'
)
and mea.station_id in
(
	select st.station_id
	from test.station st
	where st.station_name like '%Motol%'
)

select *
from test.measurement mea
where mea.substance_id in 
(
	select sub.substance_id
	from test.substance sub 
	where sub.substance_name like '%Oxid%uhelnatý%'
)
and mea.station_id in
(
	select st.station_id
	from test.station st
	where st.station_name like '%Motol%'
)

select *
from test.measurement mea
where mea.substance_id in 
(
	select sub.substance_id
	from test.substance sub 
	where sub.substance_name like '%Oxid%uhelnatý%'
)
and mea.station_name  like '%Motol%'




--_______________________________________3
alter table test.measurement 
drop constraint FK__measureme__stati__34C8D9D1

alter table test.station
drop constraint PK__station__44B370E9BC58C8DE



alter table test.station
drop column station_id

alter table test.station
add primary key (station_name)
--_______________________________________4
alter table test.measurement
add station_name varchar(50)  null

alter table test.measurement 
add foreign key (station_name) references test.station(station_name)

update test.measurement SET test.measurement.station_name = 'Bosonohy' where station_id = 1
update test.measurement SET test.measurement.station_name = 'Cernovír' where station_id = 2
update test.measurement SET test.measurement.station_name = 'Dejvice' where station_id = 3
update test.measurement SET test.measurement.station_name = 'Doubí' where station_id = 4
update test.measurement SET test.measurement.station_name = 'Dubina' where station_id = 5
update test.measurement SET test.measurement.station_name = 'Františkov' where station_id = 6
update test.measurement SET test.measurement.station_name = 'Chrlice' where station_id = 7
update test.measurement SET test.measurement.station_name = 'Kobylisy' where station_id = 8
update test.measurement SET test.measurement.station_name = 'Kyselov' where station_id = 9
update test.measurement SET test.measurement.station_name = 'Lazce' where station_id = 10
update test.measurement SET test.measurement.station_name = 'Liben' where station_id = 11
update test.measurement SET test.measurement.station_name = 'Motol' where station_id = 12
update test.measurement SET test.measurement.station_name = 'Poruba' where station_id = 13
update test.measurement SET test.measurement.station_name = 'Prívoz' where station_id = 14
update test.measurement SET test.measurement.station_name = 'Radíkov' where station_id = 15
update test.measurement SET test.measurement.station_name = 'Slatina' where station_id = 16
update test.measurement SET test.measurement.station_name = 'Troja' where station_id = 17
update test.measurement SET test.measurement.station_name = 'Turany' where station_id = 18
update test.measurement SET test.measurement.station_name = 'Vesec' where station_id = 19
update test.measurement SET test.measurement.station_name = 'Vyškovice' where station_id = 20





alter table test.measurement
drop column station_id

alter table test.measurement
alter column station_name varchar(50) not null