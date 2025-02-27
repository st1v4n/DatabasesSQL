
use movies
/* I */
/* 1. Напишете заявка, която извежда имената на актьорите мъже, участвали във
филма The Usual Suspects.*/

select name
from MOVIESTAR join STARSIN
ON name = STARNAME
WHERE MOVIESTAR.GENDER = 'M' AND STARSIN.MOVIETITLE = 'The Usual Suspects'
/* 2. Напишете заявка, която извежда имената на актьорите, участвали във филми от
1995, продуцирани от студио MGM*/
select distinct name
from MOVIESTAR JOIN STARSIN
On name = starsin.STARNAME
Join Movie
On STUDIONAME = 'MGM'
Where starsin.MOVIEYEAR = 1995
/*3. Напишете заявка, която извежда имената на продуцентите, които са
продуцирали филми на студио MGM.*/
select DISTINCT name
from movieexec 
join movie on PRODUCERC# = CERT#
where STUDIONAME = 'MGM'
/*4. Напишете заявка, която извежда имената на филми с дължина, по-голяма от
дължината на филма Star Wars.
*/
select m1.title
from movie as m1, movie as m2
where m2.Title = 'Star Wars' and m1.LENGTH > m2.LENGTH;
/*5. Напишете заявка, която извежда имената на продуцентите с нетни активи поголеми от тези на Stephen Spielberg*/
select m1.name
from movieexec as m1, MOVIEEXEC as m2
where m2.Name = 'Stephen Spielberg' and m1.NETWORTH > m2.NETWORTH;


use pc
/* II */
/*1. Напишете заявка, която извежда производителя и честотата на лаптопите с
размер на диска поне 9 GB.*/
select maker, laptop.speed
from product join laptop
on product.model = laptop.model
where hd >= 9
/*2. Напишете заявка, която извежда модел и цена на продуктите, произведени от
производител с име B.*/
select product.model, ivan.price
from product join(select model, price
from laptop
UNION
select model, price
from printer
UNION
select model, price
from pc) as ivan
on ivan.model = product.model
where product.maker = 'B'
/*3. Напишете заявка, която извежда производителите, които произвеждат лаптопи,
но не произвеждат персонални компютри*/
select maker
from product
where type = 'Laptop' or type = 'PC'
EXCEPT
select maker
from product
where type = 'PC'
/*4. Напишете заявка, която извежда размерите на тези дискове, които се предлагат
в поне два различни персонални компютъра (два компютъра с различен код)*/
select distinct p1.hd
from pc as p1, pc as p2
where p1.hd = p2.hd and p1.code != p2.code
/*5. Напишете заявка, която извежда двойките модели на персонални компютри,
които имат еднаква честота и памет. Двойките трябва да се показват само по
веднъж, например само (i, j), но не и (j, i).*/
select p1.model, p2.model
from pc as p1, pc as p2
where p1.speed = p2.speed and p1.ram = p2.ram and p1.model < p2.model
order by p1.model, p2.model;
/6. Напишете заявка, която извежда производителите на поне два различни
персонални компютъра с честота поне 400.*/
select distinct prd1.maker
from product as prd1, product as prd2, pc as pc1, pc as pc2
where pc1.speed >= 400 and pc2.speed >= 400 and prd1.model = pc1.model and prd2.model = pc2.model and prd1.maker = prd2.maker and pc1.code != pc2.code


/* III */
use ships
/*1. Напишете заявка, която извежда името на корабите с водоизместимост над
50000*/
select name
from ships
join classes
on ships.class = classes.CLASS
where classes.DISPLACEMENT > 50000
/*2. Напишете заявка, която извежда имената, водоизместимостта и броя оръдия на
всички кораби, участвали в битката при Guadalcanal*/
select ships.name, classes.DISPLACEMENT, classes.NUMGUNS
from outcomes
join ships
on OUTCOMES.ship = ships.NAME
join classes
on ships.class = classes.class
where battle = 'Guadalcanal'
/*3. Напишете заявка, която извежда имената на тези държави, които имат както
бойни кораби, така и бойни крайцери*/
select distinct c1.Country
from classes as c1, classes as c2
where c1.class != c2.class and c1.COUNTRY = c2.COUNTRY and ((c1.type = 'bb' and c2.type = 'bc') or (c1.type = 'bc' and c2.type = 'bb'))
/*4.Напишете заявка, която извежда имената на тези кораби, които са били
повредени в една битка, но по-късно са участвали в друга битка*/
select ships.name
from ships, outcomes as o1, battles as b1, outcomes as o2, battles as b2
where o1.ship=ships.name and b1.name = o1.battle and o2.ship = ships.name and b2.name = o2.battle and o1.result = 'damaged' and b2.date > b1.date




 








