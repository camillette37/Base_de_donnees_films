# Crée la table

DROP TABLE IF EXISTS CSVImport;
CREATE TABLE IF NOT EXISTS CSVImport (
`Type de donnees` VARCHAR(256),
`Reference de l_edifice` VARCHAR(256),
`Nom_de_l_etude` VARCHAR(256),
`Type d_edifice` VARCHAR(256),
`Titre courant de l’edifice` VARCHAR(256),
`Departement` INT(3),
`Commune` VARCHAR(256),
`Lieu-dit` VARCHAR(256),
`Adresse` VARCHAR(256),
`Nom de l_edifice` VARCHAR(256),
`Periode 1` VARCHAR(256),
`c12` VARCHAR(256),
`c13` VARCHAR(256),
`c14` VARCHAR(256),
`c15` VARCHAR(256),
`c16` VARCHAR(256),
`c17` VARCHAR(256),
`Position_GPS` VARCHAR(256),
#`idx` INT NOT NULL AUTO_INCREMENT,
PRIMARY KEY (`Reference de l_edifice`)
)
DEFAULT CHARACTER SET = UTF8;

#importer les données

TRUNCATE CSVImport;
LOAD DATA LOCAL 
INFILE '/home/ca/Téléchargements/inventaire-du-patrimoine-en-region-centre-val-de-loire.csv' 
INTO TABLE CSVImport
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

#compter les doublon 

SELECT `Reference de l_edifice`, COUNT(*) FROM CSVImport
GROUP BY `Reference de l_edifice`
HAVING COUNT(*)>1;

#enlever les doublon

DELETE t1 
FROM CSVImport AS t1, CSVImport AS t2
WHERE t1.Idx > t2.Idx
AND t1.`Reference de l_edifice` = t2.`Reference de l_edifice`;

#ajout de colonne lat lon

ALTER TABLE CSVImport ADD Lat DECIMAL(15,12) NOT NULL;
ALTER TABLE CSVImport ADD Lon DECIMAL(15,12) NOT NULL;


#afficher les virgule des position gps

SELECT SUBSTR(Position_GPS, 1, INSTR(Position_GPS,',')-1) FROM CSVImport LIMIT 30;

#transformer chaîne de caractères en décimal
select CONVERT(SUBSTR(Position_GPS, 1, INSTR(Position_GPS,',')-1) ,DECIMAL(15,12)) as lat FROM CSVImport LIMIT 30;

#envoyer dans la table 
Latitude :
select CONVERT(SUBSTR(Position_GPS, 1, INSTR(Position_GPS,',')-1) ,DECIMAL(15,12))  as lat FROM CSVImport LIMIT 30;
UPDATE CSVImport
Longitude et latitude :
UPDATE CSVImport
 SET Lon=CONVERT(SUBSTR(Position_GPS, INSTR(Position_GPS,',')+1) ,DECIMAL(15,12));
 SET Lat=CONVERT(SUBSTR(Position_GPS, 1, INSTR(Position_GPS,',')-1) ,DECIMAL(15,12));
