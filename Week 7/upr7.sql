/*I*/
use movies
/* 1 */
Insert into moviestar(name, BIRTHDATE)
values ('Nicole Kidman', '1967-06-20')
/* 2 */
Delete from movieexec
where networth <30000000
/* 3 */
delete from moviestar
where address is NULL
select * from movieexec
select * from moviestar
/*II*/
use pc 
/* 4 */
Insert into pc
values (12, '1100', 2400, 2048, 500, '52x', 299)
Insert into product
values ('C', '1100', 'pc')
/* 5 */
Delete from pc
where model = '1100'
/* 6 */
delete from laptop
where model in (select laptop.model from laptop join product on laptop.model=product.model where maker not in (select maker
from product join printer on printer.model = product.model))
/* 7 */
Update product
set maker = 'A'
where maker = 'B'
/* 8 */
update pc
set price = price*0.5,
    hd = hd+20
/* 9 */
update laptop
set screen = screen + 1
where model in (select laptop.model from product join laptop on laptop.model=product.model where maker = 'B')
select * from laptop
select * from product
select * from pc
/* III */
/* 10 */
use ships
insert into ships
values ('Nelson', 'Nelson', 1927),
       ('Rodney', 'Nelson', 1927)
insert into classes
values ('Nelson', 'bs', 'Britain', NULL, 16, 34000)
/* 11 */
delete from ships
where name in (select ship from outcomes where result = 'sunk')
/* 12 */
update classes
set bore = bore*2.5,
    displacement = displacement/1.1
select * from classes
select * from ships

       
