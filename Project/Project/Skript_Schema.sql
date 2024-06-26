

CREATE TABLE hrac 
    (
    hrac_id      INTEGER NOT NULL  identity primary key,
    jmeno   nvarchar (50) NOT NULL , 
     prijmeni NVARCHAR (50) NOT NULL , 
     datum_narozeni date NOT NULL check (datum_narozeni <= cast(GETDATE()as date)),
     telefon INTEGER check(telefon between 100000000 and 1000000000  ),
     email NVARCHAR (100) check(email like '%@%')
     )
go

CREATE TABLE liga 
    (
    liga_id      NCHAR(5) NOT NULL primary key,
    nazev   nvarchar (30) NOT NULL 
	)
go


CREATE TABLE oddil 
    (
    oddil_id      INTEGER NOT NULL  identity primary key,
    nazev   nvarchar (80) NOT NULL , 
     okres NVARCHAR (30) NOT NULL , 
     kraj NVARCHAR (30) NOT NULL ,
     mesto NVARCHAR (40) NOT NULL,
     adresa NVARCHAR(100), 
     web nvarchar(100) ,
     telefon_jednatele INTEGER check(telefon_jednatele between 100000000 and 1000000000  ) ,
     email_jednatele NVARCHAR (100) check(email_jednatele like '%@%') 
     )
go

create table druzstvo
    (
	druzstvo_id      INTEGER NOT NULL  identity primary key,
    nazev_druzstva   NVARCHAR (80) NOT NULL , 
     sezona_existence NCHAR (9) NOT NULL check (LEN(sezona_existence)=9 and  
     SUBSTRING(sezona_existence,1,4) +1 =  SUBSTRING(sezona_existence,6,4) and 
	 SUBSTRING(sezona_existence,5,1) = '/'),
     oddil_id INTEGER NOT NULL  
    constraint dru_od_fk FOREIGN KEY ( oddil_id)        REFERENCES oddil ( oddil_id) 
    )
go

CREATE TABLE druzstvo_liga 
    (
    prislusnost_id            INTEGER NOT NULL  identity primary key,
    druzstvo_id   INTEGER NOT NULL ,
    liga_id       NCHAR(5) NOT NULL ,
    sezona_platnosti        NCHAR (9) check (LEN(sezona_platnosti)=9 and  
     SUBSTRING(sezona_platnosti,1,4) +1 =  SUBSTRING(sezona_platnosti,6,4)
      and SUBSTRING(sezona_platnosti,5,1) = '/'),
	  constraint dru_li_dru_id_fk FOREIGN KEY ( druzstvo_id)        REFERENCES druzstvo ( druzstvo_id),
	  constraint dru_li_li_id_fk FOREIGN KEY  ( liga_id)        REFERENCES liga ( liga_id)
    )
go




CREATE TABLE hrac_druzstvo 
    (
    prislusnost_id     INTEGER NOT NULL  identity primary key,
    hrac_id       INTEGER NOT NULL ,
    druzstvo_id   INTEGER NOT NULL ,
    sezona_platnosti        nchar (9) NOT NULL check (LEN(sezona_platnosti)=9 and  
     SUBSTRING(sezona_platnosti,1,4) +1 =  SUBSTRING(sezona_platnosti,6,4)
      and SUBSTRING(sezona_platnosti,5,1) = '/'), 
     typ_clenstvi NVARCHAR (10) NOT NULL check(typ_clenstvi = 'pln� start' or typ_clenstvi = 'hostov�n�' ),
      constraint dru_hra_dru_id_fk FOREIGN KEY (druzstvo_id)        REFERENCES druzstvo ( druzstvo_id),
	  constraint dru_hra_hra_id_fk FOREIGN KEY ( hrac_id)        REFERENCES hrac ( hrac_id)
	 ) 
go



CREATE TABLE zapas 
    (
    zapas_id       INTEGER NOT NULL  identity primary key,
    skore    NCHAR(3) NOT NULL check (LEN(skore)=3 and SUBSTRING(skore,2,1) = ':' and SUBSTRING(skore,1,1) between 0 and 3 and SUBSTRING(skore,3,1) between 0 and 3),
    sezona   nvarchar (9) NOT NULL check (LEN(sezona)=9 and  
     SUBSTRING(sezona,1,4) +1 =  SUBSTRING(sezona,6,4)
      and SUBSTRING(sezona,5,1) = '/'), 
     hrac_id1 INTEGER NOT NULL , 
     hrac_id2 INTEGER NOT NULL, 
	  constraint zap_hr1_id_fk FOREIGN KEY ( hrac_id1 )        REFERENCES hrac ( hrac_id),
	 constraint zap_hr2_id_fk FOREIGN KEY ( hrac_id2 )        REFERENCES hrac ( hrac_id)
     ) 
go
	
 

ALTER TABLE hrac_druzstvo    ADD  FOREIGN KEY (druzstvo_id)        REFERENCES druzstvo ( druzstvo_id)   
ALTER TABLE hrac_druzstvo    ADD  FOREIGN KEY ( hrac_id)        REFERENCES hrac ( hrac_id) 
ALTER TABLE zapas    ADD  FOREIGN KEY ( hrac_id1 )        REFERENCES hrac ( hrac_id)    
ALTER TABLE zapas    ADD  FOREIGN KEY ( hrac_id2 )        REFERENCES hrac ( hrac_id)    
ALTER TABLE druzstvo_liga   ADD  FOREIGN KEY ( druzstvo_id)        REFERENCES druzstvo ( druzstvo_id) 
ALTER TABLE druzstvo_liga    ADD FOREIGN KEY ( liga_id)        REFERENCES liga ( liga_id) 
ALTER TABLE druzstvo    ADD  FOREIGN KEY ( oddil_id)        REFERENCES oddil ( oddil_id) 


 
 
 