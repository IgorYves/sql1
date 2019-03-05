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

--8
--structure de table k7 incomprehencible (données de colonne k7loc)
select * from k7 where k7loc is null;

--9
select film.filmtit, realise.reanom, realise.reapre from realise join film on film.reacod=realise.reacod 
	where film.filmcod=&filmcod;
	
--10
select film.filmtit, acteur.actnom, acteur.actpre from film, acteur, jouer 
	where jouer.filmcod=film.filmcod 
		and jouer.actcod=acteur.actcod 
		and film.filmcod=&filmcod;

--11
select realise.reanom, realise.reapre, acteur.actnom, acteur.actpre from film, acteur, jouer, realise
	where jouer.filmcod=film.filmcod 
		and jouer.actcod=acteur.actcod 
		and film.reacod=realise.REACOD 
		and realise.REACOD=&REACOD;

--12
select categorie.catlib, acteur.actnom, acteur.actpre from film, acteur, jouer, categorie
	where jouer.filmcod=film.filmcod 
		and jouer.actcod=acteur.actcod 
		and film.catcod=categorie.catcod 
		and acteur.actcod=&actcod;

--13
select film.filmcod, film.filmtit, realise.reacod, realise.reanom, realise.reapre 
  from film, realise
	where film.reacod=realise.REACOD 
		and realise.reanom like '&reanom'||'%'
  order by realise.reacod;

--14
select distinct acteur.ACTCOD, acteur.ACTNOM, acteur.ACTPRE from acteur, jouer 
	where acteur.actcod=jouer.actcod 
		and jouer.filmcod in (select FILMCOD from jouer where actcod='&actcod');

--15
select film.reacod, film.filmtit, film.filman from film, acteur, jouer, realise 
  where jouer.filmcod=film.filmcod 
	and jouer.actcod=acteur.actcod 
	and film.reacod=realise.REACOD 
    and acteur.actcod=&actcod
    and realise.REACOD=&REACOD;

--16
select film.filmtit, film.filman, film.filnat, categorie.catlib, 
    realise.reanom, realise.reapre, acteur.ACTNOM, acteur.ACTPRE,
    k7.k7cod, k7.k7typ, k7.k7loc
  from film, acteur, jouer, realise, categorie, k7
  where jouer.filmcod=film.filmcod 
		and jouer.actcod=acteur.actcod 
		and film.reacod=realise.REACOD 
    and categorie.CATCOD=film.CATCOD
    and film.filmcod=&filmcod;

--17
select film.filmcod, film.filmtit from film, acteur, jouer 
	where jouer.filmcod=film.filmcod 
    and jouer.actcod=acteur.actcod 
    and jouer.actcod=&actcod 
    and jouer.filmcod in (select FILMCOD from jouer where actcod='&actcod');
  
