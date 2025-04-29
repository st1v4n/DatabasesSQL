use exam09

create table airline(
code int not null PRIMARY KEY,
name varchar(50) not null UNIQUE,
country varchar(50) not null,
)

create table agency(
name varchar(50) not null PRIMARY KEY,
country varchar(50) not null,
city varchar(50) not null,
phone char(10) 
)

create table airplane(
code int not null PRIMARY KEY,
type char(1) not null,
seats int not null,
year date not null,
CHECK(seats >= 0)
)

create table airport(
code int not null PRIMARY KEY,
name varchar(50) not null,
country varchar(50) not null,
city varchar(50) not null,
UNIQUE(name, country)
)

create table flight(
fnumber int not null PRIMARY KEY,
airline_operator int not null REFERENCES airline(code),
dep_airport int not null REFERENCES airport(code),
arr_airport int not null REFERENCES airport(code),
flight_time time not null,
flight_duration time not null,
airplane int not null REFERENCES airplane(code)
)

create table customer(
id int not null PRIMARY KEY,
fname varchar(50) not null,
lname varchar(50) not null,
email varchar(50) not null,
CHECK(email LIKE '%@%' and email LIKE '%.%' and LEN(email) >= 6)
)

create table booking(
code int not null PRIMARY KEY,
agency varchar(50) not null REFERENCES agency(name),
airline_code int not null REFERENCES airline(code),
flight_number int not null REFERENCES flight(fnumber),
customer_id int not null REFERENCES customer(id),
booking_date date not null,
flight_date date not null,
price int not null,
status char(1) not null,
CHECK(flight_date >= booking_date and status in ('0', '1'))
)


