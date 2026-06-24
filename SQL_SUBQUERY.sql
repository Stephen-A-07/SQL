SET search_path TO 'sales';

--SUBQUERY

--scalar query-returns only single value
--row query- returns multiple rows
--table query- returns multiple rows and cols

--subquery using from clause
-- use temporary table for the main query

SELECT 
* 
FROM(
	SELECT
		*,
		AVG(price) OVER() Avgsales
	FROM products)t 
WHERE Avgsales < price;


SELECT 
	customerid,
	sumofsales,
	ROW_NUMBER() OVER(ORDER BY sumofsales DESC) 
FROM(
	SELECT 
		customerid,
		SUM(sales) sumofsales
	FROM orders
	GROUP BY customerid
)t;


--SELECT CLAUSE
--rule the selct sub query only excepts a scalar output query which returns a singe value
SELECT 
	productid,
	product,
	price,
	(SELECT COUNT(*) FROM orders) Totalorders 
FROM products;


--JOIN CLAUSE
SELECT * 
FROM customers c
LEFT JOIN(
SELECT customerid,COUNT(*)  FROM orders GROUP BY customerid
) o ON c.customerid = o.customerid;

--COMPARISION OPERATORS

--WHERE CLAUSE(Scalar)

SELECT 
	productid,
	price 
FROM products 
WHERE (SELECT AVG(price) FROM products) < price;

--IN and NOT IN OPERATOR
--filtering in a list

SELECT * 
FROM orders 
WHERE customerid IN (
	SELECT customerid
	FROM customers 
	WHERE country = 'Germany'
);

SELECT * 
FROM orders 
WHERE customerid NOT IN (
	SELECT customerid
	FROM customers 
	WHERE country = 'Germany'
);


--ANY and ALL OPERATOR

SELECT 
	employeeid,
	firstname,
	salary
FROM employees 
WHERE gender = 'F' AND salary > ANY (SELECT salary FROM employees WHERE gender = 'M');

--ALL means it checks all the subquery row

SELECT 
	employeeid,
	firstname,
	salary
FROM employees 
WHERE gender = 'F' AND salary > ALL (SELECT salary FROM employees WHERE gender = 'M');


-- SELECT o.customerid,COUNT(*) FROM orders o
-- LEFT JOIN customers c ON o.customerid =  c.customerid
-- GROUP BY o.customerid

--corelated subqyery
--the subquery is dependent on the main query
SELECT 
*, 
(SELECT COUNT(*) FROM orders o WHERE o.customerid = c.customerid)
FROM customers c;

--EXISTS
-- checks if the subquer returns any rows










