create table topachat.produit as select * from scott.produit;

select constraint_name, Constraint_type as type, table_name
				from user_constraints order by type, table_name;

alter table produit add constraint produit_pk primary key (noproduit);
