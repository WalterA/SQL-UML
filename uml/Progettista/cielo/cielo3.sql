--1 Qual e’ la durata media dei voli (media calcolata sulle diverse compagnie)
-- che partono da un aeroporto situato in Italia?
WITH luogo AS (
    SELECT aeroporto AS A, nazione AS N
    FROM luogoaeroporto
    WHERE nazione = 'Italy'
),

par AS (
    SELECT ap.codice AS id, ap.comp AS c, ap.partenza AS p
    FROM ArrPart ap
    JOIN luogo l ON l.A = ap.partenza
)

SELECT v.comp, ROUND(AVG(v.durataminuti),2) AS avg_durataminuti
FROM volo v
JOIN par ON par.id = v.codice
GROUP BY v.comp;

--2 Quali sono le compagnie che operano voli con durata media maggiore della durata media di tutti i voli?
 with m as (
 select avg(durataminuti) as dm
 from volo
 ),
 c as (
	SELECT comp,(ROUND (avg(durataminuti),2)) as durata_minuti
	FROM volo
	group by comp
 )
 select c.comp , c.durata_minuti
 from m , c
 where c.durata_minuti > m.dm

--3) Quali sono le citta ’ dove i l numero totale di voli in arrivo e’ maggiore
-- del numero medio dei voli in arrivo per ogni citta ’?
WITH VoliInArrivo AS (
    SELECT luogoaeroporto.citta, COUNT(arrpart.arrivo) AS numero_voli
    FROM arrpart
    JOIN luogoaeroporto ON arrpart.arrivo = luogoaeroporto.aeroporto
    GROUP BY luogoaeroporto.citta
),
MediaVoli AS (
    SELECT AVG(numero_voli) AS media_voli
    FROM VoliInArrivo
)
SELECT citta , numero_voli
FROM VoliInArrivo
WHERE numero_voli > (SELECT media_voli FROM MediaVoli);

--4 Quali sono le compagnie aeree che hanno voli in partenza da aeroporti in
 --I t a l i a con una durata media inferiore alla durata media di tutti i voli in partenza da aeroporti in Italia ?
 WITH luogo AS (
    SELECT aeroporto AS A
    FROM luogoaeroporto
    WHERE nazione = 'Italy'
),

durata_media_compagnie AS (
    SELECT ap.comp, AVG(v.durataminuti) AS media_durata
    FROM arrpart ap
    JOIN luogo l ON l.A = ap.partenza
    JOIN volo v ON ap.codice = v.codice
    GROUP BY ap.comp
),

media_durata_totale AS (
    SELECT AVG(v.durataminuti) AS media_totale
    FROM arrpart ap
    JOIN volo v ON ap.codice = v.codice 
    WHERE ap.partenza IN (SELECT A FROM luogo)
)

SELECT dc.comp,dc.media_durata
FROM durata_media_compagnie dc, media_durata_totale mt
WHERE dc.media_durata < mt.media_totale;
--5 Quali sono le citta ’ i cui voli in arrivo hanno una durata media che
-- d i f f eri sce di piu ’ di una deviazione standard dalla durata media di tutti i
-- v oli ? Restituire citta ’ e durate medie dei voli in arrivo .
WITH media_totale AS (
    SELECT AVG(v.durataminuti) AS media_durata, STDDEV(v.durataminuti) AS deviazione_std
    FROM volo v
),

media_durata_citta AS (
    SELECT la.citta, AVG(v.durataminuti) AS media_durata
    FROM arrpart ap
    JOIN luogoaeroporto la ON ap.arrivo = la.aeroporto
    JOIN volo v ON ap.codice = v.codice 
    GROUP BY la.citta
)

SELECT c.citta, c.media_durata
FROM media_durata_citta c
JOIN media_totale m ON 
    (c.media_durata > m.media_durata + m.deviazione_std OR 
     c.media_durata < m.media_durata - m.deviazione_std);

 --6 Quali sono le nazioni che hanno i l maggior numero di citta ’ dalle quali
 --partono voli diretti in altre nazioni?
WITH citta_con_voli AS (
    SELECT DISTINCT la.citta, la.nazione
    FROM arrpart ap
    JOIN luogoaeroporto la ON ap.partenza = la.aeroporto
    WHERE la.nazione <> all(SELECT DISTINCT nazione FROM luogoaeroporto WHERE aeroporto = ap.arrivo)
)

SELECT nazione, COUNT(DISTINCT citta) AS numero_citta
FROM citta_con_voli
GROUP BY nazione
ORDER BY numero_citta DESC;