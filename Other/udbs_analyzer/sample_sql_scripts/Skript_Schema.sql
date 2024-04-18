
CREATE TABLE Funkce
    (
     idF INTEGER NOT NULL ,
     nazev NVARCHAR (32) NOT NULL
    )
    ON "default"
GO

ALTER TABLE Funkce ADD CONSTRAINT Funkce_PK PRIMARY KEY CLUSTERED (idF)
     WITH (
     ALLOW_PAGE_LOCKS = ON ,
     ALLOW_ROW_LOCKS = ON )
     ON "default"
    GO

CREATE TABLE HistorieFunkci
    (
     idHF INTEGER NOT NULL ,
     idF INTEGER NOT NULL ,
     idOs INTEGER NOT NULL ,
     datumOd DATE NOT NULL ,
     datumDo DATE
    )
    ON "default"
GO

ALTER TABLE HistorieFunkci ADD CONSTRAINT HistorieFunkci_PK PRIMARY KEY CLUSTERED (idHF)
     WITH (
     ALLOW_PAGE_LOCKS = ON ,
     ALLOW_ROW_LOCKS = ON )
     ON "default"
    GO

CREATE TABLE Koncert
    (
     idK INTEGER NOT NULL ,
     termin DATETIME NOT NULL ,
     idOr INTEGER NOT NULL ,
     cena INTEGER ,
     delka INTEGER ,
     nazev NVARCHAR (64) ,
     idKS INTEGER NOT NULL
    )
    ON "default"
GO

ALTER TABLE Koncert ADD CONSTRAINT Koncert_PK PRIMARY KEY CLUSTERED (idK)
     WITH (
     ALLOW_PAGE_LOCKS = ON ,
     ALLOW_ROW_LOCKS = ON )
     ON "default"
    GO

CREATE TABLE KoncertniSal
    (
     idKS INTEGER NOT NULL ,
     mesto NVARCHAR (32) NOT NULL ,
     nazev NVARCHAR (64) NOT NULL ,
     kapacita INTEGER NOT NULL
    )
    ON "default"
GO

ALTER TABLE KoncertniSal ADD CONSTRAINT KoncertniSal_PK PRIMARY KEY CLUSTERED (idKS)
     WITH (
     ALLOW_PAGE_LOCKS = ON ,
     ALLOW_ROW_LOCKS = ON )
     ON "default"
    GO

CREATE TABLE NAPSAL
    (
     idOs INTEGER NOT NULL ,
     idSkl INTEGER NOT NULL
    )
    ON "default"
GO

ALTER TABLE NAPSAL ADD CONSTRAINT NAPSAL_PK PRIMARY KEY CLUSTERED (idOs, idSkl)
     WITH (
     ALLOW_PAGE_LOCKS = ON ,
     ALLOW_ROW_LOCKS = ON )
     ON "default"
    GO

CREATE TABLE Orchestr
    (
     idOr INTEGER NOT NULL ,
     nazev NVARCHAR (64) NOT NULL
    )
    ON "default"
GO

ALTER TABLE Orchestr ADD CONSTRAINT Orchestr_PK PRIMARY KEY CLUSTERED (idOr)
     WITH (
     ALLOW_PAGE_LOCKS = ON ,
     ALLOW_ROW_LOCKS = ON )
     ON "default"
    GO

CREATE TABLE Osoba
    (
     idOs INTEGER NOT NULL ,
     jmeno NVARCHAR (32) NOT NULL ,
     prijmeni NVARCHAR (32) NOT NULL ,
     email VARCHAR (64) ,
     datumNarozeni DATE ,
     vedouciSkupiny BIT ,
     idOr INTEGER ,
     idF INTEGER
    )
    ON "default"
GO

ALTER TABLE Osoba ADD CONSTRAINT Osoba_PK PRIMARY KEY CLUSTERED (idOs)
     WITH (
     ALLOW_PAGE_LOCKS = ON ,
     ALLOW_ROW_LOCKS = ON )
     ON "default"
    GO

CREATE TABLE PROGRAM
    (
     idK INTEGER NOT NULL ,
     idSkl INTEGER NOT NULL
    )
    ON "default"
GO

ALTER TABLE PROGRAM ADD CONSTRAINT PROGRAM_PK PRIMARY KEY CLUSTERED (idK, idSkl)
     WITH (
     ALLOW_PAGE_LOCKS = ON ,
     ALLOW_ROW_LOCKS = ON )
     ON "default"
    GO

CREATE TABLE REPERTOAR
    (
     idOr INTEGER NOT NULL ,
     idSkl INTEGER NOT NULL
    )
    ON "default"
GO

