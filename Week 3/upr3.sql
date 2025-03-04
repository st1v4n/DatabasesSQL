/*
/* I */
use movies
/*1. �������� ������, ����� ������� ������� �� ���������, ����� �� ���� �
���������� � ����� ������ ��� 10 �������.*/
select name
from moviestar
where gender = 'F' and name in (select name
from movieexec
where NETWORTH > 10000000)
/*2. �������� ������, ����� ������� ������� �� ���� ������� (���� � ����),
����� �� �� ����������*/
select name
from moviestar
where name not in (select name from movieexec)
/*3. �������� ������, ����� ������� ������� �� ������ ����� � �������,
��-������ �� ��������� �� ����� �Star Wars�*/
select title
from movie
where length > (select length from movie where title = 'Star Wars')
/*4. �������� ������, ����� ������� ������� �� ������������ � ������� ��
������� �� ������ �����, ����� �� ����������� �� ���������� � �����
������ ��-������ �� ���� �� �Merv Griffin*/
select name, title
from movieexec join movie
on cert# = PRODUCERC#
where networth > (select networth from movieexec where name = 'Merv Griffin')
*/
/*
/* II */
use pc
/*1. �������� ������, ����� ������� ��������������� �� ����������
�������� � ������� ��� 500*/
select distinct maker
from product join pc
on product.model = pc.model
where pc.speed > 500
/*2. �������� ������, ����� ������� ���, ����� � ���� �� ���������� � ��������� ����.*/
select code, model, price
from printer
where price >= ALL (select price from printer)
/*3. �������� ������, ����� ������� ���������, ����� ������� � ��-����� ��
��������� �� ������ ���������� ��������.*/
select *
from laptop
where speed < ALL (select speed from pc)
/*4. �������� ������, ����� ������� ������ � ������ �� �������� (PC,
������ ��� �������) � ���-������ ����*/
select top 1 T.model, T.price
from product join (select top 1 model, price from laptop order by price desc UNION
select top 1 model, price from pc order by price desc Union
select top 1 model, price from printer order by price desc) as T
on T.model = product.model
order by T.price desc
/*5. �������� ������, ����� ������� ������������� �� ������� ������� �
���-����� ����.*/
select top 1 maker
from product join printer
on product.model = printer.model
where price <= ALL (select price from printer where color = 'y')
order by price desc
/*6. �������� ������, ����� ������� ��������������� �� ���� ����������
�������� � ���-����� RAM �����, ����� ���� ���-����� ���������.*/
select maker
from product join pc
on product.model = pc.model
where ram <= ALL (select ram from pc) and speed >= ALL (select speed from pc where ram <= ALL (select ram from pc))
*/
/* III */
/*1. �������� ������, ����� ������� ��������, ����� ������ �� � ���-�����
���� ������.*/
use ships
select top 1 country
from classes
where numguns >= ALL (select numguns from classes)
/*2. �������� ������, ����� ������� ���������, �� ����� ���� ���� ��
�������� � ������� � �����.*/
select distinct classes.class
from outcomes join ships
on ship = name
join classes
on ships.class = classes.class
where result = 'sunk'
/*3. �������� ������, ����� ������� ����� � ����� �� �������� � 16 ������
������.*/
select name, ships.class
from ships join classes
on ships.class = classes.class
where bore = 16
/*4. �������� ������, ����� ������� ������� �� �������, � ����� ��
��������� ������ �� ���� �Kongo�.*/
select battle
from outcomes
where ship in (select name from ships where class = 'Kongo')
/*5. �������� ������, ����� ������� ����� � ����� �� ��������, ����� ����
������ � ��-����� ��� ����� �� ���� �� �������� ��� ����� �������
������.*/
select ships.class, name
from ships join classes
on ships.class = classes.class
where ships.class IN (select c1.class from classes as c1 where numguns >= ALL (select numguns from classes as c2 where c1.bore = c2.bore))



