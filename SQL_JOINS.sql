SET search_path To sales;
--SQL JOINS

/* Retrive all the data from customers and orders 
as seperate results*/


SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM products;
SELECT * FROM employees;

--INNER JOIN

SELECT c.customerid,c.firstname,o.orderid,o.sales 
	FROM customers c
	INNER JOIN orders o
ON c.customerid = o.customerid;

--LEFT JOIN

SELECT c.firstname,c.customerid,o.orderid
	FROM customers c 
	LEFT JOIN orders o 
ON c.customerid = o.customerid; 

--RIGHT JOIN
SELECT c.firstname,c.customerid,o.orderid
	FROM customers c 
	RIGHT JOIN orders o 
ON c.customerid = o.customerid; 

--FULL JOIN 

SELECT c.firstname,c.customerid,o.orderid
	FROM customers c 
	FULL JOIN orders o 
ON c.customerid = o.customerid;

--LEFT ANTI JOIN

SELECT c.customerid,c.firstname,o.orderid,o.sales
	FROM customers c
	LEFT JOIN orders o
	ON c.customerid = o.customerid
WHERE orderid IS NULL;

--FULL ANTI JOIN

SELECT c.firstname,c.customerid,o.orderid
	FROM customers c 
	FULL JOIN orders o 
	ON c.customerid = o.customerid
WHERE c.customerid IS NULL OR o.orderid IS NULL;
 

--CROSS JOIN

SELECT *
	FROM customers 
CROSS JOIN orders;

--MUTIPLE TABLES

SELECT o.orderid,
	o.sales,
	c.firstname AS customerfname,
	c.lastname AS customerlname,
	p.product,
	p.price,
	e.firstname AS employeefname,
	e.lastname AS employeelname
	FROM orders o
	LEFT JOIN customers c
ON c.customerid = o.customerid
	LEFT JOIN products p
ON o.productid = p.productid
	LEFT JOIN employees e
ON o.salespersonid = e.employeeid;






