DROP TABLE IF EXISTS CSVImport;
CREATE TABLE IF NOT EXISTS CSVImport (
`Type de données` VARCHAR(256),
`Référence de l'édifice` VARCHAR(256),
`Nom de l'étude` VARCHAR(256),
`Type d'édifice` VARCHAR(256),
`Titre courant de l’édifice` VARCHAR(256),
`Département` VARCHAR(256),
`Commune` VARCHAR(256),
`Lieu-dit` VARCHAR(256),
`Adresse` VARCHAR(256),
`Nom de l'édifice` VARCHAR(256),
`Période 1` VARCHAR(256),
`c12` VARCHAR(256),
`c13` VARCHAR(256),
`c14` VARCHAR(256),
`c15` VARCHAR(256),
`c16` VARCHAR(256),
c17 VARCHAR(256),
c18 VARCHAR(256)
)
DEFAULT CHARACTER SET = UTF8;

LOAD DATA LOCAL 
INFILE '/home/ca/Téléchargements/inventaire-du-patrimoine-en-region-centre-val-de-loire.csv' 
INTO TABLE CSVImport
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
IGNORE 1 LINES;

SELECT *, COUNT(*) FROM INVOCC
GROUP BY 'REF'
HAVING COUNT(*)>1;

CREATE TABLE temps (
    ville           varchar(80),
    t_basse         int,           -- température basse
    t_haute         int,           -- température haute
    prcp            real,          -- précipitation
    date            date
);

DROP TABLE IF EXISTS OCCITANIE;
CREATE TABLE IF NOT EXISTS OCCITANIE (
"REF" VARCHAR(256),
"AIRE" VARCHAR(256),
"COM" VARCHAR(256),
"COOR1" VARCHAR(256),
"COOR2" VARCHAR(256),
"DENO" VARCHAR(256),
"DMAJ" VARCHAR(256),
"DPT" VARCHAR(256),
"IMPL" VARCHAR(256),
"INSEE" VARCHAR(256),
"STAT" VARCHAR(256),
"TICO" VARCHAR(256),
"ZONE" VARCHAR(256),
"point_geo1" VARCHAR(256),
"point_geo2" VARCHAR(256)
)
DEFAULT CHARACTER SET = UTF8;

LOAD DATA 
INFILE '/home/ca/Téléchargements/inventaire-general-du-patrimoine-culturel-doccitanie(1).csv' 
INTO TABLE INVOCC
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
IGNORE 1 LINES;
