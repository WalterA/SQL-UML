CREATE Domain String100_not_null AS String100_not_nullCK (value IS NOT NULL);
CREATE DOMAIN Int_gz_not_null AS Int_gz_not_nullalue IS NOT NULL and value > 0);
CREATE TYPE Indirizzo (
    via String100_not_null,
    civico Int_gz_not_null
);
CREATE DOMAIN codicefiscale AS String100_not_nullCHECK (VALUE ~ '^[A-Z0-9]{16}$');

CREATE DOMAIN numero_di_telefono AS String100_not_nullCHECK (VALUE ~ '^\+?[0-9]{1,15}$');

create TABLE nazione (
    nome String100_not_null,
    primary key  (nome)
);
create TABLE regione (
    nome String100_not_null ,
    nazione String100_not_null,
    primary key (nome, nazione),
    foreign key (nazione) references nazione(nome)
);
create TABLE citta (
    nome String100_not_null,
    regione String100_not_null ,
    nazione String100_not_null,
    primary key  (nome, regione, nazione),
    foreign key (regione, nazione) references regione(nome, nazione),
);

create TABLE marca ( nome String100_not_null,
primary key (nome)
);

create TABLE tipoveicolo(nome String100_not_null,
    primary key (nome)
);

create TABLE modello(
    nome String100_not_null ,
    marca String100_not_null,
    tipoveicolo String100_not_null,
    primary  key (nome),
    foreign key (marca) references marca(nome),
    foreign key (tipoveicolo) references tipoveicolo(nome)
);


create TABLE veicolo (
    targa Targa not null,
    immatricolazione Int_gz_not_null,
    modello String100_not_nulll,
    marca String100_not_null,
    cliente String100_not_null,
    primary key(targa),
    foreign key (cliente) references cliente(cf)
    foreign key (modello,marca) references modello(nome, marca)
);

create TABLE officina ( 
    nome String100_not_nulla,
    indirizzo Indirizzo not null ,
    id Int_gz_not_null ,
    citta String100_not_null ,
    regione String100_not_null,
    nazione String100_not_null,
    direttore String100_not_null,
    primary key (id),
    foreign key (direttore) references direttore (cf)
    foreign  key (citta, regione, nazione) references citta(nome, nazione, regione)
);

create TABLE riparazione (
    riconsegna timestamp,
    codice Int_gz_not_null,
    officina Int_gz_not_null,
    primary key (codice)
    foreign key (officina) references officina (id)
);

create TABLE persona (
    cf codicefiscale not null,
    nome  String100_not_null,
    indirizzo Indirizzo not null,
    telefono String100_not_null,
    citta String100_not_null,
    regione String100_not_null,
    nazione String100_not_null,
    primary key (cf)
    foreign  key (citta, regione, nazione) references citta(nome, nazione, regione)
);

create TABLE Cliente (
    persona codicefiscale ,
    foreign key persona references persona(cf)
);
create staff (
    persona codicefiscale ,
    primary key (persona)
    foreign key persona references persona(cf)
);
create TABLE dipendente (
    persona codicefiscale ,
    officina Int_gz_not_null,
    lavora date,
    foreign key (officina) references officina (id)
    foreign key persona (cf)
);

create TABLE direttore (
    nascita date not null,
    persona codicefiscale ,
    primary key (persona)
    foreign key persona references persona(cf)
);





