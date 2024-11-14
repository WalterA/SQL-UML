--1 Quanti sono gli strutturati di ogni fascia?
select a.posizione , count(*)
from persona a
group by a.posizione
-- 2) Quanti sono gli strutturati con stipendio>=40000?
select count (a.stipendio) as numero
from persona a
where a.stipendio >=40000
-- 3) Quanti sono i progetti gia ’ finiti che superano i l budget di 50000?
select count(*) as numero
from progetto pr 
where pr.budget >50000 and pr.fine <= current_date;
 --4) Qual e’ la media, i l massimo e i l minimo delle ore
-- delle attivita ’ relative al progetto "Pegasus"?
select avg(a.oredurata)as media , min(a.oredurata) as minimo , max(a.oredurata) as massimo
from attivitaprogetto a ,progetto p
where a.progetto = p.id and p.nome = 'Pegasus'
 -- 5) Quali sono le medie, i massimi e i minimi delle ore giornaliere
 --dedicate al progetto ’Pegasus ’ da ogni singolo docente?
select p.id, p.nome,p.cognome, avg(a.oredurata)as media , min(a.oredurata) as minimo , max(a.oredurata) as massimo
from attivitaprogetto a ,progetto pr, persona p
where a.progetto = pr.id and pr.nome = 'Pegasus' and a.persona = p.id
group by p.id,p.nome , p.cognome

--6) Qual e’ i l numero totale di ore dedicate alla didattica
--da ogni docente?
select sum(anp.oredurata) as numero_ore_didattica
from attivitanonprogettuale anp
where  anp.tipo = 'Didattica' --anp.persona ='3' and
group by anp.persona
-- 7) Qual e’ la media , i l massimo e i l minimo degli stipendi dei ricercatori ?
select  avg(p.stipendio)as media , min(p.stipendio) as minimo , max(p.stipendio) as massimo
from persona p
where p.posizione = 'Ricercatore'

-- 8) Quali sono le medie , i massimi e i minimi degli stipendi
 --dei ricercatori , dei professori
 --associati e dei professori ordinari?
SELECT 
    p.posizione,
    AVG(p.stipendio) AS media,
    MIN(p.stipendio) AS minimo,
    MAX(p.stipendio) AS massimo
FROM 
    persona p
GROUP BY 
    p.posizione;
--Quante ore "Ginevra Riva" ha dedicato ad ogni progetto
-- nel quale ha lavorato?
SELECT 
     pr.id,pr.nome , sum(att.oredurata)
FROM 
    persona p ,attivitaprogetto att, progetto pr
WHERE
	p.nome= 'Ginevra' and
	p.cognome = 'Riva'and
	p.id = att.persona and
	att.progetto = pr.id
group by pr.id , pr.nome
--10) Qual e’ i l nome dei progetti su cui lavorano piu ’ di
--due strutturati ?
select pro.nome
from attivitaprogetto ap,progetto pro
where pro.id = ap.progetto
group by pro.nome
having count(distinct ap.persona) >=2
-- 11) Quali sono i professori associati che hanno lavorato
-- su piu ’ di un progetto?
SELECT distinct p.id , p.nome,p.cognome
FROM attivitaprogetto att , persona p
where p.posizione = 'Professore Associato' and p.id= att.persona

select per.id ,per.nome, per.cognome
from  persona per , attivitaprogetto ap
where per.posizione='Professore associato' and per.id =ap.persona
group by per.id ,per.nome, per.cognome
having count(distinct ap.progetto) > 1