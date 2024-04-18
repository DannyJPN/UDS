-- Vypište všechny dvojice (station_id, substance_id) kde došlo k překročení limitu koncentrace
-- dané látky na dané stanici alespoň v devíti různých měsících.
select t.station_id, t.substance_id
from
(
	select m.station_id, m.substance_id
	from test.measurement m
	join test.substance su on m.substance_id = su.substance_id
	where m.concentration >= su.limit
	group by m.station_id, m.substance_id, month(m.meas_date)
) t
group by t.station_id, t.substance_id
having count(*) >= 9

select m.station_id, m.substance_id
from test.measurement m
join test.substance su on m.substance_id = su.substance_id
where m.concentration >= su.limit
group by m.station_id, m.substance_id
having count(distinct month(m.meas_date)) >= 9

-- Pro každou stanici v Ostravě nalezněte záznam(y) v tabulce measurement, 
-- který pro danou stanici představuje nejvyšší koncentraci oxidu uhelnatého.
-- Berte do úvahy pouze měření, při kterých byla teplota pod 10 stupňů.
select m.*
from test.measurement m
join test.station s on m.station_id = s.station_id
join test.city c on s.city_id = c.city_id
join 
(
	select m.station_id, max(m.concentration) max_concentration
	from test.measurement m
	join test.substance su on m.substance_id = su.substance_id
	where substance_name = 'Oxid uhelnatý  CO' and temperature < 10
	group by m.station_id
) t on m.station_id = t.station_id and
       m.concentration = t.max_concentration
where c.city_name = 'Ostrava'


SELECT m1.*
FROM
	test.measurement m1
	JOIN test.station st ON m1.station_id = st.station_id
	JOIN test.city c ON st.city_id = c.city_id
	JOIN test.substance su ON m1.substance_id = su.substance_id
WHERE
	c.city_name = 'Ostrava' AND su.substance_name = 'Oxid Uhelnatý  CO' AND m1.temperature < 10
	AND m1.concentration >= ALL (
		SELECT concentration
		FROM test.measurement m2
		WHERE
			m2.station_id = m1.station_id AND m2.substance_id = m1.substance_id AND
			m2.temperature < 10
	)


SELECT m1.*
FROM
	test.measurement m1
	JOIN test.substance su ON m1.substance_id = su.substance_id
	JOIN test.station st ON m1.station_id = st.station_id
	JOIN test.city c ON c.city_id = st.city_id
WHERE
	c.city_name = 'Ostrava' AND su.substance_name = 'Oxid Uhelnatý  CO' AND m1.temperature < 10
	AND NOT EXISTS (
		SELECT *
		FROM test.measurement m2
		WHERE
			m1.station_id = m2.station_id AND m1.substance_id = m2.substance_id AND m2.temperature < 10 AND
			m2.concentration > m1.concentration
	)

SELECT m1.*
FROM
	test.measurement m1
	JOIN test.substance su ON m1.substance_id = su.substance_id
	JOIN test.station st ON m1.station_id = st.station_id
	JOIN test.city c ON c.city_id = st.city_id
WHERE
	c.city_name = 'Ostrava' AND su.substance_name = 'Oxid Uhelnatý  CO' AND m1.temperature < 10
	AND m1.concentration = (
		SELECT MAX(m2.concentration)
		FROM test.measurement m2
		WHERE m1.station_id = m2.station_id AND m1.substance_id = m2.substance_id AND m2.temperature < 10 
	)


--Naleznětě substance, jejichž koncentrace překročila limit pro danou látku
-- v květnu na stanicích jedna i dva (tzn. na obou).
select su.substance_id, count(distinct m.station_id)
from test.substance su
left join test.measurement m on su.substance_id = m.substance_id
where m.station_id IN (1,2) and month(m.meas_date) = 5 and m.concentration > su.limit
group by su.substance_id
having count(distinct m.station_id) = 2

SELECT *
FROM test.substance su
WHERE
	EXISTS (
		SELECT *
		FROM test.measurement m
		WHERE su.substance_id = m.substance_id AND MONTH(m.meas_date) = 5 AND m.station_id = 1
	)
	AND EXISTS (
		SELECT *
		FROM test.measurement m
		WHERE su.substance_id = m.substance_id AND MONTH(m.meas_date) = 5 AND m.station_id = 2
	)

--Nalezněte stanice, kde v měsíci únor nedošlo k překročení limitní koncentrace u polétavého prachu PM10
select *
from test.station s
where not exists(
  select 1
  from test.measurement m 
  join test.substance su on m.substance_id = su.substance_id
  where s.station_id = m.station_id and m.concentration > su.limit and month(m.meas_date) = 2 and substance_name = 'Polétavý prach PM10'
)

SELECT *
FROM test.station st
WHERE station_id NOT IN (
	SELECT station_id
	FROM test.measurement m JOIN test.substance su ON m.substance_id = su.substance_id
	WHERE
		m.concentration > su.limit AND
		substance_name = 'Polétavý prach PM10' AND MONTH(m.meas_date) = 2
)

--Nalezněte stanice, které jsou umístěny v městech s minimálně čtyřmi průmyslovými znečišťovateli 
-- a minimálně třemi lokálními znečišťovateli
select *
from test.station s
where s.city_id in
(
	select c.city_id
	from test.city c
	join test.source so on c.city_id = so.city_id
	group by c.city_id
	having count(case when source_type = 'Lokální topenište'  then 1 end) > 2 and
	       count(case when source_type = 'Prumysl' then 1 end) > 3
)


SELECT s.*
FROM test.city c JOIN test.station s ON c.city_id = s.city_id
WHERE
(
	SELECT COUNT(*)
	FROM test.source s
	WHERE s.source_type = 'Prumysl' AND s.city_id = c.city_id
) >= 4 AND
(
	SELECT COUNT(*)
	FROM test.source s
	WHERE s.source_type = 'Lokální topenište' AND s.city_id = c.city_id
) >= 3