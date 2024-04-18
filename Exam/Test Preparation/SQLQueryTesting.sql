-- Vypište všechny dvojice station_id substance_id kde došlo k pøekroèení limitu dané látky na dané stanici alespoò v devíti rùznıch mìsících.

select mea.station_id,mea.substance_id,count(distinct month(mea.meas_date))
from test.measurement mea
join test.substance sub on sub.limit<mea.concentration and mea.substance_id = sub.substance_id
group by  mea.station_id,mea.substance_id
having count(distinct month(mea.meas_date)) >=9
-- Pro kadou stanici v Ostravì naleznìte záznam(y) v tabulce measurement,
-- kterı pøedstavuje nejvyšší namìøenou koncentraci oxidu uhelnatého v “databázi” stanice.
-- Berte do úvahy pouze mìøení, kde byla teplota pod 10 stupòù
--Pozn.: substance_name je napsanı jako Oxid uhelnatı  CO (2 mezery místo jedné jako u zbytku)
select * from
( select st.station_name,mea.concentration,
 (
    select max(me.concentration) 
    from test.measurement me 
    where me.station_id = mea.station_id and me.temperature <10
 )   maxcon
 from test.measurement mea
 join test.station st on st.station_id = mea.station_id
 where mea.substance_id in
 (
    select su.substance_id from test.substance su where su.substance_name like '%Oxid%uhelnat%'
 )
and
 st.city_id in
 (
    select c.city_id from test.city c where c.city_name = 'Ostrava'
 )
 ) tablewithmax
 where tablewithmax.concentration = tablewithmax.maxcon
-- Ke kadé stanici vypište název látky (nebo látek), která pøi mìøení nejèastìji pøekroèila povolenı limit. Vypište vdy dvojici (název stanice, název látky) 
-- Nechybi nekde neco jako measurement.concentration >= substance.limit? 

    select mea.station_id,mea.substance_id,sub.substance_name,count(*) overflow
	from test.measurement mea
	join test.substance sub on sub.substance_id = mea.substance_id and mea.concentration>sub.limit
	group by mea.station_id,mea.substance_id,sub.substance_name
	having count(*) >= all
	(
		select count(*)
		from test.measurement me
		join test.substance su on su.substance_id = me.substance_id and me.concentration>su.limit
		group by me.station_id,me.substance_id
		having me.station_id = mea.station_id
	)
	order by mea.station_id,mea.substance_id
-- najdete stanice, kde v mesici unor nedoslo k prekroceni koncentrace latky Poletaveho prachu PM10
   select * 
   from
   (
	select st.station_name,
		(
			select count(*) 
			from test.measurement me 
			left join test.substance su on su.limit<me.concentration 
			and  su.substance_id = me.substance_id 
			where month(me.meas_date) = 2   and substance_name like '%PM10%'
			and st.station_id = me.station_id
		) as overflow
		from test.station st
	)  overflowtab
	where overflowtab.overflow = 0
-- najdete latky u kterych koncentrace prekrocila limit v kvetnu SOUCASNE na stanicich id 1 a 2

select * 
from test.substance sub
join test.measurement mea on sub.limit<mea.concentration and sub.substance_id = mea.substance_id
where month(mea.meas_date) = 5
and exists
( select * from test.measurement me where me.station_id = 1 and me.substance_id = sub.substance_id)
and exists
( select * from test.measurement me where me.station_id = 2 and me.substance_id = sub.substance_id)

-- Ke kadé stanici vypište kolikrát byla v prvním ètvrtletí roku 2017 namìøena hodnota polétavého prachu PM10, která pøesahuje povolenı limit 
select *,
(
    select count(*) 
    from test.measurement me
    join test.substance sub on sub.substance_id = me.substance_id and sub.limit < me.concentration 
    where month(me.meas_date) between 1 and 3
	and year(me.meas_date) = 2017 and sub.substance_name like '%PM10%' 
	and st.station_id = me.station_id
	
                             
)overflow
from test.station st
-- Ke kadému mìstu vypište vdy poèet pøíslušnıch mìøících stanic,

select st.city_id,count(st.station_id)
from test.station st 
group by st.city_id

--kolikrát byl pøekroèen limit substance na stanici o více jak 20% a o více jak 50%

select * ,
(
	select count(*) 
	from test.measurement mea
	join test.substance sub on sub.substance_id = mea.substance_id
	where mea.concentration > sub.limit*1.2
	and st.station_id = mea.station_id
	and su.substance_id = mea.substance_id
)pocet20
,
(
	select count(*) 
	from test.measurement mea
	join test.substance sub on sub.substance_id = mea.substance_id
	where mea.concentration > sub.limit*1.5
	and st.station_id = mea.station_id
	and su.substance_id = mea.substance_id
)pocet50

from test.station st,test.substance su


-- Ke kadé látce vypište prùmìr namìøené koncentrace ze všech mìøení. 
--Ke kadé látce dále vypište buï 'prekroceno', 'neprekroceno' v závislosti na tom, zda prùmìr pøekroèil nebo nepøekroèil povolenı limit     

	select * ,
	(
		select avg(mea.concentration) 
		from test.measurement mea
		join test.substance su on su.substance_id=mea.substance_id
		where mea.substance_id = sub.substance_id
	) as average
	,
	(
		select avg(mea.concentration) aver
		from test.measurement mea
		join test.substance su on su.substance_id=mea.substance_id
		where mea.substance_id = sub.substance_id
		
	)
	from test.substance sub


-- další moné øešení, vyuívá konstrukci CASE, ta ale nebyla v pøedmìtu probrána
--naleznìte stanice, které jsou umístìny v mìstech s minimálnì
--Vyber stanici, která mìla nejvyšší poèet pøekroèení PM10, která se nachází v mìstì s minimálnì 3 prùmyslovımi zneèišovateli
--vypíše maximální poèet záznamù v tabulce measurement seskupeno podle stanice
--Kez by to tam bylo :D (y) 
--vypištì stanice které mají vyvıšení nad 20 metrù a poèet záznamù pod limit vìtší ne nad limit
