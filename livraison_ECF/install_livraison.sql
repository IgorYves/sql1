drop table LigneCommande;
drop table DetailLivraison;
drop table Client;
drop table Livraison;
drop table Commande;
drop table Article;



ALTER SESSION SET NLS_DATE_FORMAT='DD/MM/YYYY HH:MI:SS';

CREATE TABLE Client
(noClient 		DECIMAL(4) constraint pk_noClient primary key,
 nomClient 		VARCHAR(20) not null,
 noTelephone 	VARCHAR(15) not null,
 constraint constr_noClient check (noClient > 0)
);

CREATE TABLE Commande
(noCommande 	DECIMAL(5) not null primary key,
 dateCommande	DATE NOT NULL,
 noClient		DECIMAL(4),
 constraint constr_noCommande check (noCommande > 0),
 FOREIGN key (noClient) references Client(noClient) enable
);

CREATE TABLE Article
(noArticle 		DECIMAL(5) not null primary key,
 description 	VARCHAR(20),
 prixUnitaire 	DECIMAL(10,2) not null,
 quantiteEnStock	DECIMAL(5) DEFAULT 0 not null,
 constraint constr_noArticle check (noArticle > 0),
 constraint constr_quantEnStk check (quantiteEnStock >= 0)
);

CREATE TABLE LigneCommande
(noCommande 	DECIMAL(5) not null,
 noArticle 		DECIMAL(5) not null,
 quantite 		DECIMAL(4) not null,
 check (quantite > 0) enable,
 primary KEY (noCommande, noArticle), 
 FOREIGN key (noArticle) references Article(noArticle) enable,
 FOREIGN key (noCommande) references Commande(noCommande) enable
);

CREATE TABLE Livraison
(noLivraison 	DECIMAL(5) not null primary key,
 dateLivraison	DATE NOT NULL
);

CREATE TABLE DetailLivraison
(noLivraison 	DECIMAL(5) not null,
 noCommande 	DECIMAL(5) not null,
 noArticle 		DECIMAL(5) not null,
 quantiteLivree	DECIMAL(4) not null,
 primary KEY (noCommande, noArticle, noLivraison)
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