ALTER TABLE REPERTOAR ADD CONSTRAINT REPERTOAR_PK PRIMARY KEY CLUSTERED (idOr, idSkl)
     WITH (
     ALLOW_PAGE_LOCKS = ON ,
     ALLOW_ROW_LOCKS = ON )
     ON "default"
    GO

CREATE TABLE Skladba
    (
     idSkl INTEGER NOT NULL ,
     nazev NVARCHAR (64) NOT NULL ,
     delka INTEGER NOT NULL
    )
    ON "default"
GO

ALTER TABLE Skladba ADD CONSTRAINT Skladba_PK PRIMARY KEY CLUSTERED (idSkl)
     WITH (
     ALLOW_PAGE_LOCKS = ON ,
     ALLOW_ROW_LOCKS = ON )
     ON "default"
    GO

CREATE TABLE VSTUPENKA
    (
     idOs INTEGER NOT NULL ,
     idK INTEGER NOT NULL
    )
    ON "default"
GO

ALTER TABLE VSTUPENKA ADD CONSTRAINT VSTUPENKA_PK PRIMARY KEY CLUSTERED (idOs, idK)
     WITH (
     ALLOW_PAGE_LOCKS = ON ,
     ALLOW_ROW_LOCKS = ON )
     ON "default"
    GO

ALTER TABLE HistorieFunkci
    ADD CONSTRAINT HistorieFunkci_Funkce_FK FOREIGN KEY
    (
     idF
    )
    REFERENCES Funkce
    (
     idF
    )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
GO

ALTER TABLE HistorieFunkci
    ADD CONSTRAINT HistorieFunkci_Osoba_FK FOREIGN KEY
    (
     idOs
    )
    REFERENCES Osoba
    (
     idOs
    )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
GO

ALTER TABLE Koncert
    ADD CONSTRAINT Koncert_KoncertniSal_FK FOREIGN KEY
    (
     idKS
    )
    REFERENCES KoncertniSal
    (
     idKS
    )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
GO

ALTER TABLE Koncert
    ADD CONSTRAINT Koncert_Orchestr_FK FOREIGN KEY
    (
     idOr
    )
    REFERENCES Orchestr
    (
     idOr
    )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
GO

ALTER TABLE NAPSAL
    ADD CONSTRAINT NAPSAL_Osoba_FK FOREIGN KEY
    (
     idOs
    )
    REFERENCES Osoba
    (
     idOs
    )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
GO

ALTER TABLE NAPSAL
    ADD CONSTRAINT NAPSAL_Skladba_FK FOREIGN KEY
    (
     idSkl
    )
    REFERENCES Skladba
    (
     idSkl
    )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
GO

ALTER TABLE Osoba
    ADD CONSTRAINT Osoba_Funkce_FK FOREIGN KEY
    (
     idF
    )
    REFERENCES Funkce
    (
     idF
    )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
GO

ALTER TABLE Osoba
    ADD CONSTRAINT Osoba_Orchestr_FK FOREIGN KEY
    (
     idOr
    )
    REFERENCES Orchestr
    (
     idOr
    )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
GO

ALTER TABLE PROGRAM
    ADD CONSTRAINT PROGRAM_Koncert_FK FOREIGN KEY
    (
     idK
    )
    REFERENCES Koncert
    (
     idK
    )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
GO

ALTER TABLE PROGRAM
    ADD CONSTRAINT PROGRAM_Skladba_FK FOREIGN KEY
    (
     idSkl
    )
    REFERENCES Skladba
    (
     idSkl
    )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
GO

ALTER TABLE REPERTOAR
    ADD CONSTRAINT REPERTOAR_Orchestr_FK FOREIGN KEY
    (
     idOr
    )
    REFERENCES Orchestr
    (
     idOr
    )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
GO

ALTER TABLE REPERTOAR
    ADD CONSTRAINT REPERTOAR_Skladba_FK FOREIGN KEY
    (
     idSkl
    )
    REFERENCES Skladba
    (
     idSkl
    )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
GO

ALTER TABLE VSTUPENKA
    ADD CONSTRAINT VSTUPENKA_Koncert_FK FOREIGN KEY
    (
     idK
    )
    REFERENCES Koncert
    (
     idK
    )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
GO

ALTER TABLE VSTUPENKA
    ADD CONSTRAINT VSTUPENKA_Osoba_FK FOREIGN KEY
    (
     idOs
    )
    REFERENCES Osoba
    (
     idOs
    )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
GO

ALTER TABLE HistorieFunkci
	WITH CHECK ADD CONSTRAINT CheckDatums
	CHECK (datumDo IS NULL OR datumOd < datumDo)

ALTER TABLE Osoba
	WITH CHECK ADD CONSTRAINT CheckVedouciSkupiny
	CHECK (vedouciSkupiny IS NULL OR vedouciSkupiny = 1 OR vedouciSkupiny = 0)
