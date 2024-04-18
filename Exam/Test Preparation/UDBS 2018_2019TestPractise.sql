-- Vypište všechny dvojice station_id substance_id kde došlo k překročení limitu dané látky na dané stanici alespoň v devíti různých měsících.


SELECT m.station_id, m.substance_id, COUNT(DISTINCT MONTH(m.meas_date)) as prekroceni
FROM test.measurement as m
LEFT JOIN test.substance as s ON m.substance_id = s.substance_id
WHERE m.concentration > s.limit
GROUP BY station_id, m.substance_id
HAVING COUNT(DISTINCT MONTH(meas_date)) >= 9;


-- Pro každou stanici v Ostravě nalezněte záznam(y) v tabulce measurement,
-- který představuje nejvyšší naměřenou koncentraci oxidu uhelnatého v “databázi” stanice.
-- Berte do úvahy pouze měření, kde byla teplota pod 10 stupňů
--Pozn.: substance_name je napsaný jako Oxid uhelnatý  CO (2 mezery místo jedné jako u zbytku)


SELECT s.station_name, MAX(m.concentration)
FROM test.station s
   LEFT JOIN test.measurement m ON s.station_id = m.station_id
WHERE s.city_id = (SELECT city_id FROM test.city WHERE city_name = 'Ostrava')
AND m.substance_id = (SELECT substance_id FROM test.substance WHERE substance_name = 'Oxid uhelnatý  CO')
AND m.temperature < 10
GROUP BY s.station_name;


/* Ke každé stanici vypište název látky (nebo látek), která při měření nejčastěji překročila povolený limit. Vypište vždy dvojici (název stanice, název látky) */


/* Nechybi nekde neco jako measurement.concentration >= substance.limit? */


SELECT st.station_name, su.substance_name
FROM test.station st
        LEFT JOIN test.measurement me ON st.station_id = me.station_id
        LEFT JOIN test.substance su ON me.substance_id = su.substance_id
GROUP BY st.station_id, st.station_name, me.substance_id, su.substance_name
HAVING COUNT(me.substance_id) >= ALL
(        
        SELECT COUNT(*)
        FROM test.measurement me_in
        WHERE me_in.station_id = st.station_id
        GROUP BY me_in.substance_id
)




-- vypsat vsechny dvojice (station_id, substance_id), kde doslo k prekroceni limitu koncentrace danné látky na danné stanici aspon v deviti ruznych mesicich


SELECT station_id, m.substance_id, COUNT(distinct month(meas_date))
FROM test.measurement m
JOIN test.substance s on m.substance_id = s.substance_id  
WHERE m.concentration > s.limit                     
GROUP BY station_id, m.substance_id
HAVING  COUNT(DISTINCT MONTH(meas_date)) >= 9




-- najdete stanice, kde v mesici unor nedoslo k prekroceni koncentrace latky Poletaveho prachu PM10


SELECT  * FROM test.station WHERE station_id NOT IN (SELECT me.station_id
        FROM test.measurement me
                JOIN test.substance su ON me.substance_id = su.substance_id
        WHERE MONTH(me.meas_date) = 2
                AND su.substance_name = 'Polétavý prach PM10'
                AND me.concentration >= su.limit)


select * from test.station
except
       select stat.* from test.station stat
join test.measurement meas on stat.station_id = meas.station_id
join test.substance sub on sub.substance_id = meas.substance_id
       where sub.limit < meas.concentration and
           MONTH(meas.meas_date) = 2 and
         sub.substance_name = 'Polétavý prach PM10'




SELECT *
FROM test.station st1
WHERE st1.station_id NOT IN (
   SELECT DISTINCT(st.station_id)
   FROM test.station st
   LEFT JOIN test.measurement me ON st.station_id = me.station_id
   LEFT JOIN test.substance su ON su.substance_id = me.substance_id
   WHERE su.substance_name = 'Polétavý prach PM10'
   AND MONTH(me.meas_date) = 2
   AND me.concentration > su.limit
)








