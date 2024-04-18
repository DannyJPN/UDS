-- Generated by Oracle SQL Developer Data Modeler 4.0.3.853
--   at:        2016-09-21 10:30:16 CEST
--   site:      SQL Server 2008
--   type:      SQL Server 2008




CREATE
  TABLE Letadlo
  (
    cislo_letadla                CHAR (20) NOT NULL ,
    typ_letadla                  VARCHAR (150) NOT NULL ,
    pocet_mist                   INTEGER NOT NULL ,
    pocet_motoru                 INTEGER NOT NULL ,
    dolet                        INTEGER NOT NULL ,
    rok_vyroby                   INTEGER NOT NULL ,
    cislo_spolecnosti 			INTEGER NOT NULL ,
    CONSTRAINT Letadlo_PK PRIMARY KEY CLUSTERED (cislo_letadla)
WITH
  (
    ALLOW_PAGE_LOCKS = ON ,
    ALLOW_ROW_LOCKS  = ON
  )
  ON "default"
  )
  ON "default"
GO

CREATE
  TABLE Letovy_plan
  (
    Letadlo_cislo_letadla CHAR (20) NOT NULL ,
    Trasa_cislo_trasy     INTEGER NOT NULL ,
    CONSTRAINT Letovy_plan_PK PRIMARY KEY CLUSTERED (Letadlo_cislo_letadla,
    Trasa_cislo_trasy)
WITH
  (
    ALLOW_PAGE_LOCKS = ON ,
    ALLOW_ROW_LOCKS  = ON
  )
  ON "default"
  )
  ON "default"
GO

CREATE
  TABLE Spolecnost
  (
    cislo_spolecnosti INTEGER NOT NULL IDENTITY NOT FOR REPLICATION ,
    nazev             VARCHAR (150) NOT NULL ,
    mesto             VARCHAR (100) NOT NULL ,
    ulice             VARCHAR (100) NOT NULL ,
    PSC               CHAR (5) NOT NULL ,
    zeme              VARCHAR (50) NOT NULL ,
    telefon           VARCHAR (16) NOT NULL ,
    CONSTRAINT Spolecnost_PK PRIMARY KEY CLUSTERED (cislo_spolecnosti)
WITH
  (
    ALLOW_PAGE_LOCKS = ON ,
    ALLOW_ROW_LOCKS  = ON
  )
  ON "default"
  )
  ON "default"
GO

CREATE
  TABLE Trasa
  (
    cislo_trasy    INTEGER NOT NULL IDENTITY NOT FOR REPLICATION ,
    START          VARCHAR (200) NOT NULL ,
    cil            VARCHAR (200) NOT NULL ,
    vzdalenost     INTEGER NOT NULL ,
    mezipristani   INTEGER NOT NULL ,
    pocet_pasazeru INTEGER ,
    CONSTRAINT Trasa_PK PRIMARY KEY CLUSTERED (cislo_trasy)
WITH
  (
    ALLOW_PAGE_LOCKS = ON ,
    ALLOW_ROW_LOCKS  = ON
  )
  ON "default"
  )
  ON "default"
GO

ALTER TABLE Letovy_plan
ADD CONSTRAINT FK_ASS_1 FOREIGN KEY
(
Letadlo_cislo_letadla
)
REFERENCES Letadlo
(
cislo_letadla
)
ON
DELETE
  NO ACTION ON
UPDATE NO ACTION
GO

ALTER TABLE Letovy_plan
ADD CONSTRAINT FK_ASS_2 FOREIGN KEY
(
Trasa_cislo_trasy
)
REFERENCES Trasa
(
cislo_trasy
)
ON
DELETE
  NO ACTION ON
UPDATE NO ACTION
GO

ALTER TABLE Letadlo
ADD CONSTRAINT Letadlo_Spolecnost_FK FOREIGN KEY
(
 cislo_spolecnosti
)
REFERENCES Spolecnost
(
cislo_spolecnosti
)
ON
DELETE
  NO ACTION ON
UPDATE NO ACTION
GO


-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                             4
-- CREATE INDEX                             0
-- ALTER TABLE                              3
-- CREATE VIEW                              0
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
-- CREATE PARTITION FUNCTION                0
-- CREATE PARTITION SCHEME                  0
-- 
-- DROP DATABASE                            0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
