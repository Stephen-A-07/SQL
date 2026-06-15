SET search_path TO sales;

/*SQL FUNCTIONS ---|-----------|
              single-row  multi-row
			  functions   functions
*/

--SINGLE ROW FUCTIONS

--1)STRING FUNCTIONS

-- concat()

SELECT 
	firstname,lastname,
	CONCAT(firstname,lastname) AS fullname
FROM customers;

--LOWER & UPPER

SELECT UPPER(firstname) AS uppercase,
	LOWER(firstname) AS lowercase 
FROM customers;

--TRIM

SELECT firstname,
	LENGTH(firstname) len_name,
	LENGTH(TRIM(firstname)) len_trim_name
FROM customers;
-- WHERE TRIM(firstname) != firstname;

--REPLACE
SELECT orderdate,REPLACE(orderdate::text,'-','/') 
from orders;

--LENGTH
SELECT firstname,
	LENGTH(firstname) len_fname 
FROM customers;

--STRING EXTRACTION

-- LEFT ,RIGHT
SELECT LEFT(firstname,2),
	RIGHT(firstname,2) 
FROM customers;

--substring
/* SUBSTRING(value,start,len)*/
SELECT SUBSTRING(firstname,2,LENGTH(firstname))
FROM customers;

------------------------------------------------------------
--NUMERIC FUNCTIONS

--ROUND

SELECT ROUND(3.521);

--ABS
SELECT ABS(-34);

--------------------------------------------------------

--DATE-TIME FUNCTIONS

--NOW

SELECT orderid,creationtime,NOW() Today FROM sales.orders;

--PART EXRACTION

--day,date,year functions

SELECT 
	EXTRACT(DAY FROM creationtime) cday,
	EXTRACT(MONTH FROM creationtime) cmonth,
	EXTRACT(YEAR FROM creationtime) cyear
FROM orders;

--to get the day names
SELECT TO_CHAR(creationtime,'day') FROM orders;
SELECT TO_CHAR(creationtime,'month') FROM orders;

--truncat
/*everything after month will be reseted*/
SELECT DATE_TRUNC('month', creationtime)
FROM orders;

/*return number of ordes for each mont*/

SELECT
	DATE_TRUNC('month',creationtime),count(*)
FROM orders GROUP BY DATE_TRUNC('month',creationtime);

/*select all the orders place dduring the month of feb */

SELECT * 
	FROM orders 	
WHERE EXTRACT(month FROM creationtime)::int = 2;

--FORMATING AND CASTING
--changing the format

SELECT TO_CHAR(creationtime, 'DD Day Mon "Q1" YYYY HH:mm:ss:AM') FROM orders;

--cast or ::

SELECT CAST('123' AS INT);
SELECT '123' :: INT;


--null functions

--COALESCE
SELECT COALESCE(firstname,' ') FROM customers;

--is null & is not null
SELECT firstname FROM customers WHERE firstname IS NOT null;
SELECT orderdate FROM orders WHERE orderdate IS  null;

--handle null before sorting
SELECT customerid,
	score
	FROM customers 
ORDER BY CASE WHEN score IS NULL THEN 1 ELSE 0 END,score;

--nullif()
--returns null if the comparison is true then null else return the first value
SELECT orderid,
	sales,
	quantity,
	(sales/NULLIF(quantity,0)) AS price 
FROM orders;

SELECT * FROM customers WHERE score IS NULL;
SELECT * FROM customers WHERE score IS NOT NULL;


SELECT c.*,o.orderid FROM customers c
LEFT JOIN orders o ON c.customerid = o.customerid
WHERE o.orderid IS NULL; 

--CASE STATEMENTS

SELECT sales, CASE 
	WHEN sales > 50 THEN 'High'
	WHEN sales > 20 THEN 'Medium'
	ELSE 'Low'
	END 
FROM orders;


SELECT 
category,SUM(sales) AS totalsales
FROM
(
SELECT sales, CASE 
	WHEN sales > 50 THEN 'High'
	WHEN sales > 20 THEN 'Medium'
	ELSE 'Low'
	END category
FROM orders
)
GROUP BY category
ORDER BY totalsales DESC;

--AGGREGATE FUNCTIONS
-- COUNT(*) - total number of rows.
-- SUM()- total sales
-- AVG()- average sales
-- MAX()- highes value
-- MIN()- minimum value

SELECT 
	COUNT(*) Totalnocustomers,
	SUM(sales) Total_sales,
	AVG(sales) Avg_sales,
	MAX(sales) highest_sale,
	MIN(sales) lowest_sale
FROM orders;



