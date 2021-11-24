-- Criação do Banco de dados

DROP DATABASE IF EXISTS GAME_OF_THRONES;
CREATE DATABASE GAME_OF_THRONES;
USE GAME_OF_THRONES;


-- Tabelas Importadas do SQL gerado no site

CREATE TABLE HOUSES (
  HOUSENAME varchar(35),
  REGION varchar(30)
);


CREATE TABLE CHARACTERS (
  `CHARACTER` varchar(35),
  ACTOR_ESS varchar(30),
  EPISODES_APPEARED varchar(2),
  FIRST_APPEARANCE char(4),
  LAST_APPEARANCE char(4)
);

CREATE TABLE EPISODES (
  SEASON char(1),
  EPISODE varchar(2),
  TITLE varchar(50),
  RATING float,
  VOTES varchar(6),
  SUMMARY varchar(240),
  WRITTER1 varchar(20),
  WRITTER2 varchar(15),
  STAR1 varchar(22),
  STAR2 varchar(22),
  STAR3 varchar(22),
  USERS_REVIEWS varchar(4),
  CRITICS_REVIEWS varchar(2),
  US_VIEWERS float,
  DURATION varchar(2),
  DIRECTOR varchar(20)
);


-- Povoar Tabelas com CSVs de Game of Thrones recebidas
-- Teste das tabelas povoadas corretamente

SELECT * FROM CHARACTERS;
SELECT * FROM EPISODES;
SELECT * FROM HOUSES;


-- Criando PK em `CHARACTERS` E FK EM `EPISODES`

ALTER TABLE CHARACTERS ADD PRIMARY KEY (ACTOR_ESS);
ALTER TABLE `EPISODES` ADD CONSTRAINT fk_ACTOR_ESS_ID 
FOREIGN KEY (`STAR1`) REFERENCES `CHARACTERS`(`ACTOR_ESS`);


-- Filtro para gráfico "TOP 10 QUANTIDADE DE CASAS POR REGIÃO"

SELECT `REGION`,COUNT(*) AS TOTAL 
FROM `HOUSES` GROUP BY `REGION` 
ORDER BY TOTAL DESC LIMIT 10
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/REGIONS.csv' 
FIELDS TERMINATED BY ","
ENCLOSED BY '"' 
LINES TERMINATED BY '\n';


-- Filtro para gráfico " PERSONAGENS VIVOS POR MAIS TEMPO E EM QUANTOS EPISÓDIOS APARECERAM"

SELECT `CHARACTER`, `LAST_APPEARANCE`-`FIRST_APPEARANCE`
AS TOTAL FROM `CHARACTERS`order by total DESC;
-- Sabendo que o máximo de anos é 8 temos o filtro abaixo
SELECT `CHARACTER`, `LAST_APPEARANCE`-`FIRST_APPEARANCE` 
AS TOTAL FROM `CHARACTERS`
WHERE (`LAST_APPEARANCE`-`FIRST_APPEARANCE`) = 8;
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/TOP_APEA.csv' 
FIELDS TERMINATED BY ","
ENCLOSED BY '"' 
LINES TERMINATED BY '\n';


-- Filtro para Gráfico "TEMPORADAS MELHOR AVALIADAS"

SELECT `SEASON`, ROUND (AVG (`RATING`),2) 
FROM EPISODES
GROUP BY `SEASON` 
ORDER BY AVG (`RATING`) DESC

INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/TEMPORADA_MEDIA.csv' 
FIELDS TERMINATED BY ","
ENCLOSED BY '"' 
LINES TERMINATED BY '\n';

COMMIT;
SET AUTOCOMMIT = 0;

