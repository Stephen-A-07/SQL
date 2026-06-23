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
) o ON c.customerid = o.customerid



