create type Strutturato as enum ('Ricercatore', 'Professore Associato', 'Professore Ordinario');
create type LavoroProgetto as enum ('Ricerca e Sviluppo', 'Dimostrazione', 'Management', 'Altro');
create type LavoroNonProgettuale as enum ('Didattica', 'Ricerca', 'Missione', 'Incontro Dipartimentale', 'Incontro Accademico', 'Altro');
create type CausaAssenza as enum ('Chiusura Universitaria', 'Maternita', 'Malattia');

create domain PosInteger as integer
    CHECK (VALUE >= 0);  
    
create domain StringaM as varchar(100); 

create domain NumeroOre as integer
    CHECK (VALUE >= 0 and VALUE <= 8); 

create domain Denaro as real
    CHECK (VALUE >= 0);  

create table Persona(
    id PosInteger, 
    nome StringaM NOT NULL,
    cognome StringaM NOT NULL,
    posizione Strutturato NOT NULL,
    stipendio Denaro, 
    primary key (id)
);

create table Progetto (
    id PosInteger,  
    nome StringaM NOT NULL,
    inizio date NOT NULL,
    fine date NOT NULL,
    budget Denaro, 
    CHECK (inizio < fine), 
    primary key (id),
    unique (nome)  
);

create table WP (
    progetto PosInteger NOT NULL, 
    id PosInteger,  
    nome StringaM NOT NULL,
    inizio date NOT NULL,
    fine date NOT NULL,
    CHECK (inizio < fine), 
    primary key (progetto, id),  
    unique (progetto, nome),  
    foreign key (progetto) references Progetto(id)  
);

create table AttivitaProgetto (
    id PosInteger, 
    persona PosInteger NOT NULL, 
    progetto PosInteger NOT NULL,  
    wp PosInteger NOT NULL,  
    giorno date NOT NULL,
    tipo LavoroProgetto NOT NULL,
    oreDurata NumeroOre NOT NULL,
    foreign key (persona) references Persona(id), 
    foreign key (progetto, wp) references WP(progetto, id)  
);

create table AttivitaNonProgettuale (
    id PosInteger,  
    persona PosInteger NOT NULL, 
    tipo LavoroNonProgettuale NOT NULL,
    giorno date NOT NULL,
    oreDurata NumeroOre NOT NULL,
    foreign key (persona) references Persona(id)  
);

create table Assenza (
    id PosInteger,  
    persona PosInteger NOT NULL,
    tipo CausaAssenza NOT NULL,
    giorno date NOT NULL,
    unique (persona, giorno),  
    foreign key (persona) references Persona(id) 
);
