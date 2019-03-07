CREATE TABLE LigneCommande
(noCommande 	INTEGER,
 noArticle 		INTEGER,
 quantite 		INTEGER
);
CREATE TABLE DetailLivraison
(noLivraison 	INTEGER,
 noCommande 	INTEGER,
 noArticle 		INTEGER,
 quantiteLivree	INTEGER
);
CREATE TABLE Client
(noClient 		INTEGER,
 nomClient 		VARCHAR(20),
 noTelephone 	VARCHAR(15)
);

CREATE TABLE Livraison
(noLivraison 	INTEGER,
 dateLivraison	DATE
);
CREATE TABLE Commande
(noCommande 	INTEGER,
 dateCommande	DATE,
 noClient		INTEGER
);

CREATE TABLE Article
(noArticle 		INTEGER,
 description 	VARCHAR(20),
 prixUnitaire 	DECIMAL(10,2),
 quantiteEnStock	INTEGER		DEFAULT 0
);



prompt
prompt
prompt
Prompt ******************************
prompt Recapitulatif des Objets créés
Prompt ******************************
select * from user_catalog;
prompt
prompt
prompt
prompt ************************************
prompt Recapitulatif des contraintes posées
prompt ************************************

column constraint_name format A20
column type format A3
column table_name format A15
column SEARCH_CONDITION format A30

break on type skip 
compute count of constraint_name on type report
select  constraint_name, Constraint_type as type,
        table_name , SEARCH_CONDITION, DELETE_RULE, STATUS
from user_constraints
order by type, table_name;


clear columns
clear breaks
clear computes
