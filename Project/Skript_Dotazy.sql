--SKUPINA 1
/*1;1;80;
Vypište seznam jmen všech družstev*/
select nazev_druzstva
from druzstvo

/*1;2;29;
Vypište webové stránky oddílù seøazených sestupnì*/
select web
from oddil
order by web 

/*1;3;321;
Vypište seznam hráèù seøazených podle VÌKU sestupnì. */

select prijmeni,jmeno,datum_narozeni,cast (
 year(GETDATE())-year(datum_narozeni)
+(month(GETDATE())-month(datum_narozeni))/12.0
+(day(GETDATE())-day(datum_narozeni))/365.0   as int) vek
from hrac
order by vek desc

/*1;4;321; 
Vypište celá jména všech hráèù*/
select  CONCAT(prijmeni,' ',jmeno) as cele_jmeno
from hrac 

--SKUPINA 2
/*2;1;408; 
Vypište seznam zápasù sezony 2015/2016,kde jeden z hráèù nevyhrál žádný set*/
select hrac_id1,hrac_id2,skore
from zapas
where sezona = '2015/2016' and (substring(skore,1,1) = 0 or substring(skore,3,1) = 0) 

/*2;2;237;
Vypište zápasy odehrané v sezonì 2014/2015*/
select hrac_id1,hrac_id2,skore 
from zapas
where sezona = '2014/2015'  

/*2;3;278; 
Vypište všechny hráèe,kteøí jsou-nebo se letos stanou-plnoletými*/
select prijmeni,jmeno
from hrac
where NOT (Year(getdate()) - year(datum_narozeni) <18)

/*2;4;30;
Vypište všechny hráèky*/
select prijmeni,jmeno
from hrac
where prijmeni like '%ová'

--SKUPINA 3
/*3;1;24;  
Vypište hráèe,kteøí byli 1.ledna letošního roku nezletilí a byli narozeni v první polovinì roku */
select     hrac.prijmeni,hrac.jmeno,hrac.datum_narozeni
from  hrac
where exists 
(
    select * 
	from hrac as hrac2  
	where year(getdate())-year(hrac2.datum_narozeni) <=18 and month(hrac2.datum_narozeni) between 1 and 6
    and hrac2.hrac_id = hrac.hrac_id
)


/*3;2;24;  Vypište hráèe,kteøí byli 1.ledna letošního roku nezletilí a byli narozeni v první polovinì roku */
select hrac.prijmeni,hrac.jmeno,hrac.datum_narozeni
from  hrac
where hrac.hrac_id in 
(
    select hrac2.hrac_id from hrac as hrac2 
	where year(getdate())-year(hrac2.datum_narozeni) <=18 and month(hrac2.datum_narozeni) between 1 and 6
)

/*3;3;24;
Vypište hráèe,kteøí byli 1.ledna letošního roku nezletilí a byli narozeni v první polovinì roku */
select hrac.prijmeni,hrac.jmeno,hrac.datum_narozeni
from  hrac
where  year(getdate())-year(hrac.datum_narozeni) <=18 

intersect
(   
    select hrac.prijmeni,hrac.jmeno,hrac.datum_narozeni
    from  hrac
    where    month(hrac.datum_narozeni) between 1 and 6
 
    
    
)
 
