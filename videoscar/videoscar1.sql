select * from film;

select * from film where catcod = 'FA';

select filmcod, filmtit from film where filman = 1980 and filnat = 'F';

select distinct filnat from film order by filnat;

select filmcod, filmtit from film where filnat = '&filnat' and filman = '&filman';

select * from realise;

select * from realise where reanom like '&reanom'||'%';

select filman, count(filman) from film group by filman order by filman;

--7
select * from categorie;

select categorie.catlib, count(film.filmcod) "nombre films", trunc(avg(filmdur), 0) "duree moyenne", 
  min(filmdur) "duree min", max(filmdur) "duree max"  
  from film join categorie on film.catcod = categorie.catcod group by categorie.catlib 
  having count(film.filmcod) > 9 order by categorie.catlib;

  
 