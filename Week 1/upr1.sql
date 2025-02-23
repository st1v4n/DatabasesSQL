
use movies

/* I */
/* 1. �������� ������, ����� ������� ������ �� ������ �Disney� */
Select ADDRESS
from Studio
where NAME = 'Disney'
/* 2. �������� ������, ����� ������� ��������� ���� �� ������� Jack
Nicholson */
Select Birthdate
from MOVIESTAR
where NAME = 'Jack Nicholson'
/* 3. �������� ������, ����� ������� ������� �� ���������, ����� ��
��������� ��� ���� �� 1980 ��� ��� ����, � ����� �������� ��� ������
�Knight� */
Select STARNAME 
from STARSIN
where MOVIEYEAR = 1980 OR MOVIETITLE LIKE '%Knight%'
/*4. �������� ������, ����� ������� ������� �� ������������ � �����
������ ��� 10 000 000 ������*/
Select Name
from MOVIEEXEC
where NETWORTH > 10000000
/* 5. �������� ������, ����� ������� ������� �� ���������, ����� �� ����
��� ������ �� Prefect Rd. */
select Name
from MOVIESTAR
where ADDRESS = 'Prefect Rd.' OR GENDER = 'M'

/* II */
use pc
/* 1. �������� ������, ����� ������� �����, ������� � ������ �� ����� ��
������ ���������� �������� � ���� ��� 1200 ������. �������
���������� �� ���������� ������� � ������ �� �����, ��������� MHz �
GB */
select model, speed as MHz, hd as GB
from laptop
where price < 1200
/* 2. �������� ������, ����� ������� ��������������� �� �������� ���
����������*/
select distinct maker
from product
where type = 'Printer'
/* 3. �������� ������, ����� ������� �����, ������ �� �������, ������ ��
����� �� ���������, ����� ���� � ��� 1000 ������ */
select model, ram, screen 
from laptop
where price > 1000
/* 4. �������� ������, ����� ������� ������ ������ �������� */
select *
from printer
where color != 'n'
/* 5. �������� ������, ����� ������� �����, ������� � ������ �� ����� ��
���� ���������� �������� ��� CD 12x ��� 16x � ���� ��� 2000 ������.*/
select model, speed, hd
from pc
where (cd = '12x' or cd = '16x') and (price < 2000)

/* III */
use ships
/*1. �������� ������, ����� ������� ����� � �������� �� ������ ������� � ������� �� 10 ������.*/
select CLASS, COUNTRY
from CLASSES
where NUMGUNS < 10
/*2. �������� ������, ����� ������� ������� �� ��������, ������� �� ����
����� 1918. ������� ��������� shipName �� ��������.*/
select NAME as shipName
from SHIPS
where LAUNCHED < 1918
/*3. �������� ������, ����� ������� ������� �� �������� �������� � ����� �
������� �� ����������� �����.*/
select Ship, Battle
from OUTCOMES
where RESULT = 'sunk'
/*4. �������� ������, ����� ������� ������� �� �������� � ���, ���������
� ����� �� ������ ����.*/
select Name
from SHIPS
where Name = Class
/*5. �������� ������, ����� ������� ������� �� ��������, ����� �������� �
������� R.*/
select Name
from Ships
where Name like 'R%'
/*6. �������� ������, ����� ������� ������� �� ��������, ����� �������� 2
��� ������ ����.*/
select Name
from Ships
where Name like '% %'

