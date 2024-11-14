--1) Quali sono gli aeroporti raggiungibili da dall ’ aeroporto ’JFK’ tramite voli diretti e indiretti ?
WITH diretti AS (
    SELECT arrivo
    FROM arrpart
    WHERE partenza = 'JFK'
),
indiretti AS (
    SELECT ap2.arrivo
    FROM arrpart ap1
    JOIN arrpart ap2 ON ap1.arrivo = ap2.partenza
    WHERE ap1.partenza = 'JFK'
)
SELECT arrivo 
FROM diretti
UNION
SELECT arrivo
FROM indiretti;
-- 2) Quali sono le citta ’ raggiungibili con voli diretti e indiretti partendo da Roma
WITH roma AS (
    SELECT aeroporto
    FROM luogoaeroporto
    WHERE citta = 'Roma'
),
diretti AS (
    SELECT la2.citta
    FROM arrpart ap
    JOIN roma r ON r.aeroporto = ap.partenza
    JOIN luogoaeroporto la2 ON ap.arrivo = la2.aeroporto
),
indiretti AS (
    SELECT la2.citta
    FROM arrpart ap1
    JOIN arrpart ap2 ON ap1.arrivo = ap2.partenza
    JOIN roma r ON r.aeroporto = ap1.partenza
    JOIN luogoaeroporto la2 ON ap2.arrivo = la2.aeroporto
)
SELECT citta
FROM diretti
UNION
SELECT citta
FROM indiretti;
