
use pc
/* I. PC */
/*1. Напишете заявка, която извежда средната честота на персоналните компютри.*/
select convert(decimal(5,2), avg(speed)) as avg_speed
from pc
/*2. Напишете заявка, която извежда средния размер на екраните на лаптопите за
всеки производител */
select maker, avg(screen) as avg_screen
from laptop join product on product.model=laptop.model
group by maker
/*3. Напишете заявка, която извежда средната честота на лаптопите с цена над 1000. */
select convert(decimal(5,2),avg(speed)) as avg_price
from laptop
where price > 1000
/*4. Напишете заявка, която извежда средната цена на персоналните компютри,
произведени от производител ‘A’.*/
select convert(decimal(5,2),avg(price)) as avg_price
from pc join product on product.model=pc.model
where maker = 'A'
/*5. Напишете заявка, която извежда средната цена на персоналните компютри и
лаптопите за производител ‘B */
select avg(price) as avg_price
from ((select model, price from laptop) UNION ALL (select model, price from pc)) as T
join product on product.model = T.model
where maker = 'B'
/*6. Напишете заявка, която извежда средната цена на персоналните компютри
според различните им честоти. */
select speed, avg(price) as avg_price
from pc
GROUP BY speed
/*7. Напишете заявка, която извежда производителите, които са произвели поне 3
различни персонални компютъра (с различен код).*/
select maker, COUNT(*) as numberOFPC from product join pc on product.model = pc.model 
GROUP BY maker
HAVING COUNT(*) >=3
/*8. Напишете заявка, която извежда производителите с най-висока цена на
персонален компютър.*/
select TOP 1 maker, MAX(price) as max_price from product join pc on pc.model=product.model GROUP BY MAKER ORDER BY max_price DESC
/*9. Напишете заявка, която извежда средната цена на персоналните компютри за
всяка честота по-голяма от 800*/
select speed, avg(price) as avg_price from pc where speed > 800 GROUP BY speed
/*10.Напишете заявка, която извежда средния размер на диска на тези персонални
компютри, произведени от производители, които произвеждат и принтери.
Резултатът да се изведе за всеки отделен производител.*/
select maker, avg(hd) as avg_hd from product join pc on product.model = pc.model where maker in(select maker from product join printer on product.model=printer.model)
group by maker

use ships
/*1. Напишете заявка, която извежда броя на класовете бойни кораби*/
select count(Class) as count
from classes
where type = 'bb'
/*2. Напишете заявка, която извежда средния брой оръдия за всеки клас боен кораб.
*/
select class, avg(numguns) as avg_numguns
from classes
where type = 'bb'
group by class
/*3. Напишете заявка, която извежда средния брой оръдия за всички бойни кораби.*/
select avg(numguns) as avg_numguns
from classes
/*4. Напишете заявка, която извежда за всеки клас първата и последната година, в
която кораб от съответния клас е пуснат на вода.*/
select class, min(launched) as firstYear, min(launched) as lastYear
from ships
group by class
/*5. Напишете заявка, която извежда броя на корабите, потънали в битка според
класа*/
select class, count(ship) as count
from outcomes join ships on ships.name = outcomes.ship
where result = 'sunk'
group by class
/*6. Напишете заявка, която извежда броя на корабите, потънали в битка според
класа, за тези класове с повече от 2 кораба*/
select class, count(ship) as count
from outcomes join ships on ships.name = outcomes.ship
where result = 'sunk' and class in(select s1.class from ships as s1, ships as s2 where s1.name != s2.name and s1.class = s2.class)
group by class
/*7. Напишете заявка, която извежда средния калибър на оръдията на корабите за
всяка страна*/
select country, avg(bore) as avg_bore
from classes join ships on ships.class = classes.class
group by country
