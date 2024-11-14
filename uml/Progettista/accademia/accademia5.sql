
--Quali sono il nome, la data di inizio e la data di fine dei WP del progetto di nome ‘Pegasus’?
select WP.nome, WP.inizio , WP.fine
from WP , Progetto
where Progetto.id = WP.progetto and Progetto.name ='Pegasus';
--Quali sono il nome, il cognome e la posizione degli strutturati che hanno almeno una attività nel progetto ‘Pegasus’, ordinati per cognome decrescente?
select distinct p.nome , p.cognome , p.posizione
from  progetto pr , AttivitaProgetto att, Persona p 
where pr.nome = 'Pegasus' and att.persona = p.id and att.progetto = pr.id 
order by cognome desc 



--Quali sono il nome, il cognome e la posizione degli strutturati che hanno più di una attività nel progetto ‘Pegasus’ ?
select distinct p.nome , p.cognome , p.posizione
from Persona p ,attivitaprogetto att ,attivitaprogetto att1 , Progetto pr
where pr.nome = 'Pegasus' and p.id =att.persona and p.id = att2.persona and pr.id=att.progetto and pr.id =att2.progetto and att.id<>att2.id;

--Quali sono il nome, il cognome e la posizione dei Professori Ordinari che hanno fatto almeno una assenza per malattia?
select distinct p.nome , p.cognome , p.posizione, a.tipo
from Persona p , assenza a 
where a.tipo = 'Malattia' and p.posizione = 'Professore Ordinario'and p.id=a.persona

--Quali sono il nome, il cognome e la posizione dei Professori Ordinari che hanno fatto più di una assenza per malattia?
select distinct p.nome , p.cognome , p.posizione, a.tipo
from Persona p , assenza a , assenza a1
where a.tipo = 'Malattia' and p.posizione = 'Professore Ordinario'
    and p.id=a.persona
    and a.giorno <> a1.giorno
	and a.persona = a1.persona

--Quali sono il nome, il cognome e la posizione dei Ricercatori che hanno almeno un impegno per didattica?
select distinct p.nome , p.cognome , p.posizione
from Persona p, attivitanonprogettuale attn
where p.posizione = 'Ricercatore' and attn.persona = p.id

--Quali sono il nome, il cognome e la posizione dei Ricercatori che hanno più di un impegno per didattica?
select distinct p.nome , p.cognome , p.posizione
from Persona p, attivitanonprogettuale attn , attivitanonprogettuale attn2
where p.posizione = 'Ricercatore' and attn.persona = p.id and attn.persona > 1
-- Quali sono il nome e il cognome degli strutturati che nello stesso giorno hanno sia attività progettuali che attività non progettuali?
select distinct p.nome , p.cognome 
from Persona p, attivitanonprogettuale attn , attivitaprogetto att
where p.id = att.persona and attn.persona = att.persona and p.id = attn.persona and att.giorno =attn.giorno 

---Quali sono il nome e il cognome degli strutturati che nello stesso giorno hanno sia
 -- progettuali che attività non progettuali? Si richiede anche di proiettare il
 --giorno, il nome del progetto, il tipo di attività non progettuali e la durata in ore di
 --entrambe le attività
select distinct p.nome , p.cognome ,att.giorno, pr.nome,att.oredurata , attn.tipo,attn.oredurata
from Persona p, attivitanonprogettuale attn , attivitaprogetto att, progetto pr
where p.id = att.persona and attn.persona = att.persona and p.id = attn.persona and att.giorno =attn.giorno and pr.id = att.progetto

--Quali sono il nome e il cognome degli strutturati che nello stesso giorno sono assenti e hanno attività progettuali?
select p.nome, p.cognome
from Persona p, assenza a, attivitaprogetto att
where p.id = a.persona and a.giorno=att.giorno 

--Quali sono il nome e il cognome degli strutturati che nello stesso giorno sono
-- assenti e hanno attività progettuali? Si richiede anche di proiettare il giorno, il
-- nome del progetto, la causa di assenza e la durata in ore della attività progettuale
select p.nome, p.cognome , a.giorno , pr.nome, a.tipo, att.oredurata
from Persona p, assenza a, attivitaprogetto att, progetto pr
where p.id = a.persona and a.giorno=att.giorno and att.progetto=pr.id
-- Quali sono i WP che hanno lo stesso nome, ma appartengono a progetti diversi
select distinct w.nome
from WP w , WP w1
where w.nome = w1.nome and w.progetto <> w1.progetto