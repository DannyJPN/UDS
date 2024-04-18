--1
select * from vyrobek
where exists(select 1 from koupil where login = 'vinetu' and koupil.vID = vyrobek.vID) and
	exists(select 1 from koupil where login = 'pepik' and koupil.vID = vyrobek.vID) 
	
--2
select * from vyrobek v
where not exists(
  select 1 from koupil k
  where k.vid = v.vid
)

select * from vyrobek
where vID != all(select vId from koupil)

--3
select * from vyrobek
where exists(select vID from koupil where login = 'vinetu' and koupil.vID = vyrobek.vID) and
	not exists(select vID from koupil where login = 'vinetu' and koupil.vID = vyrobek.vID) 

--4
select distinct jmeno from koupil k1, vyrobek v
where exists (select * from koupil k2 where
				k1.login = k2.login and k1.vID = k2.vID and
				k1.rok != k2.rok) and
	k1.vID = v.vID

--5
select distinct jmeno from vyrobek v, koupil k2
where aktualni_cena > all(select cena from koupil k where k.vID = v.vID) and
	v.vID = k2.vID

select distinct jmeno from vyrobek v, koupil k2
where not exists(select cena from koupil k where k.vID = v.vID and k.cena >= v.aktualni_cena) and
	v.vID = k2.vID

--6
select distinct login from koupil k1 where
	not exists(select * from koupil k2 where k1.login = k2.login and (k1.vID != k2.vID or k1.rok != k2.rok))

--7
select distinct login from koupil k1 where
	not exists(select * from koupil k2 where k1.login = k2.login and k1.vID != k2.vID)
	
--8
select distinct jmeno from vyrobek v, koupil k1 where
	not exists(select * from koupil k2 where k1.login = k2.login and k1.vID != k2.vID) and
	v.vID = k1.vID

--9
select distinct login from koupil k1
where cena < all(select cena from koupil k2 where k1.login != k2.login and k1.vID = k2.vID)






--1
select login, count(*) pocet_nakupu
from koupil
group by login

--2
select vid, sum(cena) utrata
from koupil
group by vid

--3
select login, count(*) pocet_nakupu
from koupil
group by login
having count(*) > 2
