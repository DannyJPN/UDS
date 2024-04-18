select v.jmeno,t.suma from vyrobek v
left join 
(
select k.vid,sum(k.cena) as suma
from koupil k
group by k.vid
) t on t.vid = v.vid
order by t.suma



select v.jmeno, sum(k.cena)
from vyrobek v
left join koupil k on v.vid = k.vid
group by v.vid,v.jmeno
order by sum(k.cena)
--_________________________________________________

select v.jmeno, count(k.vid)
from vyrobek v
left join koupil k on v.vid = k.vid
group by v.vid,v.jmeno
order by count(k.cena)

--_______________________________________
select v.jmeno, count(k.vid)
from vyrobek v
left join koupil k on v.vid = k.vid and k.rok = 2009
group by v.vid,v.jmeno
order by sum(k.cena)


select v.jmeno, count(k.vid)
from vyrobek v
left join koupil k on v.vid = k.vid
where k.rok = 2009 
group by v.vid,v.jmeno
order by sum(k.cena)
--_________________________________________________
select  v.jmeno, count(k.vid)
from vyrobek v
left join koupil k on v.vid = k.vid and k.rok = 2009
left join uzivatel u on k.login = u.login and u.rok_narozeni between 1980 and 1995
group by v.vid,v.jmeno
order by sum(k.cena)
--__________________________________________


select  u.login, count(t.minim)
from uzivatel u
left join koupil k2 on k2.login = u.login
left join 
(
	select k.vid,min(k.cena) as minim
	from koupil k 
	group by k.vid
) t on k2.vid = t.vid and k2.cena = t.minim 
group by u.login



select u.login,count(k1.login) 
from uzivatel u
left join
koupil k1 on u.login = k1.login and cena <= all
(
	select cena
	from koupil k2 
	where k1.vid = k2.vid
)group by u.login
--____________________________________________________



select v.jmeno, count(k.vid) 
from vyrobek v
left join koupil k on v.vid = k.vid
group by v.vid,v.jmeno
having count(k.vid) >= all
(
select  count(k1.vid) 
from vyrobek v1
left join koupil k1 on v1.vid = k1.vid
group by v1.vid,v1.jmeno
)
--order by count(k.cena)
--_________________________________________________________
select *
from(
select v.jmeno, min(k.cena) as min
from vyrobek v
left join koupil k on v.vid = k.vid
group by v.vid,v.jmeno
--order by v.jmeno
)mn
left join(
select v.jmeno, max(k.cena) as max
from vyrobek v
left join koupil k on v.vid = k.vid
group by v.vid,v.jmeno
--order by v.jmeno
)mx on mn.jmeno = mx.jmeno
left join(
select v.jmeno, max(k.cena)-min(k.cena) as diff
from vyrobek v
left join koupil k on v.vid = k.vid
group by v.vid,v.jmeno
--order by v.jmeno
)df on mn.jmeno = df.jmeno




select v.jmeno, max(k.cena)-min(k.cena)
from vyrobek v
left join koupil k on v.vid = k.vid
group by v.vid,v.jmeno

having max(k.cena)-min(k.cena) >= all
(
select  max(k1.cena)-min(k1.cena) as diff
from vyrobek v1
left join koupil k1 on v1.vid = k1.vid
group by v1.vid,v1.jmeno
--order by v.jmeno
)