/*3;4;24;
Vypište hráèe,kteøí byli 1.ledna letošního roku nezletilí a byli narozeni v první polovinì roku */
select hrac.prijmeni,hrac.jmeno,hrac.datum_narozeni
 from hrac
 except
 (
     select hrac2.prijmeni,hrac2.jmeno,hrac2.datum_narozeni 
     from hrac as hrac2  
     where year(getdate())-year(hrac2.datum_narozeni) >18 or month(hrac2.datum_narozeni) between 7 and 12
 )


 --SKUPINA 4
 /*4;1;10; 
 Vypište poèet družstev v každé lize v sezonì 2015/2016*/
 
 select druzstvo_liga.liga_id,count(*) pocet
 from druzstvo_liga
 where sezona_platnosti = '2015/2016' 
 group by liga_id
  
 
 /*4;2;95;
 Vypište prùmìrný mìsíc narození a poèet hráèù narozených v témže roce*/
 select year(datum_narozeni) as rok,count(datum_narozeni) as pocet,avg(month(datum_narozeni)) prumer
 from hrac
 group by year(datum_narozeni)
 /*4;3;80;
 Vypište poèet hráèù každého družstva*/
 select d.druzstvo_id,
 ( 
 select count(*) pocet
 from hrac_druzstvo
 group by hrac_druzstvo.druzstvo_id
 having hrac_druzstvo.druzstvo_id = d.druzstvo_id
 ) pocet
 from druzstvo d
 /*4;4;17;
 Vypište oddíly,které mìly v sezonì 2015/2016  alespoò dvì družstva*/
 select oddil_id,count(*) pocet
 from druzstvo
 where sezona_existence = '2015/2016'
 group by oddil_id
 having count(*) >=2

 --SKUPINA 5
 /*5;1;247;
 Vypište seznam zápasù,kde hrála žena*/

 select z.hrac_id1,z.hrac_id2,z.skore
 from zapas z
 join hrac h1 on h1.hrac_id = z.hrac_id1
 join hrac h2 on h2.hrac_id = z.hrac_id2
 where h1.prijmeni like '%ová' or h2.prijmeni like '%ová'

 /*5;2;247;
 Vypište seznam zápasù,kde hrála žena*/
 select z.hrac_id1,z.hrac_id2,z.skore
 from zapas z
 where z.hrac_id1 in
 (
	select hr.hrac_id
	from hrac hr
	where hr.prijmeni like '%ová'

 )
 or z.hrac_id2 in
 (
	select hr.hrac_id
	from hrac hr
	where hr.prijmeni like '%ová'

 )

  /*5;3;321;
 Vypište,kolik sezón každý hráè odehrál*/
select hr.hrac_id,count(hd.sezona_platnosti) sezony
from hrac hr
left join hrac_druzstvo hd on hr.hrac_id = hd.hrac_id  
group by hr.hrac_id


 /*5;4;25;
 Vypište poèet družstev v oddílech,kde byla aktivní družstva v sezonì 2015/2016 */
 select o.nazev,count(*) pocet
 from oddil o
 left join druzstvo dr on dr.oddil_id = o.oddil_id 
 where sezona_existence = '2015/2016'
 group by o.nazev




--SKUPINA 6
/*6;1;321;
Vypište poèet zápasù každého hráèe v sezonì 2014/2015*/
select summary.prijmeni,summary.jmeno,summary.mc1+summary.mc2 total
from(
	select hr.prijmeni,hr.jmeno ,
	(
		select  count(*) matches
		from zapas z
		where z.hrac_id1 = hr.hrac_id and z.sezona = '2014/2015'
	)mc1,
	(
		select  count(*) matches
		from zapas z
		where z.hrac_id2 = hr.hrac_id and z.sezona = '2014/2015'
	)mc2
	from
	hrac hr
)summary

/*6;2;305;
Vypište celkovou procentuální bilanci každého hráèe (,poèet výher,poèet proher a kolik % zápasù celkem hráè vyhrál). Pøitom ignorujte hráèe,kteøí nehráli žádný zápas.*/
select summary.prijmeni,summary.jmeno,win1+win2 pocet_vyher,lose1+lose2 pocet_proher,
cast(round(100.0*(win1+win2)/(win1+win2+lose1+lose2),2) as numeric(5,2)) bilance
from(
	select hr.prijmeni,hr.jmeno ,
	(
		select  count(*) matches
		from zapas z
		where z.hrac_id1 = hr.hrac_id and substring(z.skore,1,1)=3
	)win1,
	(
		select  count(*) matches
		from zapas z
		where z.hrac_id2 = hr.hrac_id and substring(z.skore,3,1)=3 
	)win2,
	(
		select  count(*) matches
		from zapas z
		where z.hrac_id1 = hr.hrac_id and substring(z.skore,1,1)<3
	)lose1,
	(
		select  count(*) matches
		from zapas z
		where z.hrac_id2 = hr.hrac_id and substring(z.skore,3,1)<3 
	)lose2

	from
	hrac hr
)summary
where win1+win2+lose1+lose2 >0






