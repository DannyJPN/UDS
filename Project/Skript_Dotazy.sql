--SKUPINA 1
/*1;1;80;
Vypi�te seznam jmen v�ech dru�stev*/
select nazev_druzstva
from druzstvo

/*1;2;29;
Vypi�te webov� str�nky odd�l� se�azen�ch sestupn�*/
select web
from oddil
order by web 

/*1;3;321;
Vypi�te seznam hr��� se�azen�ch podle V�KU sestupn�. */

select prijmeni,jmeno,datum_narozeni,cast (
 year(GETDATE())-year(datum_narozeni)
+(month(GETDATE())-month(datum_narozeni))/12.0
+(day(GETDATE())-day(datum_narozeni))/365.0   as int) vek
from hrac
order by vek desc

/*1;4;321; 
Vypi�te cel� jm�na v�ech hr���*/
select  CONCAT(prijmeni,' ',jmeno) as cele_jmeno
from hrac 

--SKUPINA 2
/*2;1;408; 
Vypi�te seznam z�pas� sezony 2015/2016,kde jeden z hr��� nevyhr�l ��dn� set*/
select hrac_id1,hrac_id2,skore
from zapas
where sezona = '2015/2016' and (substring(skore,1,1) = 0 or substring(skore,3,1) = 0) 

/*2;2;237;
Vypi�te z�pasy odehran� v sezon� 2014/2015*/
select hrac_id1,hrac_id2,skore 
from zapas
where sezona = '2014/2015'  

/*2;3;278; 
Vypi�te v�echny hr��e,kte�� jsou-nebo se letos stanou-plnolet�mi*/
select prijmeni,jmeno
from hrac
where NOT (Year(getdate()) - year(datum_narozeni) <18)

/*2;4;30;
Vypi�te v�echny hr��ky*/
select prijmeni,jmeno
from hrac
where prijmeni like '%ov�'

--SKUPINA 3
/*3;1;24;  
Vypi�te hr��e,kte�� byli 1.ledna leto�n�ho roku nezletil� a byli narozeni v prvn� polovin� roku */
select     hrac.prijmeni,hrac.jmeno,hrac.datum_narozeni
from  hrac
where exists 
(
    select * 
	from hrac as hrac2  
	where year(getdate())-year(hrac2.datum_narozeni) <=18 and month(hrac2.datum_narozeni) between 1 and 6
    and hrac2.hrac_id = hrac.hrac_id
)


/*3;2;24;  Vypi�te hr��e,kte�� byli 1.ledna leto�n�ho roku nezletil� a byli narozeni v prvn� polovin� roku */
select hrac.prijmeni,hrac.jmeno,hrac.datum_narozeni
from  hrac
where hrac.hrac_id in 
(
    select hrac2.hrac_id from hrac as hrac2 
	where year(getdate())-year(hrac2.datum_narozeni) <=18 and month(hrac2.datum_narozeni) between 1 and 6
)

/*3;3;24;
Vypi�te hr��e,kte�� byli 1.ledna leto�n�ho roku nezletil� a byli narozeni v prvn� polovin� roku */
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
Vypi�te hr��e,kte�� byli 1.ledna leto�n�ho roku nezletil� a byli narozeni v prvn� polovin� roku */
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
 Vypi�te po�et dru�stev v ka�d� lize v sezon� 2015/2016*/
 
 select druzstvo_liga.liga_id,count(*) pocet
 from druzstvo_liga
 where sezona_platnosti = '2015/2016' 
 group by liga_id
  
 
 /*4;2;95;
 Vypi�te pr�m�rn� m�s�c narozen� a po�et hr��� narozen�ch v t�m�e roce*/
 select year(datum_narozeni) as rok,count(datum_narozeni) as pocet,avg(month(datum_narozeni)) prumer
 from hrac
 group by year(datum_narozeni)
 /*4;3;80;
 Vypi�te po�et hr��� ka�d�ho dru�stva*/
 select d.druzstvo_id,
 ( 
 select count(*) pocet
 from hrac_druzstvo
 group by hrac_druzstvo.druzstvo_id
 having hrac_druzstvo.druzstvo_id = d.druzstvo_id
 ) pocet
 from druzstvo d
 /*4;4;17;
 Vypi�te odd�ly,kter� m�ly v sezon� 2015/2016  alespo� dv� dru�stva*/
 select oddil_id,count(*) pocet
 from druzstvo
 where sezona_existence = '2015/2016'
 group by oddil_id
 having count(*) >=2

 --SKUPINA 5
 /*5;1;247;
 Vypi�te seznam z�pas�,kde hr�la �ena*/

 select z.hrac_id1,z.hrac_id2,z.skore
 from zapas z
 join hrac h1 on h1.hrac_id = z.hrac_id1
 join hrac h2 on h2.hrac_id = z.hrac_id2
 where h1.prijmeni like '%ov�' or h2.prijmeni like '%ov�'

 /*5;2;247;
 Vypi�te seznam z�pas�,kde hr�la �ena*/
 select z.hrac_id1,z.hrac_id2,z.skore
 from zapas z
 where z.hrac_id1 in
 (
	select hr.hrac_id
	from hrac hr
	where hr.prijmeni like '%ov�'

 )
 or z.hrac_id2 in
 (
	select hr.hrac_id
	from hrac hr
	where hr.prijmeni like '%ov�'

 )

  /*5;3;321;
 Vypi�te,kolik sez�n ka�d� hr�� odehr�l*/
select hr.hrac_id,count(hd.sezona_platnosti) sezony
from hrac hr
left join hrac_druzstvo hd on hr.hrac_id = hd.hrac_id  
group by hr.hrac_id


 /*5;4;25;
 Vypi�te po�et dru�stev v odd�lech,kde byla aktivn� dru�stva v sezon� 2015/2016 */
 select o.nazev,count(*) pocet
 from oddil o
 left join druzstvo dr on dr.oddil_id = o.oddil_id 
 where sezona_existence = '2015/2016'
 group by o.nazev




--SKUPINA 6
/*6;1;321;
Vypi�te po�et z�pas� ka�d�ho hr��e v sezon� 2014/2015*/
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
Vypi�te celkovou procentu�ln� bilanci ka�d�ho hr��e (,po�et v�her,po�et proher a kolik % z�pas� celkem hr�� vyhr�l). P�itom ignorujte hr��e,kte�� nehr�li ��dn� z�pas.*/
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






