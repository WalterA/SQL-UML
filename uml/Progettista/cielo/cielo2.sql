--1 Quante sono le compagnie che operano (sia in arrivo che in partenza) nei diversi aeroporti?
SELECT a.codice , a.nome, count(distinct arr.comp)
from aeroporto a, arrpart arr 
where arr.arrivo = a.codice or a.codice=arr.partenza
group by a.codice , a.nome

--2  Quanti sono i voli che partono dall ’aeroporto ’HTR’ e 
--hanno una durata di almeno 100 minuti?
SELECT count(*) as "num_voli"
from arrpart arr, volo v
where arr.partenza = 'HTR' and arr.codice=v.codice and v.durataminuti<=100and arr.comp=v.comp

--3  Quanti sono gli aeroporti sui quali opera la compagnia ’Apitalia ’ , per
--ogni nazione nella quale opera?
select distinct la.nazione , count( arr.codice)
from arrpart arr, luogoaeroporto la
where arr.comp= 'Apitalia'
group by arr.codice, la.nazione

--4) Qual e’ la media, i l massimo e i l minimo della durata dei voli effettuati
-- dalla compagnia ’MagicFly’?
SELECT avg(v.durataminuti), max(v.durataminuti), min(v.durataminuti)
FROM VOLO v
WHERE v.comp = 'MagicFly'

--5) Qual e’ l ’anno di fondazione della compagnia piu’ vecchia che opera in
-- ognuno degli aeroporti?
SELECT 
    a.codice AS codice_aeroporto,
    a.nome AS nome_aeroporto,
    MIN(c.annofondaz) AS anno_fondazione
FROM 
    Aeroporto a, 
    Compagnia c, 
    ArrPart ap
WHERE 
    (ap.arrivo = a.codice OR ap.partenza = a.codice)
    AND ap.comp = c.nome
GROUP BY 
    a.codice, a.nome
ORDER BY 
    a.codice;

-- 6 Quante sono le nazioni (diverse) raggiungibili da ogni nazione tramite uno o più voli?
SELECT la1.nazione AS nazione_partenza, COUNT(DISTINCT la2.nazione) AS nazioni_raggiungibili
FROM arrpart ap
JOIN luogoaeroporto la1 ON ap.partenza = la1.aeroporto
JOIN luogoaeroporto la2 ON ap.arrivo = la2.aeroporto
GROUP BY la1.nazione;
--7  Qual e’ la durata media dei voli che partono da ognuno degli aeroporti?
select a.codice , a.nome , avg(v.durataminuti) as media_durata
from  arrpart ap
join aeroporto a on a.codice = ap.partenza
join volo v ON v.codice = ap.codice 
group by a.nome, a.codice;
--8 Qual e’ la durata complessiva dei voli operati da ognuna delle compagnie fondate a partire dal 1950?
select v.comp as nome , sum(v.durataminuti) as durata_tot
from volo v
join compagnia c on v.comp = c.nome and c.annofondaz > 1950
group by v.comp ;

--9 Quali sono gli aeroporti nei quali operano esattamente due compagnie?
SELECT 
  a.codice, 
  a.nome
FROM 
  aeroporto a
JOIN 
  arrpart ap ON a.codice = ap.partenza OR a.codice = ap.arrivo
GROUP BY 
  a.codice, a.nome
HAVING 
  COUNT(DISTINCT ap.comp) = 2;

-- 10 Quali sono le citta ’ con almeno due aeroporti?
select  la.citta
from luogoaeroporto la
group by la.citta
HAVING 
  COUNT(DISTINCT la.aeroporto) = 2;
-- 11) Qual e’ i l nome delle compagnie i cui voli hanno una durata media maggiore di 6 ore?
select v.comp
from volo v
join compagnia c on c.nome = v.comp
group by v.comp
having avg (durataminuti) > 360;
 --12 Qual e’ i l nome delle compagnie i cui voli hanno tutti una durata
 --maggiore di 100 minuti?
select v.comp
from volo v 
group by v.comp
HAVING 
  MIN(v.durataminuti) > 100;
