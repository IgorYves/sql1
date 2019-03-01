select nocompte, solde from compte where noclient=10;

select client.nomclient, compte.nocompte, compte.solde
	from client inner join compte on client.noclient=compte.noclient;

 select client.nomclient, compte.nocompte, compte.solde
	from client inner join compte on client.noclient=compte.noclient
	where dateouverture='10/10/99';
	
delete from compte where nocompte=100;
select * from compte;
rollback;
select * from compte;

update compte set solde = solde-100 where nocompte=100;
select * from compte;
update compte set solde = solde+100 where nocompte=300;
select * from compte;
select * from compte where noclient=10;
rollback;
select * from compte where noclient=10;

create index num_cl_idx on compte (noclient);
select * from compte where noclient=10;

--start D:\SQL\oracle\drop_banque;
--start D:\SQL\oracle\install_banque;
--start D:\SQL\oracle\install_data_banque;





