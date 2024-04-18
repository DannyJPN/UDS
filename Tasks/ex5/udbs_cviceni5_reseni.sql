
-- 1
SELECT v.vID, jmeno, SUM(cena) 
FROM vyrobek v 
	LEFT JOIN koupil k ON v.vID = k.vID 
GROUP BY jmeno, v.vID 

--2
SELECT v.vID, jmeno, COUNT(k.vID) FROM vyrobek v 
	LEFT JOIN koupil k ON v.vID = k.vID 
GROUP BY jmeno, v.vID ORDER BY COUNT(k.vID) desc	

--3
SELECT v.vID, jmeno, COUNT(ku.vID) FROM vyrobek v 
	LEFT JOIN  (SELECT k.vID FROM koupil k, uzivatel u 
				WHERE k.login = u.login and k.rok = 2009 and 
					u.rok_narozeni > 1980 and u.rok_narozeni < 1995) ku 
	on ku.vID = v.vID
GROUP BY jmeno, v.vID

--4 
SELECT u.login, COUNT(k1.login) FROM uzivatel u
	left join koupil k1 on u.login = k1.login and not exists
	(SELECT * FROM koupil k2 WHERE k1.vID = k2.vID and k2.cena < k1.cena)
GROUP BY u.login

SELECT u.login, COUNT(k1.login) FROM uzivatel u
	left join koupil k1 on u.login = k1.login and 
		k1.cena = (SELECT MIN(cena) FROM koupil k2 WHERE k1.vID = k2.vID)
GROUP BY u.login
		
--5
SELECT v.vID, jmeno, COUNT(k.vID) v_count FROM vyrobek v 
		LEFT JOIN koupil k ON v.vID = k.vID 	
GROUP BY jmeno, v.vID
HAVING COUNT(k.vID) >= all(
  SELECT COUNT(k.vID) as v_count 
  FROM vyrobek v 
  LEFT JOIN koupil k2 ON v.vID = k2.vID 
  GROUP BY jmeno, v.vID
)



