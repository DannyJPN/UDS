--jednořádkové komentáře budou při zpracování ignorovány

--SKUPINA 1
/*1;1;24;
Výpis všech záznamů tabulky Orchestr seřazených podle názvu.*/
SELECT *
FROM Orchestr
ORDER BY nazev

/*1;2;103;
Výpis seznamu všech koncertů seřazených podle roku uskutečnění.*/
SELECT nazev, CONVERT(date, termin) [datum], idOr [orchestr], cena, delka, idKS [koncertni sal] 
FROM Koncert 
ORDER BY YEAR(termin) DESC

/*1;3;1;
Vypíše průměrnou cenu všech koncertů.*/
SELECT AVG(cena) [prumerna_cena]
FROM Koncert

/*1;4;1;
Vypíše délku nejkratší skladby v minutách.*/
SELECT MIN(delka) [delka]
FROM Skladba

--SKUPINA 2
/*2;1;13;
Výpis koncertů delších než 2 hodiny, které nestojí více než 150 a méně než 350.*/
SELECT idK, nazev, delka, cena
FROM Koncert
WHERE delka > 120 AND (cena <= 150 OR cena >= 350)

/*2;2;14;
Výpis koncertů kratších než jedna hodina, které nestojí více než 150 včetně a méně než 350 včetně.*/
SELECT idK, nazev, delka, cena
FROM koncert
WHERE delka < 60 AND cena NOT IN(150, 350)

/*2;3;13;
Výpis příjmení začínajících na 'Pr' a končících na 'ová'.*/
SELECT DISTINCT prijmeni
FROM Osoba
WHERE prijmeni LIKE 'Pr%ová'
ORDER BY prijmeni

/*2;4;3; 
Výpis koncertů v koncertním sále s identifikačním číslem 6 a jejich délky v hodinách zaokrouhlené na nejbližší vyšší hodnotu.*/
SELECT nazev, CEILING(delka / 60.0) [delka v hodinach]
FROM Koncert
WHERE idKS = 6

--SKUPINA 3
/*3;1;8;Výpis všech koncertních sálů, ve kterých se neodehrávaly žádné koncerty.*/
SELECT idKS
FROM KoncertniSal
EXCEPT (SELECT idKS FROM Koncert)

/*3;2;8;Výpis všech koncertních sálů, ve kterých se neodehrávaly žádné koncerty.*/
SELECT idKS
FROM KoncertniSal KS
WHERE NOT EXISTS (SELECT idKS FROM Koncert K WHERE K.idKS = KS.idKS)

/*3;3;8;Výpis všech koncertních sálů, ve kterých se neodehrávaly žádné koncerty.*/
SELECT idKS
FROM KoncertniSal KS
WHERE idKS != ALL (SELECT idKS FROM Koncert K)

/*3;4;8;Výpis všech koncertních sálů, ve kterých se neodehrávaly žádné koncerty.*/
SELECT idKS
FROM KoncertniSal KS
WHERE idKS NOT IN (SELECT idKS FROM Koncert K)

--SKUPINA 4
/*4;1;1;
Vypíše průměrnou cenu všech koncertů.*/
SELECT AVG(cena) 
FROM Koncert

/*4;2;25;
Vypíše jméno a příjmení skladatele a počet skladeb, které napsal.*/
SELECT jmeno, prijmeni, COUNT(*) as [pocet_skladeb]
FROM Osoba Os
JOIN NAPSAL N ON Os.idOs = N.idOs
GROUP BY Os.idOs, jmeno, prijmeni

/*4;3;103;
Vypíše identifikační číslo a procentuální podíl počtu prodaných vstupenek a kapacity koncertního sálu pro všechny koncerty.
Výpis je seřazen podle tohoto podílu vzestupně.*/
SELECT k.idK, ROUND((COUNT(*) / (CAST (KS.kapacita AS float)) * 100),2) AS [procento_prodanych_vstupenek]
FROM Koncert K
JOIN VSTUPENKA V ON V.idK = K.idK
JOIN KoncertniSal KS ON K.idKS = KS.idKS
GROUP BY K.idK, KS.kapacita
ORDER BY [procento_prodanych_vstupenek]

