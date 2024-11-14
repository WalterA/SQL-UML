--1 Qual è media e deviazione standard degli stipendi per ogni categoria di strutturati?
select p.posizione, avg(p.stipendio), STDDEV(p.stipendio)
from persona p
group by p.posizione
--2  Quali sono i ricercatori ( tutti gli attributi ) con uno stipendio superiore alla media della loro categoria?
--v1 sbagliata
SELECT p.nome, p.cognome , p.posizione , p.stipendio
FROM persona p
join persona p2 on p2.posizione = 'Ricercatore'
WHERE p.posizione = 'Ricercatore'
group by p.nome, p.cognome , p.posizione , p.stipendio
having p.stipendio > AVG(p2.stipendio)
--v2 giusta
WITH m AS (
    SELECT AVG(p.stipendio) AS media_strip
    FROM persona p 
    WHERE p.posizione = 'Ricercatore'
)
SELECT p.id, p.nome, p.cognome, p.posizione, p.stipendio
FROM persona p, m
WHERE p.posizione = 'Ricercatore' 
AND p.stipendio > m.media_strip;
-- 3) Per ogni categoria di strutturati quante sono le persone con uno stipendio che differisce di al massimo una deviazione standard dalla media della loro categoria?

WITH m AS (
    SELECT p.posizione AS posizione,
           AVG(p.stipendio) AS media_strip,
           STDDEV(p.stipendio) AS deviazione_strip
    FROM persona p 
    GROUP BY p.posizione
)
SELECT p.posizione, COUNT(*)
FROM persona p, m 
WHERE p.posizione = m.posizione 
  AND p.stipendio > m.media_strip - m.deviazione_strip 
  AND p.stipendio <= m.media_strip + m.deviazione_strip
GROUP BY p.posizione;

 --4 Chi sono gli strutturati che hanno lavorato almeno 20 ore complessive in
 --attivita ’ progettuali? Restituire tutti i loro dati e i l numero di ore
 --l avorate .

with m as(
	SELECT persona, SUM(oredurata) AS totale_ore
	FROM attivitaprogetto
	GROUP BY persona
)
select p.id , p.nome,p.cognome,p.posizione,p.stipendio,m.totale_ore
from persona p , m m
where p.id=m.persona and m.totale_ore>20

--5  Quali sono i progetti la cui durata e’ superiore alla media delle durate
-- di tutti i progetti? Restituire nome dei progetti e loro durata in giorni
WITH stats AS (
    SELECT AVG(prog.fine - prog.inizio) AS media
    FROM Progetto prog
)
SELECT prog.nome, (prog.fine - prog.inizio) AS durata
FROM Progetto prog, stats s
WHERE (prog.fine - prog.inizio) > s.media;

--6 Quali sono i progetti terminati in data odierna che hanno avuto attivita ’
 --di tipo "Dimostrazione"? Restituire nome di ogni progetto e i l numero
-- complessivo delle ore dedicate a tali attivita ’ nel progetto 
with m as (
SELECT progetto as id, SUM(oredurata) AS totale_ore
FROM attivitaprogetto
WHERE tipo = 'Dimostrazione' 
 -- AND giorno >= CURRENT_DATE
GROUP BY progetto
)
select p.nome , m.totale_ore
from progetto p, m m 
where p.id = m.id

 --7) Quali sono i professori ordinari che hanno fatto piu ’ assenze per
 --malattia del numero di assenze medio per malattia dei professori
 --associati ? Restituire id , nome e cognome del professore e i l numero di
 --giorni di assenza per malattia .
WITH AssenzeMalattia AS (
    SELECT 
        persona, 
        COUNT(*) AS numero_giorni_assenza
    FROM 
        assenza
    WHERE 
        tipo = 'Malattia'
    GROUP BY 
        persona
),

MediaAssenzeProfessoriAssociati AS (
    SELECT 
        AVG(AM.numero_giorni_assenza) AS media_assenze
    FROM 
        AssenzeMalattia AM
    JOIN 
        persona P ON AM.persona = P.id
    WHERE 
        P.posizione = 'Professore Associato'
),

ProfessoriOrdinari AS (
    SELECT 
        P.id, 
        P.nome, 
        P.cognome, 
        AM.numero_giorni_assenza
    FROM 
        AssenzeMalattia AM
    JOIN 
        persona P ON AM.persona = P.id
    WHERE 
        P.posizione = 'Professore Ordinario'
)

SELECT 
    PO.id, 
    PO.nome, 
    PO.cognome, 
    PO.numero_giorni_assenza
FROM 
    ProfessoriOrdinari PO
    
JOIN 
    MediaAssenzeProfessoriAssociati MA ON PO.numero_giorni_assenza > MA.media_assenze;

