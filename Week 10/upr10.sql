/*1*/
CREATE VIEW v1 (company, fnum, passagers)
AS
SELECT NAME, FLIGHT_NUMBER, COUNT(ID) as cnt
from BOOKINGS JOIN AIRLINES on AIRLINES.CODE = BOOKINGS.AIRLINE_CODE
join CUSTOMERS on CUSTOMER_ID = CUSTOMERS.ID
GROUP BY NAME, FLIGHT_NUMBER

SELECT * from v1
/*2*/
CREATE VIEW airline_info 
AS
SELECT Customers.FNAME, Customers.LNAME, id FROM Customers
WHERE id IN (SELECT customer_id FROM Bookings as b
GROUP BY agency, customer_id
HAVING COUNT(customer_id) >= 
(SELECT TOP 1 COUNT(customer_id) from Bookings WHERE Bookings.agency=b.agency
GROUP BY agency, customer_id
ORDER BY COUNT(customer_id) DESC))

SELECT * FROM airline_info
/*3*/
CREATE VIEW sofia_agencies
as
SELECT * from AGENCIES WHERE CITY = 'Sofia' WITH CHECK OPTION

select * from sofia_agencies
/*4*/
CREATE VIEW null_agencies
as
SELECT * from AGENCIES WHERE PHONE is NULL WITH CHECK OPTION

select * from null_agencies

DROP VIEW null_agencies
DROP VIEW sofia_agencies
DROP VIEW airline_info
DROP VIEW v1

USE PC

/*8*/
CREATE INDEX idx_model_product ON PRODUCT(model)
CREATE INDEX 
/*9*/
/*same thing*/
/*10*/
DROP INDEX idx_model_product on PRODUCT
