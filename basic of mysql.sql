select *  from sql_store.customers

--basic MYSQL query run--

-- select statement--

select *
from sql_store.customers

-- RUN THE QUERY OF ONLY FIND THE CUSTOMER_ID 6--

select *
from sql_store.customers
where customer_id = '6'

--run query for multiple customers_id select--

select * 
from sql_store.customers
where customer_id in ('6','7')


-- run the query for find the first_name just freddi--


select * 
from sql_store.customers
where first_name = 'freddi'

-- same query find data in like fuction used --

select *
from sql_store.customers
where first_name like 'freddi'

-- rune query for first carector of data find --

select  *
from sql_store.customers
where first_name regexp '^F'


-- run query for between used and find data multiple amount just used i points --

select *
from sql_store.customers
where points between 1000 and 2000
order by points

-- how find only customerid 1 to 6--

select *
from sql_store.customers
where customer_id limit 6

-- how to find null data --

select *
from sql_store.customers
where phone is null

-- not null --
select *
from sql_store.customers
where phone is not  null

--run the query for odrer by data found and also used desc--

select *
from sql_store.customers
order by first_name


select *
from sql_store.customers
order by first_name desc 

-- run the query olny limited column used find the data first_name,last_name,city,points--

select first_name,last_name,city,points
from sql_store.customers
order by first_name

--run the query for points is increase * 10--

select points,(points * 10)
from sql_store.customers
order by points desc

--find the highst points --

select *,points,max(points)
from sql_store.customers
where points in (select max(points) from sql_store.customers)

--multipul query run --

select points,'upper' as type
from sql_store.customers
where points > 1000
union
select points,'lower'  as type
from sql_store.customers
where points < 1000


--join multiple tables --

select * 
from sql_store.customers c
join sql_store.products p
on c.customer_id = p.product_id

--limited column used --

select c.first_name,c.last_name,c.points, p.quantity_in_stock,p.unit_price
from sql_store.customers c
join sql_store.products p
on c.customer_id = p.product_id

-- run multiple table and multiple query rum--

select c.first_name,c.last_name,c.points, p.quantity_in_stock,p.unit_price
from sql_store.customers c
join sql_store.products p
on c.customer_id = p.product_id
where c.points < 1000
and p.quantity_in_stock < 100




--creat new table --

create table customervsproducts as
select c.first_name,c.last_name,c.points, p.quantity_in_stock,p.unit_price
from sql_store.customers c
join sql_store.products p
on c.customer_id = p.product_id
where c.points < 1000
and p.quantity_in_stock < 100


--oly header name create table --

create table project as 
SELECT * FROM portfolioproject.customervsproducts
where 1=0


--insert data--
 
insert into portfolioproject.project
select c.first_name,c.last_name,c.points, p.quantity_in_stock,p.unit_price
from sql_store.customers c
join sql_store.products p
on c.customer_id = p.product_id
where c.points < 1000
and p.quantity_in_stock < 100

select * from portfolioproject.project

--delete data--
delete from portfolioproject.project

--update for first name is ines points update 5600--

update portfolioproject.project
set points  = 5600
where first_name = 'Ines' 

--table unit_price colum delete --

alter table portfolioproject.project
drop column unit_price

--how it posible first name two alpabeth find --

select substr(first_name,1,2)
from portfolioproject.project

--mage first-name and last_name--

select *, concat(first_name,' ',last_name) as full_name
from portfolioproject.project