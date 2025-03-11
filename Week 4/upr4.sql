
/* I. movies */
/*1. Íàïèøåòå çàÿâêà, êîÿòî èçâåæäà èìåòî íà ïðîäóöåíòà è èìåíàòà íà
ôèëìèòå, ïðîäóöèðàíè îò ïðîäóöåíòà íà ôèëìà ‘Star Wars’.*/
use movies
select Name, Title
from Movieexec join movie
on MOVIEEXEC.CERT# = movie.PRODUCERC#
where Name = (select name from movieexec join movie on MOVIEEXEC.CERT# = movie.PRODUCERC# where title='Star Wars')
/*2. Íàïèøåòå çàÿâêà, êîÿòî èçâåæäà èìåíàòà íà ïðîäóöåíòèòå íà ôèëìèòå, â
êîèòî å ó÷àñòâàë ‘Harrison Ford’*/
select distinct name
from movieexec join movie
on PRODUCERC#=CERT#
where title in (select title from movie join starsin on title = movietitle where starname = 'Harrison Ford')
/*3. Íàïèøåòå çàÿâêà, êîÿòî èçâåæäà èìåòî íà ñòóäèîòî è èìåíàòà íà
àêòüîðèòå, ó÷àñòâàëè âúâ ôèëìè, ïðîèçâåäåíè îò òîâà ñòóäèî, ïîäðåäåíè
ïî èìå íà ñòóäèî*/
select distinct studio.NAME, starsin.STARNAME
from Studio FULL join movie
on STUDIONAME=studio.name
FULL join starsin
on movietitle = title
where starname is not NULL
/*4. Íàïèøåòå çàÿâêà, êîÿòî èçâåæäà èìåíàòà íà àêòüîðèòå, ó÷àñòâàëè âúâ
ôèëìè íà ïðîäóöåíòè ñ íàé-ãîëåìè íåòíè àêòèâè.*/
select starname, networth, movietitle
from starsin full join movie 
on title = movietitle
full join movieexec 
on producerc# = cert#
where movieexec.name = 
(select name from movieexec where networth = (select top 1 networth from movieexec order by networth desc)) and starname is not null
/*5. Íàïèøåòå çàÿâêà, êîÿòî èçâåæäà èìåíàòà íà àêòüîðèòå, êîèòî íå ñà
ó÷àñòâàëè â íèòî åäèí ôèëì.*/
select moviestar.name, movietitle
from moviestar left join starsin
on name = starname
left join movie
on movietitle = title
where movietitle is null


/*II*/
/*1. Íàïèøåòå çàÿâêà, êîÿòî èçâåæäà ïðîèçâîäèòåë, ìîäåë è òèï íà ïðîäóêò çà
òåçè ïðîèçâîäèòåëè, çà êîèòî ñúîòâåòíèÿò ïðîäóêò íå ñå ïðîäàâà (íÿìà ãî
â òàáëèöèòå PC, Laptop èëè Printer).*/
use pc
select maker, model, type
from product
where model NOT IN
(select product.model from product left join pc on product.model = pc.model where pc.code is not NULL)
AND model NOT IN
(select product.model from product left join laptop on product.model = laptop.model where laptop.code is not NULL)
AND model NOT IN
(select product.model from product left join printer on product.model = printer.model where printer.code is not NULL)
/*2. Íàìåðåòå âñè÷êè ïðîèçâîäèòåëè, êîèòî ïðàâÿò êàêòî ëàïòîïè, òàêà è
ïðèíòåðè.*/
select distinct p1.maker
from product as p1, product as p2
where p1.maker = p2.maker and p1.model in
(select product.model from product join laptop on product.model = laptop.model)
and p2.model in
(select product.model from product join printer on product.model = printer.model)
/*3. Íàìåðåòå ðàçìåðèòå íà òåçè òâúðäè äèñêîâå, êîèòî ñå ïîÿâÿâàò â äâà èëè
ïîâå÷å ìîäåëà ëàïòîïè.*/
select distinct l1.hd
from laptop as l1, laptop as l2
where l1.model != l2.model and l1.hd = l2.hd
/*4. Íàìåðåòå âñè÷êè ìîäåëè ïåðñîíàëíè êîìïþòðè, êîèòî íÿìàò ðåãèñòðèðàí
ïðîèçâîäèòåë.*/
select * from pc left join product on pc.model = product.model
where type = 'PC' and maker is NULL

/*III*/
use ships
/*1. Íàïèøåòå çàÿâêà, êîÿòî èçâåæäà öÿëàòà íàëè÷íà èíôîðìàöèÿ çà âñåêè
êîðàá, âêëþ÷èòåëíî è äàííèòå çà íåãîâèÿ êëàñ. Â ðåçóëòàòà íå òðÿáâà äà
ñå âêëþ÷âàò òåçè êëàñîâå, êîèòî íÿìàò êîðàáè.*/
select *
from ships join classes
on ships.class = classes.CLASS
/*2. Ïîâòîðåòå ãîðíàòà çàÿâêà, êàòî òîçè ïúò âêëþ÷èòå â ðåçóëòàòà è êëàñîâåòå,
êîèòî íÿìàò êîðàáè, íî ñúùåñòâóâàò êîðàáè ñúñ ñúùîòî èìå êàòî òÿõíîòî*/
select *
from ships right join classes
on ships.class = classes.CLASS
/*3. Çà âñÿêà ñòðàíà èçâåäåòå èìåíàòà íà êîðàáèòå, êîèòî íèêîãà íå ñà
ó÷àñòâàëè â áèòêà.*/
select country, ships.name
from classes join ships
on ships.class = classes.class
left join outcomes
on outcomes.ship = ships.name
where outcomes.battle is NULL
/*4. Íàìåðåòå èìåíàòà íà âñè÷êè êîðàáè ñ ïîíå 7 îðúäèÿ, ïóñíàòè íà âîäà ïðåç
1916, íî íàðå÷åòå ðåçóëòàòíàòà êîëîíà Ship Name.*/
select ships.name as 'Ship Name'
from ships join classes
on ships.class = classes.class
where numguns >= 7 and launched = 1916
/*5. Èçâåäåòå èìåíàòà íà âñè÷êè ïîòúíàëè â áèòêà êîðàáè, èìåòî è äàòà íà
ïðîâåæäàíå íà áèòêèòå, â êîèòî òå ñà ïîòúíàëè. Ïîäðåäåòå ðåçóëòàòà ïî
èìå íà áèòêàòà.*/
select ship, battle, date
from outcomes join battles
on battle = name
where result = 'sunk'
order by battle
/*6. Íàìåðåòå èìåòî, âîäîèçìåñòèìîñòòà è ãîäèíàòà íà ïóñêàíå íà âîäà íà
âñè÷êè êîðàáè, êîèòî èìàò ñúùîòî èìå êàòî òåõíèÿ êëàñ.*/
select ships.name, bore, ships.LAUNCHED
from ships join classes
on ships.class = classes.class
where ships.name = classes.class
/*7. Íàìåðåòå âñè÷êè êëàñîâå êîðàáè, îò êîèòî íÿìà ïóñíàò íà âîäà íèòî åäèí
êîðàá.*/
select classes.class, type, country, numguns, bore, DISPLACEMENT
from classes left join ships 
on classes.class = ships.class
where ships.name is NULL
/*8. Èçâåäåòå èìåòî, âîäîèçìåñòèìîñòòà è áðîÿ îðúäèÿ íà êîðàáèòå,
ó÷àñòâàëè â áèòêàòà ‘North Atlantic’, à ñúùî è ðåçóëòàòà îò áèòêàòà*/
select ships.name, bore, numguns, result
from classes join ships
on classes.class = ships.class
join outcomes on outcomes.SHIP = ships.NAME
join battles on outcomes.battle = battles.name
where battles.name = 'North Atlantic'