-- najdete latky u kterych koncentrace prekrocila limit v kvetnu SOUCASNE na stanicich id 1 a 2


        SELECT su.substance_name
        FROM test.measurement me
        JOIN test.substance su 
ON me.substance_id = su.substance_id
        AND MONTH(me.meas_date) = 5
        WHERE me.station_id = 1
        AND me.concentration >= su.limit
                INTERSECT
        SELECT su.substance_name
        FROM test.measurement me
        JOIN test.substance su
ON me.substance_id = su.substance_id
        AND MONTH(me.meas_date) = 5
        WHERE me.station_id = 2
        AND me.concentration >= su.limit




















/* Ke každé stanici vypište kolikrát byla v prvním čtvrtletí roku 2017 naměřena hodnota polétavého prachu PM10, která přesahuje povolený limit */


SELECT *, 
(
        SELECT COUNT(*) 
        FROM test.measurement me
                JOIN test.substance su ON me.substance_id = su.substance_id
        WHERE MONTH(me.meas_date) BETWEEN 1 AND 3 -- chceme data pro první čtvrtletí ... tedy leden, únor, březen
                AND YEAR(me.meas_date) = 2017 -- roku 2017
                AND su.substance_name = 'Polétavý prach PM10' -- zajímá nás pouze polétavý prach
                AND me.concentration > su.limit         -- kde naměřená koncentrace je větší než povolený limit
                AND me.station_id = st.station_id
) 'pocet prekroceni'
FROM test.station st


--KAM ZMIZELO ZADÁNÍ!?
--> SNAD JE TO TOHLE


 /* Ke každému městu vypište vždy počet příslušných měřících stanic,
 počet průmyslových zdrojů znečištění
  a počet zdrojů znečištění typu 'Lokální topenište' */




SELECT *,
(
        SELECT COUNT(*)
        FROM test.station st
        WHERE st.city_id = ci.city_id
) 'pocet stanic',
(
        SELECT COUNT(*)
        FROM test.source so
        WHERE so.source_type = 'Prumysl'
                AND so.city_id = ci.city_id
) 'zdroj prumysl',
(
        SELECT COUNT(*)
        FROM test.source so
        WHERE so.source_type = 'Lokální topenište'
                AND so.city_id = ci.city_id
) 'zdroj lokalni topeniste'
FROM test.city ci
















/*kolikrát byl překročen limit substance na stanici o více jak 20% a o více jak 50%*/


SELECT st.station_name,st.station_id,su.substance_name,su.substance_id,
        (
        SELECT COUNT(*) pocet20
        FROM  test.measurement me
        WHERE su.substance_id = me.substance_id
AND st.station_id = me.station_id
        AND me.concentration / limit * 100 > 120
        )'pocet_20',
        (
        SELECT COUNT(*) pocet50
        FROM  test.measurement me
        WHERE su.substance_id = me.substance_id
AND st.station_id = me.station_id
        AND me.concentration / limit * 100 > 150
        )'pocet_50'
FROM test.substance su, test.station st
ORDER BY st.station_id,su.substance_id DESC




/* Ke každé látce vypište průměr naměřené koncentrace ze všech měření. Ke každé látce dále vypište buď 'prekroceno', 'neprekroceno' v závislosti na tom, zda průměr překročil nebo nepřekročil povolený limit */        


	SELECT su.substance_id, su.substance_name, su.limit, me.prumer, me.stav
	FROM test.substance su
			LEFT JOIN 
			(
					SELECT me2.substance_id, AVG(me2.concentration) prumer, 'prekroceno' stav
					FROM test.measurement me2
							JOIN test.substance su2 ON me2.substance_id = su2.substance_id
					GROUP BY me2.substance_id, su2.limit
					HAVING AVG(me2.concentration) > su2.limit
					UNION
					SELECT me2.substance_id, AVG(me2.concentration) prumer, 'neprekroceno' stav
					FROM test.measurement me2
							JOIN test.substance su2 ON me2.substance_id = su2.substance_id
					GROUP BY me2.substance_id, su2.limit
					HAVING AVG(me2.concentration) <= su2.limit
			) me ON su.substance_id = me.substance_id




















