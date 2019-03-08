--/*==============================================================*/
--/* Nom de la base :  livraison                                      */
--/* Nom du fichier : drop_livraison.sql                            */
--/*==============================================================*/

drop table DetailLivraison;
drop table Livraison;
drop table LigneCommande;
drop table Article;
drop table Commande;
drop table Client;







purge recyclebin;

prompt
prompt
prompt
prompt ***********************
prompt Reste-t-il des objets ?
prompt ***********************
select * from cat;
