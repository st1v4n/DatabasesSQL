
use movies

/* I */
/* 1. Напишете заявка, която извежда адреса на студио ‘Disney’ */
Select ADDRESS
from Studio
where NAME = 'Disney'
/* 2. Напишете заявка, която извежда рождената дата на актьора Jack
Nicholson */
Select Birthdate
from MOVIESTAR
where NAME = 'Jack Nicholson'
/* 3. Напишете заявка, която извежда имената на актьорите, които са
участвали във филм от 1980 или във филм, в чието заглавие има думата
‘Knight’ */
Select STARNAME 
from STARSIN
where MOVIEYEAR = 1980 OR MOVIETITLE LIKE '%Knight%'
/*4. Напишете заявка, която извежда имената на продуцентите с нетни
активи над 10 000 000 долара*/
Select Name
from MOVIEEXEC
where NETWORTH > 10000000
/* 5. Напишете заявка, която извежда имената на актьорите, които са мъже
или живеят на Prefect Rd. */
select Name
from MOVIESTAR
where ADDRESS = 'Prefect Rd.' OR GENDER = 'M'

/* II */
use pc
/* 1. Напишете заявка, която извежда модел, честота и размер на диска за
всички персонални компютри с цена под 1200 долара. Задайте
псевдоними за атрибутите честота и размер на диска, съответно MHz и
GB */
select model, speed as MHz, hd as GB
from laptop
where price < 1200
/* 2. Напишете заявка, която извежда производителите на принтери без
повторения*/
select distinct maker
from product
where type = 'Printer'
/* 3. Напишете заявка, която извежда модел, размер на паметта, размер на
екран за лаптопите, чиято цена е над 1000 долара */
select model, ram, screen 
from laptop
where price > 1000
/* 4. Напишете заявка, която извежда всички цветни принтери */
select *
from printer
where color != 'n'
/* 5. Напишете заявка, която извежда модел, честота и размер на диска за
тези персонални компютри със CD 12x или 16x и цена под 2000 долара.*/
select model, speed, hd
from pc
where (cd = '12x' or cd = '16x') and (price < 2000)

/* III */
use ships
/*1. Напишете заявка, която извежда класа и страната за всички класове с помалко от 10 оръдия.*/
select CLASS, COUNTRY
from CLASSES
where NUMGUNS < 10
/*2. Напишете заявка, която извежда имената на корабите, пуснати на вода
преди 1918. Задайте псевдоним shipName на колоната.*/
select NAME as shipName
from SHIPS
where LAUNCHED < 1918
/*3. Напишете заявка, която извежда имената на корабите потънали в битка и
имената на съответните битки.*/
select Ship, Battle
from OUTCOMES
where RESULT = 'sunk'
/*4. Напишете заявка, която извежда имената на корабите с име, съвпадащо
с името на техния клас.*/
select Name
from SHIPS
where Name = Class
/*5. Напишете заявка, която извежда имената на корабите, които започват с
буквата R.*/
select Name
from Ships
where Name like 'R%'
/*6. Напишете заявка, която извежда имената на корабите, които съдържат 2
или повече думи.*/
select Name
from Ships
where Name like '% %'

