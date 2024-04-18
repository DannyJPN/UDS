select * 
from Letadlo
select * 
from Letovy_plan
select * 
from Spolecnost
select * 
from Trasa
select * 
from Pilot

--___________________________2
insert into Spolecnost
(nazev,mesto,ulice,PSC,zeme,telefon)
values
('Czech airlines','Praha', 'Prazska 2', '12000', 'CR', '+420 234 789 111')
insert into Spolecnost
(nazev,mesto,ulice,PSC,zeme,telefon)
values
('Delta', 'Detroit', 'Elm street 55', '15122', 'USA', '+100 900 987 000')
insert into Spolecnost
(nazev,mesto,ulice,PSC,zeme,telefon)
values
('Emirates', 'Dubai', 'Arabic 34', '98000', 'Emirates', '+456 111 123 321')
--_________________________3
insert into Letadlo
(cislo_letadla,typ_letadla,pocet_mist,pocet_motoru,dolet,rok_vyroby,cislo_spolecnosti)
values
('1',  'B737', 100, 4, 20000, 2000,1)
insert into Letadlo
(cislo_letadla,typ_letadla,pocet_mist,pocet_motoru,dolet,rok_vyroby,cislo_spolecnosti)
values
('2',  'A777', 200, 6, 30000, 2008,1)
insert into Letadlo
(cislo_letadla,typ_letadla,pocet_mist,pocet_motoru,dolet,rok_vyroby,cislo_spolecnosti)
values
('3',  'B747', 400, 8, 25000, 2002,3)
--______________________________4
alter table Spolecnost
add vlastnik nvarchar(30)
--____________________________5
alter table Letadlo
add posledni_oprava date null 
update Letadlo SET posledni_oprava = '2018-01-02' where cislo_letadla = 1
update Letadlo SET posledni_oprava = '2018-03-02' where cislo_letadla = 2
update Letadlo SET posledni_oprava = '2018-04-02' where cislo_letadla = 3
alter table Letadlo
alter column posledni_oprava date not null 
--____________________________6
alter table Trasa add  check(vzdalenost >50 and vzdalenost <20000)
 --____________________________7
  exec sp_rename  'Spolecnost.Spolecnost.stat' , 'stat'
 --___________________________8-10
 create table Pilot
 (
 id integer not null identity primary key,
 jmeno nvarchar(20),
 prijmeni nvarchar(50),
 pohlavi char(1) check(pohlavi = 'M' or pohlavi = 'Z' ),
 pocet_hodin integer check (pocet_hodin>100)
 )
 --____________________________11
 insert into Pilot
(jmeno,prijmeni,pohlavi,pocet_hodin)
values
('Jan',  'Novák', 'M', 800)
 insert into Pilot
(jmeno,prijmeni,pohlavi,pocet_hodin)
values
('Jozef',  'Starý', 'M', 1000)
 insert into Pilot
(jmeno,prijmeni,pohlavi,pocet_hodin)
values
('Chesley',  'Sullenberger', 'M', 8000)
--_______________________________12
alter table Letovy_plan add id_pilota int not null
alter table Letovy_plan add foreign key (id_pilota) references Pilot(id)