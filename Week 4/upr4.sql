
/* I. movies */
/*1. Напишете заявка, която извежда името на продуцента и имената на
филмите, продуцирани от продуцента на филма ‘Star Wars’.*/
use movies
select Name, Title
from Movieexec join movie
on MOVIEEXEC.CERT# = movie.PRODUCERC#
where Name = (select name from movieexec join movie on MOVIEEXEC.CERT# = movie.PRODUCERC# where title='Star Wars')
/*2. Напишете заявка, която извежда имената на продуцентите на филмите, в
които е участвал ‘Harrison Ford’*/
select distinct name
from movieexec join movie
on PRODUCERC#=CERT#
where title in (select title from movie join starsin on title = movietitle where starname = 'Harrison Ford')
/*3. Напишете заявка, която извежда името на студиото и имената на
актьорите, участвали във филми, произведени от това студио, подредени
по име на студио.*/
select distinct studio.NAME, starsin.STARNAME
from Studio FULL join movie
on STUDIONAME=studio.name
FULL join starsin
on movietitle = title
where starname is not NULL
/*4. Напишете заявка, която извежда имената на актьорите, участвали във
филми на продуценти с най-големи нетни активи*/
select starname, networth, movietitle
from starsin full join movie 
on title = movietitle
full join movieexec 
on producerc# = cert#
where movieexec.name = 
(select name from movieexec where networth = (select top 1 networth from movieexec order by networth desc)) and starname is not null
/*5. Напишете заявка, която извежда имената на актьорите, които не са
участвали в нито един филм*/
select moviestar.name, movietitle
from moviestar left join starsin
on name = starname
left join movie
on movietitle = title
where movietitle is null


/*II*/
/*1. Напишете заявка, която извежда производител, модел и тип на продукт за
тези производители, за които съответният продукт не се продава (няма го
в таблиците PC, Laptop или Printer)*/
use pc
select maker, model, type
from product
where model NOT IN
(select product.model from product left join pc on product.model = pc.model where pc.code is not NULL)
AND model NOT IN
(select product.model from product left join laptop on product.model = laptop.model where laptop.code is not NULL)
AND model NOT IN
(select product.model from product left join printer on product.model = printer.model where printer.code is not NULL)
/*2. Намерете всички производители, които правят както лаптопи, така и
принтери*/
select distinct p1.maker
from product as p1, product as p2
where p1.maker = p2.maker and p1.model in
(select product.model from product join laptop on product.model = laptop.model)
and p2.model in
(select product.model from product join printer on product.model = printer.model)
/*3. Намерете размерите на тези твърди дискове, които се появяват в два или
повече модела лаптопи*/
select distinct l1.hd
from laptop as l1, laptop as l2
where l1.model != l2.model and l1.hd = l2.hd
/*4. Намерете всички модели персонални компютри, които нямат регистриран
производител*/
select * from pc left join product on pc.model = product.model
where type = 'PC' and maker is NULL

/*III*/
use ships
/*1. Напишете заявка, която извежда цялата налична информация за всеки
кораб, включително и данните за неговия клас. В резултата не трябва да
се включват тези класове, които нямат кораби*/
select *
from ships join classes
on ships.class = classes.CLASS
/*2. Повторете горната заявка, като този път включите в резултата и класовете,
които нямат кораби, но съществуват кораби със същото име като тяхното*/
select *
from ships right join classes
on ships.class = classes.CLASS
/*3. За всяка страна изведете имената на корабите, които никога не са
участвали в битка*/
select country, ships.name
from classes join ships
on ships.class = classes.class
left join outcomes
on outcomes.ship = ships.name
where outcomes.battle is NULL
/*4. Намерете имената на всички кораби с поне 7 оръдия, пуснати на вода през
1916, но наречете резултатната колона Ship Name.*/
select ships.name as 'Ship Name'
from ships join classes
on ships.class = classes.class
where numguns >= 7 and launched = 1916
/*5. Изведете имената на всички потънали в битка кораби, името и дата на
провеждане на битките, в които те са потънали. Подредете резултата по
име на битката*/
select ship, battle, date
from outcomes join battles
on battle = name
where result = 'sunk'
order by battle
/*6. Намерете името, водоизместимостта и годината на пускане на вода на
всички кораби, които имат същото име като техния клас*/
select ships.name, bore, ships.LAUNCHED
from ships join classes
on ships.class = classes.class
where ships.name = classes.class
/*7. Намерете всички класове кораби, от които няма пуснат на вода нито един
кораб*/
select classes.class, type, country, numguns, bore, DISPLACEMENT
from classes left join ships 
on classes.class = ships.class
where ships.name is NULL
/*8. Изведете името, водоизместимостта и броя оръдия на корабите,
участвали в битката ‘North Atlantic’, а също и резултата от битката*/
select ships.name, bore, numguns, result
from classes join ships
on classes.class = ships.class
join outcomes on outcomes.SHIP = ships.NAME
join battles on outcomes.battle = battles.name
where battles.name = 'North Atlantic'
