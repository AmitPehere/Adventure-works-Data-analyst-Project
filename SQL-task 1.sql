create database sql_project;
use sql_project;
-- QUSETION 1
create table salespeople(
snum int unsigned,
sname varchar(40),
city varchar(40),
comm decimal(3,2));
insert into salespeople values
(1001,'Peel','London',0.12),
(1002,'Serres','San Jose',0.13),
(1003,'Axelrod','New York',0.10),
(1004,'Motika','London',0.11),
(1007,'Rafin','Barcelona',0.15),
(Null,Null,Null,Null);


select * from salespeople;

-- QUSETION 2
create table cust(
cnum int unsigned,
cname varchar(40),
city varchar(40),
rating int unsigned,
snum int unsigned);
insert into cust values
(2001,'Hoffman','London',100,1001),
(2002,'Giovanne','Rome',200,1003),
(2003,'Liu','San Jose',300,1002),
(2004,'Grass','Berlin',100,1002),
(2006,'Clemens','London',300,1007),
(2007,'Pereia','Rome',100,1004),
(2008,'James','London',200,1007),
(Null,Null,Null,Null,Null);

select * from cust;

-- QUSETION 3
create table orders(
onum int unsigned,
amt decimal(6,2),
odate DATE,
cnum int unsigned,
snum int unsigned);
insert into orders values
(3001,18.69,'1994-10-03',2008,1007),
(3002,1900.10,'1994-10-03',2007,1004),
(3003,767.19,'1994-10-03',2001,1001),
(3005,5160.45,'1994-10-03',2003,1002),
(3006,1098.16,'1994-10-04',2008,1007),
(3007,757.75,'1994-10-05',2004,1002),
(3008,4723.00,'1994-10-05',2006,1001),
(3009,1713.23,'1994-10-04',2002,1003),
(3010,1309.95,'1994-10-06',2004,1002),
(3011,9891.88,'1994-10-06',2006,1001),
(Null,Null,Null,Null,Null);

select * from orders;

-- QUSETION 4 Write a query to match the salespeople to the customers according to the city they are living.
select salesperson.sname AS "SalesPerson",
cust.cname AS "CustomerName",cust.city AS "City"
from salesperson,cust
WHERE salesperson.city=cust.city
order by city;

-- QUESTION 5 Write a query to select the names of customers and the salespersons who are providing service to them
select salesperson.sname AS "SalesPerson", cust.cname AS "CustomerName"
from salesperson,cust
WHERE salesperson.snum=cust.snum;

-- QUSETION 6 Write a query to find out all orders by customers not located in the same cities as that of their salespeople
select orders.onum AS "OrderNumber",cust.cname AS "CustomerName",salespeople.sname AS "Salesperson"
from orders,cust,salespeople 
WHERE cust.city<>salespeople.city
AND orders.cnum=cust.cnum
AND orders.snum=salespeople.snum;

-- QUESTION 7 	Write a query that lists each order number followed by name of customer who made that order
select orders.onum AS "OrderNumber",cust.cname AS "CustomerName"
from orders,cust
WHERE orders.cnum=cust.cnum;

-- QUESTION 8 Write a query that finds all pairs of customers having the same rating………………
select m.cname,n.cname,m.rating
from cust m, cust n
where m.rating=n.rating
AND m.cname<n.cname;
select * from cust order by rating;

-- QUSETION 9	Write a query to find out all pairs of customers served by a single salesperson………………..
Select c.cname AS "CustomerName",c.snum,s.sname
from cust c,salespeople s
where s.snum IN 
 (select snum 
  from cust
  group by snum
  having count(snum) >1);    
                
-- QUESTION 10	Write a query that produces all pairs of salespeople who are living in same city………………..
SELECT m.sname,n.sname,m.city
FROM salespeople m,salespeople n
WHERE m.city=n.city
  AND m.sname<n.sname;

-- QUESTION 11.	Write a Query to find all orders credited to the same salesperson who services Customer 2008
SELECT * FROM orders
WHERE snum =
    (SELECT DISTINCT snum
     FROM orders 
     WHERE cnum =2008);

-- QUESTION 12.	Write a Query to find out all orders that are greater than the average for Oct 4th
SELECT * FROM orders
WHERE amt>
    (SELECT  AVG(amt) 
     FROM orders
     WHERE odate ='1994-10-04');
          
-- QUESTION 13.	Write a Query to find all orders attributed to salespeople in London
SELECT * FROM orders
WHERE snum IN
    (SELECT snum 
     FROM salesperson
     WHERE city='London'); 
     
-- QUESTION 14.	Write a query to find all the customers whose cnum is 1000 above the snum of Serres. 
Select * from cust 
where cnum >
      ( select snum+1000
        from salespeople
        where sname ='Serres');    
        
-- QUESTION 15.	Write a query to count customers with ratings above San Jose’s average rating.
Select count(cnum) AS "No Of Customers"
from cust
where rating > 
	 ( select avg(rating)
	   from cust
	   where cust.city ='Berlin');
       
-- QUESTION 16.	Write a query to show each salesperson with multiple customers.
SELECT sname AS "SalesPerson Name",cname AS "Customer Name"
FROM salesperson
JOIN cust USING (snum);    
