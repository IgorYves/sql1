
ALTER SESSION SET NLS_DATE_FORMAT='DD/MM/YYYY HH24:MI:SS';

CREATE TABLE Client
(noClient 		DECIMAL(4,0) not null,
 nomClient 		VARCHAR(20) not null,
  noTelephone 	VARCHAR(15) not null,
  constraint pk_noClient primary key (noClient) enable,
  constraint check_noClient check (noClient > 0) enable
);

CREATE TABLE Commande
(noCommande 	DECIMAL(5,0) not null,
 dateCommande	DATE NOT NULL,
 noClient		DECIMAL(4,0) not null,
 constraint pk_noCommande  primary key (noCommande) enable,
 constraint fk_noClient FOREIGN key (noClient) references Client(noClient) enable,
 constraint check_noCommande check (noCommande > 0) enable
);

CREATE TABLE Article
(noArticle 		DECIMAL(5,0) not null,
 description 	VARCHAR(20) null,
 prixUnitaire 	DECIMAL(10,2) not null,
 quantiteEnStock	DECIMAL(5,0) DEFAULT 0 not null,
 constraint pk_noArticle  primary key (noArticle) enable,
 constraint check_noArticle check (noArticle > 0) enable,
 constraint check_quantEnStk check (quantiteEnStock >= 0) enable
);

CREATE TABLE LigneCommande
(noCommande 	DECIMAL(5,0) not null,
 noArticle 		DECIMAL(5,0) not null,
 quantite 		DECIMAL(4,0) not null,
 constraint pk_noCom_noArt  primary key (noCommande, noArticle) enable,
 constraint fk_noArticle  FOREIGN key (noArticle) references Article(noArticle) enable,
 constraint fk_noCommande FOREIGN key (noCommande) references Commande(noCommande) enable,
 constraint check_quantite check (quantite > 0) enable
);

CREATE TABLE Livraison
(noLivraison 	DECIMAL(5,0) not null,
 dateLivraison	DATE NOT NULL,
 constraint pk_noLivraison  primary key (noLivraison) enable,
 constraint check_noLivraison check (noLivraison > 0) enable
);

CREATE TABLE DetailLivraison
(noLivraison 	DECIMAL(5,0) not null,
 noCommande 	DECIMAL(5,0) not null,
 noArticle 		DECIMAL(5,0) not null,
 quantiteLivree	DECIMAL(4,0) not null,
 constraint pk_noCom_noArt_noLiv  primary key (noCommande, noArticle, noLivraison) enable,
 constraint fk_noLivraison FOREIGN key (noLivraison) references Livraison(noLivraison) enable,
 constraint fk_noCom_noArt FOREIGN key (noCommande, noArticle) references LigneCommande(noCommande, noArticle) enable,
 constraint check_quantiteLivree check (quantiteLivree > 0) enable
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