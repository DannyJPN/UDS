select  v.jmeno
from vyrobek v
where exists
(
select * from koupil k where k.login = 'vinetu' and v.vID = k.vID 
)
and exists
(

select * from koupil k where k.login = 'pepik' and v.vID = k.vID
)



--________________________________________________________________
select v.jmeno
 from vyrobek v
where not exists
(
select * from koupil k where v.vID = k.vID 
)

--_______________________________________________________________
select  v.jmeno
from vyrobek v
where exists
(
select * from koupil k where k.login = 'vinetu' and v.vID = k.vID 
)
and not exists
(

select * from koupil k where k.login = 'pepik' and v.vID = k.vID
)
--_____________________________________________________________
select v.jmeno from vyrobek v where v.vID in (
select k1.vid 
from koupil k1
where exists
(
select * from koupil k2 where k1.vid = k2.vid and k1.login = k2.login and k1.rok != k2.rok
))
--______________________________________________________________

select * from vyrobek v
where not exists
(
select * from koupil k where k.cena >= v.aktualni_cena and k.vID = v.vID 
)
and  exists
(

select * from koupil k where v.vID = k.vID 

)
--______________________________________________________________

select * 
from koupil k1
where not exists
(
select * from koupil k2 where  k1.login = k2.login and (k1.vid != k2.vid or k1.rok != k2.rok)
)

--______________________________________________________________

select distinct k1.login
from koupil k1
where not exists
(
select * from koupil k2 where  k1.login = k2.login and k1.vid != k2.vid 
)
--__________________________________________________________________

select v.jmeno
from vyrobek v
where v.vID in(
select k1.vID
from koupil k1
where not exists
(
select * from koupil k2 where  k1.login = k2.login and k1.vid != k2.vid 
)
)
--___________________________________________________________________

select distinct k1.login from koupil k1
where not exists
(
select * from koupil k2 where k1.cena>k2.cena and k1.vid = k2.vid
)

--___________________________________________________________________
select distinct k1.login from koupil k1
where k1.cena <= all
(
select k2.cena from koupil k2 where k1.vid = k2.vid 
)
--_____________________________________________________________________
--_____________________________________________________________________
--_____________________________________________________________________
--_____________________________________________________________________


select k.login,count(k.login)
from koupil k
group by k.login


select k.vID,sum(k.cena)
from koupil k
group by k.vID

select * from koupil order by vid

select k.login,count(k.login)
from koupil k
group by k.login
having count(k.login) >2