/*
/* I */
use movies
/*1. Напишете заявка, която извежда имената на актрисите, които са също и
продуценти с нетни активи над 10 милиона.*/
select name
from moviestar
where gender = 'F' and name in (select name
from movieexec
where NETWORTH > 10000000)
/*2. Напишете заявка, която извежда имената на тези актьори (мъже и жени),
които не са продуценти*/
select name
from moviestar
where name not in (select name from movieexec)
/*3. Напишете заявка, която извежда имената на всички филми с дължина,
по-голяма от дължината на филма ‘Star Wars’*/
select title
from movie
where length > (select length from movie where title = 'Star Wars')
/*4. Напишете заявка, която извежда имената на продуцентите и имената на
филмите за всички филми, които са продуцирани от продуценти с нетни
активи по-големи от тези на ‘Merv Griffin*/
select name, title
from movieexec join movie
on cert# = PRODUCERC#
where networth > (select networth from movieexec where name = 'Merv Griffin')
*/
/*
/* II */
use pc
/*1. Напишете заявка, която извежда производителите на персонални
компютри с честота над 500*/
select distinct maker
from product join pc
on product.model = pc.model
where pc.speed > 500
/*2. Напишете заявка, която извежда код, модел и цена на принтерите с найвисока цена.*/
select code, model, price
from printer
where price >= ALL (select price from printer)
/*3. Напишете заявка, която извежда лаптопите, чиято честота е по-ниска от
честотата на всички персонални компютри.*/
select *
from laptop
where speed < ALL (select speed from pc)
/*4. Напишете заявка, която извежда модела и цената на продукта (PC,
лаптоп или принтер) с най-висока цена*/
select top 1 T.model, T.price
from product join (select top 1 model, price from laptop order by price desc UNION
select top 1 model, price from pc order by price desc Union
select top 1 model, price from printer order by price desc) as T
on T.model = product.model
order by T.price desc
/*5. Напишете заявка, която извежда производителя на цветния принтер с
най-ниска цена.*/
select top 1 maker
from product join printer
on product.model = printer.model
where price <= ALL (select price from printer where color = 'y')
order by price desc
/*6. Напишете заявка, която извежда производителите на тези персонални
компютри с най-малко RAM памет, които имат най-бързи процесори.*/
select maker
from product join pc
on product.model = pc.model
where ram <= ALL (select ram from pc) and speed >= ALL (select speed from pc where ram <= ALL (select ram from pc))
*/
/* III */
/*1. Напишете заявка, която извежда страните, чиито кораби са с най-голям
брой оръдия.*/
use ships
select top 1 country
from classes
where numguns >= ALL (select numguns from classes)
/*2. Напишете заявка, която извежда класовете, за които поне един от
корабите е потънал в битка.*/
select distinct classes.class
from outcomes join ships
on ship = name
join classes
on ships.class = classes.class
where result = 'sunk'
/*3. Напишете заявка, която извежда името и класа на корабите с 16 инчови
оръдия.*/
select name, ships.class
from ships join classes
on ships.class = classes.class
where bore = 16
/*4. Напишете заявка, която извежда имената на битките, в които са
участвали кораби от клас ‘Kongo’.*/
select battle
from outcomes
where ship in (select name from ships where class = 'Kongo')
/*5. Напишете заявка, която извежда класа и името на корабите, чиито брой
оръдия е по-голям или равен на този на корабите със същия калибър
оръдия.*/
select ships.class, name
from ships join classes
on ships.class = classes.class
where ships.class IN (select c1.class from classes as c1 where numguns >= ALL (select numguns from classes as c2 where c1.bore = c2.bore))



