
/* I. movies */
/*1. �������� ������, ����� ������� ����� �� ���������� � ������� ��
�������, ����������� �� ���������� �� ����� �Star Wars�.*/
use movies
select Name, Title
from Movieexec join movie
on MOVIEEXEC.CERT# = movie.PRODUCERC#
where Name = (select name from movieexec join movie on MOVIEEXEC.CERT# = movie.PRODUCERC# where title='Star Wars')
/*2. �������� ������, ����� ������� ������� �� ������������ �� �������, �
����� � �������� �Harrison Ford�*/
select distinct name
from movieexec join movie
on PRODUCERC#=CERT#
where title in (select title from movie join starsin on title = movietitle where starname = 'Harrison Ford')
/*3. �������� ������, ����� ������� ����� �� �������� � ������� ��
���������, ��������� ��� �����, ����������� �� ���� ������, ���������
�� ��� �� ������*/
select distinct studio.NAME, starsin.STARNAME
from Studio FULL join movie
on STUDIONAME=studio.name
FULL join starsin
on movietitle = title
where starname is not NULL
/*4. �������� ������, ����� ������� ������� �� ���������, ��������� ���
����� �� ���������� � ���-������ ����� ������.*/
select starname, networth, movietitle
from starsin full join movie 
on title = movietitle
full join movieexec 
on producerc# = cert#
where movieexec.name = 
(select name from movieexec where networth = (select top 1 networth from movieexec order by networth desc)) and starname is not null
/*5. �������� ������, ����� ������� ������� �� ���������, ����� �� ��
��������� � ���� ���� ����.*/
select moviestar.name, movietitle
from moviestar left join starsin
on name = starname
left join movie
on movietitle = title
where movietitle is null


/*II*/
/*1. �������� ������, ����� ������� ������������, ����� � ��� �� ������� ��
���� �������������, �� ����� ����������� ������� �� �� ������� (���� ��
� ��������� PC, Laptop ��� Printer).*/
use pc
select maker, model, type
from product
where model NOT IN
(select product.model from product left join pc on product.model = pc.model where pc.code is not NULL)
AND model NOT IN
(select product.model from product left join laptop on product.model = laptop.model where laptop.code is not NULL)
AND model NOT IN
(select product.model from product left join printer on product.model = printer.model where printer.code is not NULL)
/*2. �������� ������ �������������, ����� ������ ����� �������, ���� �
��������.*/
select distinct p1.maker
from product as p1, product as p2
where p1.maker = p2.maker and p1.model in
(select product.model from product join laptop on product.model = laptop.model)
and p2.model in
(select product.model from product join printer on product.model = printer.model)
/*3. �������� ��������� �� ���� ������ �������, ����� �� �������� � ��� ���
������ ������ �������.*/
select distinct l1.hd
from laptop as l1, laptop as l2
where l1.model != l2.model and l1.hd = l2.hd
/*4. �������� ������ ������ ���������� ��������, ����� ����� �����������
������������.*/
select * from pc left join product on pc.model = product.model
where type = 'PC' and maker is NULL

/*III*/
use ships
/*1. �������� ������, ����� ������� ������ ������� ���������� �� �����
�����, ����������� � ������� �� ������� ����. � ��������� �� ������ ��
�� �������� ���� �������, ����� ����� ������.*/
select *
from ships join classes
on ships.class = classes.CLASS
/*2. ��������� ������� ������, ���� ���� ��� �������� � ��������� � ���������,
����� ����� ������, �� ����������� ������ ��� ������ ��� ���� �������*/
select *
from ships right join classes
on ships.class = classes.CLASS
/*3. �� ����� ������ �������� ������� �� ��������, ����� ������ �� ��
��������� � �����.*/
select country, ships.name
from classes join ships
on ships.class = classes.class
left join outcomes
on outcomes.ship = ships.name
where outcomes.battle is NULL
/*4. �������� ������� �� ������ ������ � ���� 7 ������, ������� �� ���� ����
1916, �� �������� ������������ ������ Ship Name.*/
select ships.name as 'Ship Name'
from ships join classes
on ships.class = classes.class
where numguns >= 7 and launched = 1916
/*5. �������� ������� �� ������ �������� � ����� ������, ����� � ���� ��
���������� �� �������, � ����� �� �� ��������. ��������� ��������� ��
��� �� �������.*/
select ship, battle, date
from outcomes join battles
on battle = name
where result = 'sunk'
order by battle
/*6. �������� �����, ����������������� � �������� �� ������� �� ���� ��
������ ������, ����� ���� ������ ��� ���� ������ ����.*/
select ships.name, bore, ships.LAUNCHED
from ships join classes
on ships.class = classes.class
where ships.name = classes.class
/*7. �������� ������ ������� ������, �� ����� ���� ������ �� ���� ���� ����
�����.*/
select classes.class, type, country, numguns, bore, DISPLACEMENT
from classes left join ships 
on classes.class = ships.class
where ships.name is NULL
/*8. �������� �����, ����������������� � ���� ������ �� ��������,
��������� � ������� �North Atlantic�, � ���� � ��������� �� �������*/
select ships.name, bore, numguns, result
from classes join ships
on classes.class = ships.class
join outcomes on outcomes.SHIP = ships.NAME
join battles on outcomes.battle = battles.name
where battles.name = 'North Atlantic'