/*4;4;9;
Vypíše názvy všech orchestrů a celkový počet prodaných vstupenek na jejich koncerty, jestli je tento počet větší než 500.
Výpis je seřazen podle tohoto počtu sestupně.*/
SELECT O.nazev, COUNT(*) [pocet_prodanych_vstupenek]
FROM Orchestr O
JOIN Koncert K ON K.idOr = O.idOr
JOIN VSTUPENKA V ON V.idK = K.idK
GROUP BY O.idOr, O.nazev
HAVING COUNT(*) > 500
ORDER BY COUNT(*) DESC
 
--SKUPINA 5
/*5;1;46;
Výpis všech koncertních sálů, ve kterých se uskutečnil alespoň jeden koncert.*/
SELECT DISTINCT KS.idKS 
FROM KoncertniSal KS 
JOIN Koncert K ON K.idKS = KS.idKS

/*5;2;46;
Výpis všech koncertních sálů, ve kterých se uskutečnil alespoň jeden koncert.*/
SELECT KS.idKS 
FROM KoncertniSal KS 
WHERE KS.idKS IN (SELECT K.idKS from Koncert K)

/*
5;3;54;
Výpis všech koncertních sálů a počtu koncertů uskutečněných v těchto koncertních sálech. 
Výpis bude obsahovat i koncertní sály, ve kterých se zatím neuskutečnil žádný koncert.*/
SELECT KS.mesto, KS.nazev, COUNT(K.idK) [pocet_koncertu]
FROM KoncertniSal KS 
LEFT JOIN Koncert K ON K.idKS = KS.idKS
GROUP BY KS.idKS, KS.nazev, KS.mesto

/*5;4;24;
Výpis všech orchestrů a počtů členů těchto orchestrů mladších 25 let.*/
SELECT Orch.nazev, COUNT(Os.idOs) [pocet_clenu_mladsich_25_let]
FROM Orchestr Orch
LEFT JOIN Osoba Os ON Os.idOr = Orch.idOr 
WHERE datediff(year,Os.datumNarozeni,getdate()) < 25
GROUP BY Orch.idOr, Orch.nazev


--SKUPINA 6
/*6;1;24;
Výpis všech orchestrů a jejich celkové tržby, 
která se počítá jako součet součinů počtů zakoupených vstupenek a cen koncertů jednotlivých orchestrů.*/

SELECT Orch.nazev,
(
	SELECT SUM(t.pocet_vstupenek * t.cena)
	FROM
	(
		SELECT K.cena,
		(
			SELECT COUNT(*)
			FROM Koncert K1
			JOIN VSTUPENKA V1 ON V1.idK = K1.idK
			WHERE K1.idK = K.idK
		) [pocet_vstupenek]
		FROM Orchestr Orch1
		JOIN Koncert K ON K.idOr = Orch1.idOr
		WHERE Orch.idOr = Orch1.idOr
	) t
) [celkova_trzba]
FROM Orchestr Orch

/*6;2;421;
Vypíše jméno, příjmení a počet zakoupených vstupenek pro všechny osoby, které tento počet mají větší než průměrný.*/

SELECT Os.jmeno, Os.prijmeni, COUNT(*) [pocet_zakoupenych_vstupenek]
FROM Osoba Os
JOIN VSTUPENKA V ON V.idOs = Os.idOs
GROUP BY Os.idOs, Os.jmeno, Os.prijmeni
HAVING COUNT(*) >	ALL(
						SELECT AVG(t.pocet_zakoupenych_vstupenek) [prumer]
						FROM
						(		
							SELECT COUNT(*) [pocet_zakoupenych_vstupenek]
							FROM Osoba Os2
							JOIN VSTUPENKA V2 ON V2.idOs = Os2.idOs
							GROUP BY Os2.idOs
						)t
					)
