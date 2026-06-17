--WINDOW FUNCTIONS

SET search_path TO 'sales';


/* limits of group by */
-- SELECT 
-- 	orderid,
-- 	orderdate,
-- 	productid,
-- 	SUM(sales) sum_sales 
-- FROM orders GROUP BY productid;


SELECT 
	orderid,
	orderdate,
	productid,
	SUM(sales) OVER(PARTITION BY productid) sum_sales 
FROM orders;

--SYNTAX

-- window fuction() over-- partition by,order by,frame clause

SELECT 
	orderid,
	orderdate,
	productid,
	SUM(sales) OVER() sum_sales, 
	SUM(sales) OVER(PARTITION BY productid) salesbyproduct,
	SUM(sales) OVER(PARTITION BY productid,orderstatus) salesbyproductstatus
FROM orders;

--with rank oredr by is must 
SELECT 
	orderid,
	orderdate,
	sales,
	RANK() OVER(ORDER BY sales DESC) Ranksales 
FROM orders;


--partition is used to divide a cols into different windows 
--frame is use to get rows inside the windows
--used only with order by


-- here first the partition is done it is divided into 2 
-- delivered and shipped and we order it by date and then sum the values
-- based on the condition of the fram clause of one window at a time
SELECT 
	orderid,
	orderdate,
	sales,
	orderstatus,
	SUM(sales) OVER(PARTITION BY orderstatus ORDER BY orderdate ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) Ranksales 
FROM orders;

-- order by always uses a fram default frame 
-- ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW


-- RULES for window function
-- 1)can be used only in select and order by we cannot use filter in window function like where and group by 
-- 2)we cannot have nested wf like one wf inside another
-- 	SUM(SUM(sales) OVER(PARTITION BY orderstatus)) OVER(PARTITION BY orderstatus)

-- 3)the window f will be executed after the where clause
-- 4)we can use the wf together with group by in the same query only if the same columns are used

-------------------------------------------------------------------------------------

--window aggregate functions
--count() any data type and the rest integer only

--COUNT()
--count numbers only non null values

--count(1) ==  count(*) same values and same performens

SELECT 
	orderid,
	orderdate,
	customerid,
	COUNT(*) OVER(PARTITION BY customerid) orderbycustomers
FROM orders;


SELECT 
	orderid,
	orderdate,
	customerid,
	COUNT(*) OVER(),
	sales,
	COUNT(sales) over()
FROM orders;

--to find duplicate
SELECT 
	orderid,
	COUNT(*) OVER(PARTITION BY orderid) Checkpk
FROM orders;

SELECT 
* FROM (
	SELECT 
		orderid,
		COUNT(*) OVER(PARTITION BY orderid) DuplicateCount
	FROM ordersarchive
)t WHERE DuplicateCount > 1;

--------------------------------------------------------------

--SUM()

SELECT 
	orderid,
	orderdate,
	SUM(sales) OVER() salesforallprod,
	SUM(sales) OVER(PARTITION BY productid ) salesforeachpro
FROM orders;

SELECT 
	overallsum,
	eachproductsum,
	(eachproductsum * 100 / overallsum) percentageprice
FROM (
	SELECT 
		sales,
		productid,
		SUM(sales) OVER() overallsum,
		SUM(sales) OVER(PARTITION BY productid) eachproductsum
	FROM orders
)t;

SELECT 
	orderid,
	productid,
	sales,
	SUM(sales) OVER() totalsales,
	ROUND (CAST(sales AS NUMERIC)/SUM(sales) OVER() *100,2) percentagetotal
FROM orders;


--------------------------------------------------------------------------

--AVG()

SELECT 
	orderid,
	orderdate,
	ROUND(AVG(sales) OVER()) salesavg,
	ROUND(AVG(sales) OVER(PARTITION BY productid)) avgsalesbyproduct
FROM orders;


SELECT 
	customerid,
	lastname,
	score,
	ROUND(AVG(COALESCE(score,0)) OVER(),2) avgscore
FROM customers;



SELECT *
FROM (
	SELECT 
		orderid,
		sales,
		AVG(sales) OVER() avgsales
	FROM orders
)t WHERE sales > avgsales;

------------------------------------------------------------

--MIN and MAX 

SELECT 
	orderid,
	orderdate,
	sales,
	MIN(sales) OVER() lowestsale,
	MAX(sales) OVER() Maxsale,
	MIN(sales) OVER(PARTITION BY productid) lowsalesechproduct,
	MAX(sales) OVER(PARTITION BY productid) Maxsaleseachproduct	
FROM orders;


SELECT
* FROM(
	SELECT 
		employeeid,
		firstname,
		salary,
		MAX(salary) OVER() maxsalary
	FROM employees
)t WHERE salary = maxsalary;


--RUNNIG TOTAL AND ROLLING TOTAL




