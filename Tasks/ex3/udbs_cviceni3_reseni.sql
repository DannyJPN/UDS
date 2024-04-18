-- 1
select jmeno
from vyrobek
where vid in
(
	select vid 
	from koupil k 
	where k.rok = 2009
)
--Dale reseni pouzivajici klasicky vnitrni join a distinct
select distinct v.jmeno
from vyrobek v
join koupil k on v.vID = k.vID
where rok = 2009 
-- Prvni reseni je nicméně mnohem lepší. Pokud je to možné je vhodné se Distinct vyhnout.


-- 2
SELECT v.jmeno FROM vyrobek v, koupil k WHERE v.vID = k.vID and k.login  = 'vinetu'
INTERSECT
SELECT v.jmeno FROM vyrobek v, koupil k WHERE v.vID = k.vID and k.login  = 'pepik';

SELECT v.jmeno FROM vyrobek v WHERE vID in 
(
  SELECT vID FROM koupil k WHERE k.login  = 'vinetu'
) and vID in 
(
  SELECT vID FROM koupil k WHERE k.login= 'pepik'
) 

-- 3
SELECT v.jmeno FROM vyrobek v WHERE vID IN (SELECT vID FROM koupil k WHERE k.login  = 'vinetu')
EXCEPT
SELECT v.jmeno FROM vyrobek v WHERE vID IN (SELECT vID FROM koupil k WHERE k.login  = 'pepik');								

SELECT v.jmeno FROM vyrobek v WHERE vID in (SELECT vID FROM koupil k WHERE k.login  = 'vinetu') and
									vID not in (SELECT vID FROM koupil k WHERE k.login  = 'pepik')

-- 4 
SELECT jmeno FROM vyrobek 
EXCEPT
SELECT jmeno FROM vyrobek v, koupil k WHERE v.vID = k.vID

SELECT v.jmeno FROM vyrobek v WHERE v.vID not in (SELECT vID FROM koupil)

-- 5
(SELECT v.jmeno FROM vyrobek v, koupil k WHERE v.vID = k.vID and k.login  = 'vinetu'
UNION
SELECT v.jmeno FROM vyrobek v, koupil k WHERE v.vID = k.vID and k.login  = 'pepik')
EXCEPT
(SELECT v.jmeno FROM vyrobek v, koupil k WHERE v.vID = k.vID and k.login  = 'vinetu'
INTERSECT
SELECT v.jmeno FROM vyrobek v, koupil k WHERE v.vID = k.vID and k.login  = 'pepik')

SELECT v.jmeno
FROM vyrobek v
WHERE (
    vid in (
        select vid
        from koupil
        where login = 'vinetu'
    ) or
    vid in (
        select vid
        from koupil
        where login = 'pepik'
    )
) and
not(
    vid in (
        select vid
        from koupil
        where login = 'vinetu'
    ) and vid in (
        select vid
        from koupil
        where login = 'pepik'
    )
) 

-- 6
select jmeno from vyrobek v
join koupil k on k.vid = v.vid
except
select jmeno from vyrobek v
join koupil k on k.vid = v.vid
where rok < 2007 or rok > 2009

select distinct jmeno from vyrobek v
join koupil k on k.vid = v.vid
where v.vid not in (
  select vid
  from koupil
  where rok < 2007 or rok > 2009
)

-- 7
select distinct jmeno
from vyrobek v
join koupil k on k.vid = v.vid
where v.vid not in
(
	select vid
	from koupil k
	join uzivatel u on k.login = u.login
	where u.mesto in
	(
		select distinct mesto
		from uzivatel
		where mesto != 'ostrava' and mesto != 'brno'
	)
)

select jmeno
from vyrobek v
join koupil k on k.vid = v.vid
except
select jmeno
from koupil k
join uzivatel u on k.login = u.login
join vyrobek v on k.vID = v.vid
where u.mesto in
(
	select distinct mesto
	from uzivatel
	where mesto != 'ostrava' and mesto != 'brno'
)


select jmeno
from vyrobek v
join koupil k on k.vid = v.vid
except
select v.jmeno
from koupil k
join uzivatel u1 on k.login = u1.login
join vyrobek v on k.vID = v.vid
join uzivatel u2 on u1.mesto = u2.mesto
where u2.mesto != 'ostrava' and u2.mesto != 'brno'

-- Bonus
select distinct v.vid, v.jmeno
from vyrobek v
join koupil k on v.vID = k.vID
where v.vid not in
(
    select v.vid
    from vyrobek v
    join koupil k on v.vID = k.vID
    where abs(k.cena - v.aktualni_cena) > 50
)


select v.vid, v.jmeno
from vyrobek v
where v.vid in (select vid from koupil) and
      v.vid not in
(
    select v.vid
    from vyrobek v
    join koupil k on v.vID = k.vID
    where abs(k.cena - v.aktualni_cena) > 50
) 
