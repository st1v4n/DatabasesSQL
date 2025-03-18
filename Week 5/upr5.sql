
use pc
/* I. PC */
/*1. �������� ������, ����� ������� �������� ������� �� ������������ ��������. */
select convert(decimal(5,2), avg(speed)) as avg_speed
from pc
/*2. �������� ������, ����� ������� ������� ������ �� �������� �� ��������� �� ����� ������������. */
select maker, avg(screen) as avg_screen
from laptop join product on product.model=laptop.model
group by maker
/*3. �������� ������, ����� ������� �������� ������� �� ��������� � ���� ��� 1000. */
select convert(decimal(5,2),avg(speed)) as avg_price
from laptop
where price > 1000
/*4. �������� ������, ����� ������� �������� ���� �� ������������ ��������, ����������� �� ������������ �A�. */
select convert(decimal(5,2),avg(price)) as avg_price
from pc join product on product.model=pc.model
where maker = 'A'
/*5. �������� ������, ����� ������� �������� ���� �� ������������ �������� � ��������� �� ������������ �B�. */
select avg(price) as avg_price
from ((select model, price from laptop) UNION ALL (select model, price from pc)) as T
join product on product.model = T.model
where maker = 'B'
/*6. �������� ������, ����� ������� �������� ���� �� ������������ �������� ������ ���������� �� �������. */
select speed, avg(price) as avg_price
from pc
GROUP BY speed
/*7. �������� ������, ����� ������� ���������������, ����� �� ��������� ���� 3 �������� ���������� ��������� (� �������� ���). */
select maker, COUNT(*) as numberOFPC from product join pc on product.model = pc.model 
GROUP BY maker
HAVING COUNT(*) >=3
/*8. �������� ������, ����� ������� ��������������� � ���-������ ���� �� ���������� ��������.*/
select TOP 1 maker, MAX(price) as max_price from product join pc on pc.model=product.model GROUP BY MAKER ORDER BY max_price DESC
/*9. �������� ������, ����� ������� �������� ���� �� ������������ �������� �� ����� ������� ��-������ �� 800. */
select speed, avg(price) as avg_price from pc where speed > 800 GROUP BY speed
/*10. �������� ������, ����� ������� ������� ������ �� ����� �� ���� ���������� ��������, ����������� �� �������������, ����� ����������� � ��������. ���������� �� �� ������ �� ����� ������� ������������.*/
select maker, avg(hd) as avg_hd from product join pc on product.model = pc.model where maker in(select maker from product join printer on product.model=printer.model)
group by maker

use ships
/*1. �������� ������, ����� ������� ���� �� ��������� ����� ������.*/
select count(Class) as count
from classes
where type = 'bb'
/*2. �������� ������, ����� ������� ������� ���� ������ �� ����� ���� ���� �����.*/
select class, avg(numguns) as avg_numguns
from classes
where type = 'bb'
group by class
/*3. �������� ������, ����� ������� ������� ���� ������ �� ������ ����� ������.*/
select avg(numguns) as avg_numguns
from classes
/*4. �������� ������, ����� ������� �� ����� ���� ������� � ���������� ������, �
����� ����� �� ���������� ���� � ������ �� ����.*/
select class, min(launched) as firstYear, min(launched) as lastYear
from ships
group by class
/*5. �������� ������, ����� ������� ���� �� ��������, �������� � ����� ������
�����.*/
select class, count(ship) as count
from outcomes join ships on ships.name = outcomes.ship
where result = 'sunk'
group by class
/*6. �������� ������, ����� ������� ���� �� ��������, �������� � ����� ������
�����, �� ���� ������� � ������ �� 2 ������.*/
select class, count(ship) as count
from outcomes join ships on ships.name = outcomes.ship
where result = 'sunk' and class in(select s1.class from ships as s1, ships as s2 where s1.name != s2.name and s1.class = s2.class)
group by class
/*7. �������� ������, ����� ������� ������� ������� �� �������� �� �������� ��
����� ������*/
select country, avg(bore) as avg_bore
from classes join ships on ships.class = classes.class
group by country