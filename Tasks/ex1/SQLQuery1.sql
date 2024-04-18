select * from uzivatel
select * from koupil
select * from vyrobek

select * from uzivatel where (rok_narozeni  between 1980 and 1990) or rok_narozeni %2 =0

select distinct koupil.rok from koupil,vyrobek
where vyrobek.jmeno = 'lampa' and koupil.vID = vyrobek.vID
order by koupil.rok