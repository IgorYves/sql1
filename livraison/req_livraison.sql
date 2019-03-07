--1.1
select * from detaillivraison;
select * from livraison;
select * from lignecommande;
select * from article;
select * from commande;
select * from client;
select * from tableblob;
select * from user_tables;

--1.2
select * from client where notelephone = '(999)999-9999';

--1.3
select nocommande, datecommande from commande where noclient = 10 and nocommande > 2;

--1.4
select * from article where prixunitaire >= 10 and prixunitaire <= 20;

--1.5
select * from article where description like 'C%';

--1.6
select * from client where notelephone is not null;

--1.7
select * from article where PRIXUNITAIRE > (select avg(PRIXUNITAIRE) from article);

--1.8
select * from article where PRIXUNITAIRE = (select min(PRIXUNITAIRE) from article);

--2.1
select sum(prixunitaire*quantite), sum(prixunitaire*quantite)*115/100 from article, lignecommande 
  where article.NOARTICLE=lignecommande.NOARTICLE and lignecommande.NOCOMMANDE=1;
  
--2.2
select sum(prixunitaire*quantite), sum(prixunitaire*quantite)*115/100 
  from detaillivraison, lignecommande, article
  where detaillivraison.NOCOMMANDE = lignecommande.NOCOMMANDE
    and lignecommande.NOARTICLE = article.NOARTICLE
    and detaillivraison.NOLIVRAISON = 100;
select sum(prixunitaire*quantitelivree), sum(prixunitaire*quantitelivree)*115/100 
  from detaillivraison, lignecommande, article
  where detaillivraison.NOCOMMANDE = lignecommande.NOCOMMANDE
    and lignecommande.NOARTICLE = article.NOARTICLE
    and detaillivraison.NOLIVRAISON = 100;
--ceci est bon :
select sum(prixunitaire*quantitelivree), sum(prixunitaire*quantitelivree)*115/100 
  from detaillivraison, article
  where detaillivraison.NOARTICLE = article.NOARTICLE
    and detaillivraison.NOLIVRAISON = 100;
	

--3.1
delete from article where NOARTICLE in (select article.NOARTICLE from article left join lignecommande on lignecommande.NOARTICLE = article.NOARTICLE
 where lignecommande.NOARTICLE is null);
rollbac;

--3.2
update lignecommande set quantite = quantite + 2 where NOCOMMANDE = 1 and NOARTICLE = 10;
rollbac;

--4.1
select * from CLIENT, COMMANDE where COMMANDE.NOCLIENT = CLIENT.NOCLIENT 
  and TO_DATE(COMMANDE.DATECOMMANDE, 'DD/MM/YY') = TO_DATE('02/06/2000', 'DD/MM/YYYY');

--4.2
select lignecommande.NOARTICLE from lignecommande, commande where lignecommande.NOCOMMANDE = commande.NOCOMMANDE
  and commande.NOCLIENT = 10 and TO_DATE(COMMANDE.DATECOMMANDE, 'DD/MM/YY') > TO_DATE('01/06/2000', 'DD/MM/YYYY');

--4.3
select distinct detaillivraison.NOLIVRAISON from detaillivraison, lignecommande, commande
  where lignecommande.NOCOMMANDE = detaillivraison.NOCOMMANDE
    and lignecommande.NOCOMMANDE = commande.NOCOMMANDE
    and commande.NOCLIENT = 10;

--4.4
select nocommande from commande 
  where trunc(datecommande) = to_date((select datecommande from commande where nocommande=2), 'DD/MM/YY') 
    and nocommande!=2;

--4.5

--4.6

--5.1

--5.2

--6.1

--6.2

--6.3

--6.4

--6.5
select distinct noarticle from lignecommande natural join commande where noclient=20;

--7.1

--7.2



