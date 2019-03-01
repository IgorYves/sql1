
create table scott.PRODUIT (noProduit number);
alter table scott.produit add libelle varchar2(25);
alter table scott.produit add prix float(3);

desc produit;

insert into produit values (6001, 'Gomme', 1.2);
insert into produit values (734, 'Agenda', 19);
insert into produit values (1024, 'Classeur', 6);
commit;

select * from produit;

select * from produit where prix < 8;

create table produit_back as select * from produit;

delete from produit where prix < 8;

insert into produit select * from produit_back where prix < 8;

select * from produit;

delete from produit where prix < 8;

merge into produit p using (select * from produit_back) pb
		on (p.noproduit=pb.noproduit) 
	when matched then
		update set p.libelle=pb.libelle, p.prix=pb.prix
	when not matched then 
		insert (p.noproduit, p.libelle, p.prix) values (pb.noproduit, pb.libelle, pb.prix);
		
create user topachat identified by topachat;
grant connect to topachat;
grant resource to topachat;

