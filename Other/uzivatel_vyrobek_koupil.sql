--======================================================
--
-- Author: Radim Baca
-- Create date: 4.8.2014
-- Description: Create a tables database that are used in UDBS lectures
-- License: This code was writtend by Radim Baca and is the property of VSB-TUO 
--          This code MAY NOT BE USED without the expressed written consent of VSB-TUO.
-- Change history:
--
--======================================================

IF OBJECT_ID('dbo.koupil', 'U') IS NOT NULL
  DROP TABLE dbo.koupil
IF OBJECT_ID('dbo.uzivatel', 'U') IS NOT NULL
  DROP TABLE dbo.uzivatel
IF OBJECT_ID('dbo.vyrobek', 'U') IS NOT NULL
  DROP TABLE dbo.vyrobek


create table uzivatel (
	login varchar(10) primary key,
	rok_narozeni int not null,
	mesto varchar(30)
)

create table vyrobek (
	vID int primary key,
	jmeno varchar(30) not null,
	aktualni_cena int not null
)
	
create table koupil (
	login varchar(10) references uzivatel,
	vID int references vyrobek,
	rok int,
	cena int,
	primary key(login, vID, rok)
)

insert into uzivatel values ('kasa', 1981, 'Ostrava');
insert into uzivatel values ('malta', 1985, 'Opava');
insert into uzivatel values ('kuchta', 1996, 'Olomouc');
insert into uzivatel values ('stelar', 1994, 'Ostrava');
insert into uzivatel values ('pepik', 1991, 'Praha');
insert into uzivatel values ('rychlarota', 1984, 'Brno');
insert into uzivatel values ('vinetu', 1976, 'Zlin');
insert into uzivatel values ('ruprt', 1983, 'Praha');
insert into uzivatel values ('knedlik', 1977, 'Brno');

insert into vyrobek values (1, 'lampa', 1500);
insert into vyrobek values (2, 'sekacka', 2499);
insert into vyrobek values (3, 'pila', 6222);
insert into vyrobek values (4, 'klavesnice', 100);
insert into vyrobek values (5, 'sluchatka', 399);
insert into vyrobek values (6, 'sroubovak', 380);
insert into vyrobek values (7, 'stolicka', 299);
insert into vyrobek values (8, 'hlina', 89);
insert into vyrobek values (9, 'chomout', 785);

insert into koupil values ('kasa', 1, 2009, 1450);
insert into koupil values ('kasa', 7, 2009, 320);
insert into koupil values ('kasa', 1, 2010, 1430);
insert into koupil values ('kasa', 4, 2010, 99);
insert into koupil values ('malta', 1, 2009, 1460);
insert into koupil values ('malta', 1, 2010, 1555);
insert into koupil values ('stelar', 3, 2012, 6100);
insert into koupil values ('pepik', 1, 2009, 1470);
insert into koupil values ('pepik', 1, 2008, 1410);
insert into koupil values ('pepik', 8, 2003, 95);
insert into koupil values ('pepik', 3, 2004, 5980);
insert into koupil values ('rychlarota', 2, 2004, 2600);
insert into koupil values ('rychlarota', 2, 2006, 2650);
insert into koupil values ('rychlarota', 5, 2009, 410);
insert into koupil values ('rychlarota', 7, 2007, 320);
insert into koupil values ('vinetu', 9, 2007, 750);
insert into koupil values ('vinetu', 1, 2007, 1320);
insert into koupil values ('vinetu', 1, 2008, 1410);




