-- Quali sono i voli (codice e nome della compagnia) la cui durata supera le 3 ore?
select v.codice, v.comp
from volo v
where v.durataminuti > 180
-- Quali sono le compagnie che hanno voli che superano le 3 ore?
select distinct v.comp
from volo v
where v.durataminuti > 180;
-- Quali sono i voli (codice e nome della compagnia) che partono dall ’ aeroporto con codice ’CIA’?
"""select distinct v.codice ,v.comp
from volo v, arrpart arr
where arr.partenza = 'CIA' and v.codice = arr.codice"""
select codice, comp 
from arrpart
where  partenza = 'CIA'
--Quali sono le compagnie che hanno voli che arrivano all ’ aeroporto con codice ’FCO’
select distinct arr.comp
from  arrpart arr
where arr.arrivo = 'FCO'
--Quali sono i voli (codice e nome della compagnia) che partono dall ’
-- aeroporto ’FCO’ e arrivano all ’ aeroporto ’JFK’
select arr.codice, arr.comp
from arrpart arr
where arr.arrivo = 'JFK' and arr.partenza ='FCO'
-- Quali sono le compagnie che hanno voli che partono dall ’ aeroporto ’FCO’ e
--atterrano all ’ aeroporto ’JFK’
select distinct arr.comp
from arrpart arr
where arr.arrivo = 'JFK' and arr.partenza ='FCO'
-- Quali sono i nomi delle compagnie che hanno voli diretti dalla citta ’ di
 --’Roma’ alla citta ’ di ’New York ’
select distinct comp
from luogoaeroporto lp, arrpart arr, luogoaeroporto la --arrpart a JOIN luogoareroporto lp ON a.partenza =lp.areroporto
where arr.partenza=lp.aeroporto and la.aeroporto = arr.arrivo and lp.citta ='Roma' and la.citta='New York'

-- Quali sono gli aeroporti (con codice IATA, nome e luogo) nei quali
 --partono voli della compagnia di nome ’MagicFly ’
select distinct arr.partenza, a.nome , la.citta
from arrpart arr , luogoaeroporto la, aeroporto a
where arr.comp='MagicFly' and arr.partenza=a.codice and la.areroporto=arr.partenza

-- Quali sono i voli che partono da un qualunque aeroporto della citta ’ di ’
 --Roma’ e atterrano ad un qualunque aeroporto della citta ’ di ’New York’?
 --Restituire : codice del volo , nome della compagnia , e aeroporti di
 --partenza e arrivo 
select arr.comp ,arr.codice, arr.partenza, arr.arrivo
from arrpart arr, luogoaeroporto lap, luogoaeroporto laa 
where lap.citta = 'Roma' 
	and laa.citta='New York' 
	and arr.partenza=lap.aeroporto 
	and arr.arrivo=laa.aeroporto;
--alternativa
select 
    arr.comp ,
    arr.codice, 
    arr.partenza, 
    arr.arrivo
from arrpart arr
    JOIN luogoaeroporto lap
        ON arr.partenza=lap.aeroporto
    JOIN luogoaeroporto laa
        ON  arr.arrivo=laa.aeroporto
where lap.citta = 'Roma' 
	and laa.citta='New York' 
--Quali sono i possibili piani di volo con esattamente un cambio (utilizzando solo
--voli della stessa compagnia) da un qualunque aeroporto della città di ‘Roma’ ad un
--qualunque aeroporto della città di ‘New York’ ? Restituire: nome della compagnia,
--codici dei voli, e aeroporti di partenza, scalo e arrivo.
select v1.comp, 
    v1.codice, 
    v2.codice , 
    v2.partenza,
    v2.arrivo
from arrpart v1 , arrpart v2, luogoaeroporto lap, luogoaeroporto laa
where v2.partenza=v1.arrivo and v1.comp=v2.comp and v2.arrivo=laa.aeroporto and v1.partenza=lap.aeroporto and lap.citta='Roma' and  laa.citta='New York';
--Quali sono le compagnie che hanno voli che partono dall’aeroporto ‘FCO’, atterrano all’aeroporto ‘JFK’, e di cui si conosce l’anno di fondazione?
select v1.comp
from arrpart v1,compagnia c
where  v1.partenza='FCO' and v1.arrivo='JFK' and v1.comp=c.nome and c.annofondaz is not null
