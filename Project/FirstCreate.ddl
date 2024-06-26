-- Generated by Oracle SQL Developer Data Modeler 18.3.0.268.1156
--   at:        2018-12-06 22:21:46 CET
--   site:      SQL Server 2012
--   type:      SQL Server 2012



CREATE TABLE druzstvo 
    (
    id      INTEGER NOT NULL,
    nazev   nvarchar (80) NOT NULL , 
     sezona NCHAR (9) NOT NULL , 
     Oddil_ID INTEGER NOT NULL ) go

ALTER TABLE Druzstvo ADD constraint druzstvo_pk PRIMARY KEY CLUSTERED (ID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) go

CREATE TABLE druzstvo_liga 
    (
    id            INTEGER NOT NULL,
    dru�stvo_id   INTEGER NOT NULL,
    liga_id       NCHAR(5) NOT NULL,
    sezona        nvarchar
(9) )
GO

ALTER TABLE Druzstvo_liga ADD constraint druzstvo_liga_pk PRIMARY KEY CLUSTERED (ID, Dru�stvo_ID, Liga_ID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) go

CREATE TABLE hrac 
    (
    id      INTEGER NOT NULL,
    jmeno   nvarchar (50) NOT NULL , 
     prijmeni NVARCHAR (50) NOT NULL , 
     datum_narozeni datetime NOT NULL ) go

ALTER TABLE Hrac ADD constraint hrac_pk PRIMARY KEY CLUSTERED (ID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) go

CREATE TABLE hrac_druzstvo 
    (
    id            INTEGER NOT NULL,
    hr��_id       INTEGER NOT NULL,
    dru�stvo_id   INTEGER NOT NULL,
    sezona        nvarchar (9) NOT NULL , 
     Typ NVARCHAR (10) NOT NULL ) go

ALTER TABLE Hrac_druzstvo ADD constraint hrac_druzstvo_pk PRIMARY KEY CLUSTERED (ID, Hr��_ID, Dru�stvo_ID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) go

CREATE TABLE liga 
    (
    id      NCHAR(5) NOT NULL,
    nazev   nvarchar (30) NOT NULL ) go

ALTER TABLE Liga ADD constraint liga_pk PRIMARY KEY CLUSTERED (ID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) go

CREATE TABLE oddil 
    (
    id      INTEGER NOT NULL,
    nazev   nvarchar (80) NOT NULL , 
     okres NVARCHAR (30) NOT NULL , 
     kraj NVARCHAR (30) NOT NULL , web nvarchar(100) )
GO

ALTER TABLE Oddil ADD constraint oddil_pk PRIMARY KEY CLUSTERED (ID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) go

CREATE TABLE zapas 
    (
    id       INTEGER NOT NULL,
    skore    NCHAR(3) NOT NULL,
    sezona   nvarchar (9) NOT NULL , 
     Hrac_ID INTEGER NOT NULL , 
     Hrac_ID2 INTEGER NOT NULL ) go

ALTER TABLE Zapas ADD constraint zapas_pk PRIMARY KEY CLUSTERED (ID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) go

ALTER TABLE Druzstvo_liga
    ADD CONSTRAINT druzstvo_liga_dru�stvo_fk FOREIGN KEY ( dru�stvo_id )
        REFERENCES druzstvo ( id )
ON DELETE NO ACTION 
    ON UPDATE no action go

ALTER TABLE Druzstvo_liga
    ADD CONSTRAINT druzstvo_liga_liga_fk FOREIGN KEY ( liga_id )
        REFERENCES liga ( id )
ON DELETE NO ACTION 
    ON UPDATE no action go

ALTER TABLE Druzstvo
    ADD CONSTRAINT druzstvo_oddil_fk FOREIGN KEY ( oddil_id )
        REFERENCES oddil ( id )
ON DELETE NO ACTION 
    ON UPDATE no action go

ALTER TABLE Hrac_druzstvo
    ADD CONSTRAINT hrac_druzstvo_dru�stvo_fk FOREIGN KEY ( dru�stvo_id )
        REFERENCES druzstvo ( id )
ON DELETE NO ACTION 
    ON UPDATE no action go

ALTER TABLE Hrac_druzstvo
    ADD CONSTRAINT hrac_druzstvo_hr��_fk FOREIGN KEY ( hr��_id )
        REFERENCES hrac ( id )
ON DELETE NO ACTION 
    ON UPDATE no action go

ALTER TABLE Zapas
    ADD CONSTRAINT zapas_hrac_fk FOREIGN KEY ( hrac_id )
        REFERENCES hrac ( id )
ON DELETE NO ACTION 
    ON UPDATE no action go

ALTER TABLE Zapas
    ADD CONSTRAINT zapas_hrac_fkv2 FOREIGN KEY ( hrac_id2 )
        REFERENCES hrac ( id )
ON DELETE NO ACTION 
    ON UPDATE no action go

ALTER TABLE Druzstvo_liga
    ADD CONSTRAINT druzstvo_liga_dru�stvo_fk FOREIGN KEY ( dru�stvo_id )
        REFERENCES druzstvo ( id )
ON DELETE NO ACTION 
    ON UPDATE no action go

ALTER TABLE Druzstvo_liga
    ADD CONSTRAINT druzstvo_liga_liga_fk FOREIGN KEY ( liga_id )
        REFERENCES liga ( id )
ON DELETE NO ACTION 
    ON UPDATE no action go

ALTER TABLE Druzstvo
    ADD CONSTRAINT druzstvo_oddil_fk FOREIGN KEY ( oddil_id )
        REFERENCES oddil ( id )
ON DELETE NO ACTION 
    ON UPDATE no action go

ALTER TABLE Hrac_druzstvo
    ADD CONSTRAINT hrac_druzstvo_dru�stvo_fk FOREIGN KEY ( dru�stvo_id )
        REFERENCES druzstvo ( id )
ON DELETE NO ACTION 
    ON UPDATE no action go

ALTER TABLE Hrac_druzstvo
    ADD CONSTRAINT hrac_druzstvo_hr��_fk FOREIGN KEY ( hr��_id )
        REFERENCES hrac ( id )
ON DELETE NO ACTION 
    ON UPDATE no action go

ALTER TABLE Zapas
    ADD CONSTRAINT zapas_hrac_fk FOREIGN KEY ( hrac_id )
        REFERENCES hrac ( id )
ON DELETE NO ACTION 
    ON UPDATE no action go

ALTER TABLE Zapas
    ADD CONSTRAINT zapas_hrac_fkv2 FOREIGN KEY ( hrac_id2 )
        REFERENCES hrac ( id )
ON DELETE NO ACTION 
    ON UPDATE no action go



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                             7
-- CREATE INDEX                             0
-- ALTER TABLE                             21
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE DATABASE                          0
-- CREATE DEFAULT                           0
-- CREATE INDEX ON VIEW                     0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE ROLE                              0
-- CREATE RULE                              0
-- CREATE SCHEMA                            0
-- CREATE SEQUENCE                          0
-- CREATE PARTITION FUNCTION                0
-- CREATE PARTITION SCHEME                  0
-- 
-- DROP DATABASE                            0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
