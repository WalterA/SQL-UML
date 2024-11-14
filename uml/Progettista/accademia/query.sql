-- 1) Quali sono i cognomi distinti di tutti gli strutturati?
select distinct cognome
from persona
-- 2) Quali sono i Ricercatori (con nome e cognome)?
select nome,  cognome
from persona
where persona.posizione = 'Ricercatore'
-- 3) Quali sono i Professori Associati i l cui cognome comincia con la lettera ’V’?
select nome,  cognome
from persona
where persona.posizione = 'Professore Associato' and cognome like 'V%'
-- 4) Quali sono i Professori (sia Associati che Ordinari) i l cui cognome comincia con la lettera ’V’?
select id, nome,  cognome
from persona
where  persona.posizione IN ('Professore Ordinario', 'Professore Associato') and cognome like 'V%'
-- 5) Quali sono i Progetti gia ’ terminati alla data odierna?
select *
from progetto
where  fine < current_date
-- 6) Quali sono i nomi di tutti i Progetti ordinati in ordine crescente di data di inizio?
select nome
from progetto
order by inizio asc
-- 7) Quali sono i nomi dei WP ordinati in ordine crescente ( per nome)?
select nome
from wp
order by nome asc
-- 8) Quali sono ( distinte ) le cause di assenza di tutti gli strutturati ?
select distinct tipo
from assenza
-- 9) Quali sono ( distinte ) le tipologie di attivita ’ di progetto di tutti gli strutturati?
select distinct tipo
from attivitaprogetto
--10) Quali sono i giorni distinti nei quali del personale ha effettuato attivita ’ non progettuali di tipo ’Didattica ’? Dare i l risultato in ordine crescente .
select distinct giorno
from attivitanonprogettuale
where attivitanonprogettuale.tipo = 'Didattica'
order by giorno asc
