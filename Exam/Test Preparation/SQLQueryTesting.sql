-- Vypi�te v�echny dvojice station_id substance_id kde do�lo k p�ekro�en� limitu dan� l�tky na dan� stanici alespo� v dev�ti r�zn�ch m�s�c�ch.

select mea.station_id,mea.substance_id,count(distinct month(mea.meas_date))
from test.measurement mea
join test.substance sub on sub.limit<mea.concentration and mea.substance_id = sub.substance_id
group by  mea.station_id,mea.substance_id
having count(distinct month(mea.meas_date)) >=9
-- Pro ka�dou stanici v Ostrav� nalezn�te z�znam(y) v tabulce measurement,
-- kter� p�edstavuje nejvy��� nam��enou koncentraci oxidu uhelnat�ho v �datab�zi� stanice.
-- Berte do �vahy pouze m��en�, kde byla teplota pod 10 stup��
--Pozn.: substance_name je napsan� jako Oxid uhelnat� �CO (2 mezery m�sto jedn� jako u zbytku)
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
-- Ke ka�d� stanici vypi�te n�zev l�tky (nebo l�tek), kter� p�i m��en� nej�ast�ji p�ekro�ila povolen� limit. Vypi�te v�dy dvojici (n�zev stanice, n�zev l�tky) 
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

-- Ke ka�d� stanici vypi�te kolikr�t byla v prvn�m �tvrtlet� roku 2017 nam��ena hodnota pol�tav�ho prachu PM10, kter� p�esahuje povolen� limit 
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
-- Ke ka�d�mu m�stu vypi�te v�dy po�et p��slu�n�ch m���c�ch stanic,

select st.city_id,count(st.station_id)
from test.station st 
group by st.city_id

--kolikr�t byl p�ekro�en limit substance na stanici o v�ce jak 20% a o v�ce jak 50%

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


-- Ke ka�d� l�tce vypi�te pr�m�r nam��en� koncentrace ze v�ech m��en�. 
--Ke ka�d� l�tce d�le vypi�te bu� 'prekroceno', 'neprekroceno' v z�vislosti na tom, zda pr�m�r p�ekro�il nebo nep�ekro�il povolen� limit ��� 

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


-- dal�� mo�n� �e�en�, vyu��v� konstrukci CASE, ta ale nebyla v p�edm�tu probr�na
--nalezn�te stanice, kter� jsou um�st�ny v m�stech s minim�ln�
--Vyber stanici, kter� m�la nejvy��� po�et p�ekro�en� PM10, kter� se nach�z� v m�st� s minim�ln� 3 pr�myslov�mi zne�i��ovateli
--vyp�e maxim�ln� po�et z�znam� v tabulce measurement seskupeno podle stanice
--Kez by to tam bylo :D (y) 
--vypi�t� stanice kter� maj� vyv��en� nad 20 metr� a po�et z�znam� pod limit v�t�� ne� nad limit
