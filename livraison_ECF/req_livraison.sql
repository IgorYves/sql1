
--4.1
select * from Client;
select * from Commande;
select * from Article;
select * from LigneCommande;
select * from Livraison;
select * from DetailLivraison;

--4.2
select * from client where notelephone='(999)999-9999';

--5.1
select sum(prixunitaire*quantite), sum(prixunitaire*quantite)*115/100 
  from lignecommande, article
  where lignecommande.NOARTICLE = article.NOARTICLE
    and lignecommande.NOCOMMANDE = 1;

--6.1
select * from article left join LIGNECOMMANDE on LIGNECOMMANDE.NOARTICLE = article.NOARTICLE
  where LIGNECOMMANDE.NOCOMMANDE is null;
delete from article where NOARTICLE in (select article.NOARTICLE from article left join LIGNECOMMANDE on LIGNECOMMANDE.NOARTICLE = article.NOARTICLE
  where LIGNECOMMANDE.NOCOMMANDE is null);
rollback;
