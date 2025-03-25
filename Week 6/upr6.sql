/* I */
use movies
/*1*/
select title, year, length
from movie
where length is NULL OR (length > 120 and year < 2000)
/*2*/
select name, gender
from MOVIESTAR
where name like 'J%' and birthdate > 01/01/1948
/*3*/
select studioname, count(distinct starname) as Number
from starsin join movie on movietitle=title
group by studioname
/*4*/
select moviestar.name, count(distinct starsin.MOVIETITLE) as count_movies
from moviestar left join starsin on starname=moviestar.name
group by moviestar.name
/*5*/
select movie.studioname as StudioName, title, year
from movie join (select studioname, MAX(year) as yr from movie group by studioname) as T
on movie.STUDIONAME = T.STUDIONAME and year = T.yr
/*6*/
select name
from moviestar
where Gender = 'M' and Birthdate = (select max(birthdate) as last_birthdate from moviestar where gender = 'M')
/*7*/
select studioname, starname, COUNT(*) as cn
from movie as m1 join starsin on m1.title=movietitle
group by studioname, starname
having  COUNT(*) >= ALL (select COUNT(*) as c1 from movie as m2 join starsin on m2.title=movietitle where m2.studioname=m1.studioname group by studioname, starname)
/*8*/
select title, year, COUNT(*) as NumberOfActors
from movie join starsin on title=movietitle
group by title, year
having COUNT(*) > 2

/* II */
use ships
/*1*/
select distinct name
from ships join outcomes on ships.name = OUTCOMES.ship
where name LIKE 'C%' or name LIKE 'K%'
/*2*/
select distinct ships.name, country
from ships join classes on ships.class = classes.class
left join outcomes on ships.name = outcomes.ship
where result != 'sunk' or result is NULL
/*3*/
select distinct country, COUNT(outcomes.ship) as numberOfSunkShips
from classes left join ships on ships.class = classes.class
left join outcomes on ships.name = outcomes.ship
where result is NULL or result = 'sunk'
group by country
/*4*/
select battles.name
from battles join outcomes on battles.name = outcomes.battle join ships on ships.name = outcomes.ship
group by battles.name
HAVING COUNT(*) > (select COUNT(*) as ct from outcomes join ships on outcomes.ship=ships.name where battle = 'Guadalcanal')
/*5*/
select battle
from outcomes join ships on ships.name=outcomes.ship join classes on classes.class = ships.CLASS
group by battle
having COUNT(distinct country) > ALL(select COUNT(distinct country) from outcomes join ships on ships.name = outcomes.ship join classes on classes.class = ships.class where battle = 'Surigao Strait')
/*6*/
select distinct ships.name, classes.DISPLACEMENT, classes.NUMGUNS
from ships join classes on classes.class=ships.class
where DISPLACEMENT = (SELECT MIN(DISPLACEMENT) from CLASSES)
and NUMGUNS = (select MAX(NUMGUNS)
from ships join classes on classes.class=ships.class
where DISPLACEMENT = (SELECT MIN(DISPLACEMENT) from CLASSES))
/*7*/
select COUNT(o1.SHIP) as cnt
from outcomes as o1 join battles as b1 on o1.battle = b1.name
where o1.result = 'damaged' and o1.ship in (select o2.ship from outcomes as o2 join battles as b2 on o2.BATTLE = b2.NAME where o2.result = 'ok' and b2.DATE > b1.date)
/*8*/
select o1.ship
from outcomes as o1 join battles as b1 on o1.battle = b1.name
where o1.result = 'damaged' and o1.ship in (select o2.ship from outcomes as o2 join battles as b2 on o2.BATTLE = b2.NAME where o2.result = 'ok' and b2.DATE > b1.date)

/* III */

use pc
/*1*/
select l1.model
from laptop as l1, laptop as l2
where l1.screen = 15 and l2.screen = 11 and l1.model = l2.model
/*2*/
select distinct p1.model
from pc as p1 join product as pr1 on p1.model = pr1.model
where p1.price < ALL (select price from laptop join product on product.model = laptop.model where pr1.maker = product.maker)
and EXISTS (select price from laptop join product on product.model = laptop.model where pr1.maker = product.maker)
/*3*/
select pc.model, avg(price) as avg_price
from pc join product as pr1 on pr1.model = pc.model
group by pc.model, pr1.maker
having avg(price) < ALL (select price from laptop join product on product.model=laptop.model where maker=pr1.maker)
AND EXISTS (select price from laptop join product on product.model=laptop.model where maker=pr1.maker)
/*4*/
select pc1.code, pr1.maker, (select COUNT(pc2.code) from pc as pc2 where pc2.price >= pc1.price and pc1.code != pc2.code) as number_of_pcs
from pc as pc1 join product as pr1 on pr1.model = pc1.model 