-- další možné řešení, využívá konstrukci CASE, ta ale nebyla v předmětu probrána


SELECT su.substance_id, su.substance_name, su.limit, me.prumer, 
        CASE        
                WHEN me.prumer > su.limit THEN 'prekroceno' 
                WHEN me.prumer <= su.limit THEN 'neprekroceno' 
        END 'stav'
FROM test.substance su
        LEFT JOIN 
        (
                SELECT me2.substance_id, AVG(me2.concentration) prumer
                FROM test.measurement me2
                GROUP BY me2.substance_id
        ) me ON su.substance_id = me.substance_id






/*nalezněte stanice, které jsou umístěny v městech s minimálně
4 průmyslovými znečišťovately a minimálně 3 lokálnimi znečišťovateli*/
        
SELECT station_name
FROM test.source so
JOIN test.city ci ON so.city_id=ci.city_id AND source_type='Prumysl'
JOIN test.station st ON st.city_id=ci.city_id
GROUP BY station_name
HAVING COUNT(*) >=4
        INTERSECT
SELECT station_name
FROM test.source so
JOIN test.city ci ON so.city_id=ci.city_id AND source_type='Lokální topenište'
JOIN test.station st ON st.city_id=ci.city_id
GROUP BY station_name
HAVING COUNT(*) >=3


















/*Vyber stanici, která měla nejvyšší počet překročení PM10, která se nachází v městě s minimálně 3 průmyslovými znečišťovateli*/
SELECT station_name
FROM test.measurement me
JOIN test.station st
ON st.station_id=me.station_id
JOIN test.substance su
ON su.substance_id=me.substance_id
WHERE st.station_id IN (SELECT station_id
                                FROM test.station st
                                JOIN test.city ci
ON ci.city_id=st.city_id
                                JOIN test.source so
ON so.city_id=ci.city_id
                                WHERE source_type='Prumysl'
                                GROUP BY st.station_id
                                HAVING COUNT(*)>3)
AND substance_name='Polétavý prach PM10'
AND concentration>limit
GROUP BY station_name
HAVING COUNT(*) >= ALL (SELECT COUNT(*)
                                FROM test.measurement me_in
                                JOIN test.station st
ON st.station_id=me_in.station_id
                                JOIN test.substance su
ON su.substance_id=me_in.substance_id
                                WHERE st.station_id IN (SELECT station_id
                                                                FROM test.station st
                                                                JOIN test.city ci
ON ci.city_id=st.city_id
                                                                JOIN test.source so
ON so.city_id=ci.city_id
                                                                WHERE source_type='Prumysl'
                                                                GROUP BY st.station_id
                                                                HAVING COUNT(*)>3)
                                AND substance_name='Polétavý prach PM10'
                                AND concentration>limit
                                GROUP BY station_name)



--vypíše maximální počet záznamů v tabulce measurement seskupeno podle stanice
--Kez by to tam bylo :D (y) 


SELECT station_id, COUNT(*) pocet
FROM test.measurement
GROUP BY station_id




/*vypiště stanice které mají vyvýšení nad 20 metrů a počet záznamů pod limit větší než nad limit*/


SELECT station_name
FROM test.station st
WHERE elevation>20
AND         (
SELECT COUNT(*) pocet
        FROM test.measurement me
        JOIN test.substance su ON su.substance_id=me.substance_id
        WHERE concentration>limit
        AND st.station_id=me.station_id
        )
        <
        (
SELECT COUNT(*) pocet
        FROM test.measurement me
        JOIN test.substance su ON su.substance_id=me.substance_id
        WHERE concentration<limit
        AND st.station_id=me.station_id
        )