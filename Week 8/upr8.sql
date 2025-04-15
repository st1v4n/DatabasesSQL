use upr150425
/* 1 */
create table Product(
model char(4),
maker char(1),
type varchar(7)
);
create table Printer(
code int,
model char(4),
price decimal(20,2),
);
INSERT INTO Product values ('abcd', 'A', 'laptop'), ('1234', 'C', 'pc'), ('5678', 'B', 'printer')
INSERT INTO Printer values (42, '5678', 20.67), (13, 'r2d2', 19.67), (66, 'l9d1', 23.44)
ALTER TABLE Printer
ADD type VARCHAR(6), color char(1) NOT NULL DEFAULT 'n'
ALTER TABLE Printer
DROP COLUMN price
SELECT * FROM Product
SELECT * FROM Printer
/*DROP TABLE PRODUCT
DROP TABLE PRINTER*/
/* 2 */
create table Users(
id int identity,
email varchar(64) not null,
password varchar(32) not null,
registerDate date not null
);
create table Friends(
idFirst int not null,
idSecond int not null
);
create table Walls(
userId int not null,
content varchar(1024) not null default '',
postDate date not null
);
create table Groups(
groupId int identity,
name varchar(64) not null,
description varchar(128) not null default ''
);
create table GroupMembers(
groupId int not null,
userId int not null
);
insert into Users values('ivan@gmail.com', 'abcd123', GETDATE()), ('petur@gmail.com', 'p099823', GETDATE())
insert into Friends values(1, 2)
insert into Walls values(1, 'hello, world!', GETDATE())
insert into Groups values('G20', 'our group!')
insert into GroupMembers values(1, 2), (1, 1)
select * from Users
select * from Friends
select * from Walls
select * from Groups
select * from GroupMembers

