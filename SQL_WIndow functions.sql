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


--partition is used to divide a rows into different windows 
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

SELECT 
	sales,
	productid,
	AVG(sales) OVER(PARTITION BY productid ORDER BY orderdate) movingavgsales
FROM orders;

--rolling order

SELECT 
	sales,
	productid,
	AVG(sales) OVER(PARTITION BY productid ORDER BY orderdate ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) rollingavgsales
FROM orders;

-------------------------------------------------------------------------------------------

--WINDOW RANKING FUNCTIONS

--rank fuction does not take any value and order by is must
--except ntile
--we cannot create frames

--ROW_NUMBER
--if there are duplicates then it does not handle it the distinct ranks are given
SELECT 
	sales,
	ROW_NUMBER() OVER(ORDER BY sales DESC)
FROM orders;

--RANK()
--handles the duplicate,it skips rank


SELECT 
	sales,
	RANK() OVER(ORDER BY sales DESC)
FROM orders;

--DENSE_RANK
--handles duplicate and does not skip ranks

SELECT 
	sales,
	DENSE_RANK() OVER(ORDER BY sales DESC)
FROM orders;

SELECT 
* FROM (
SELECT 
	productid,
	sales,
	ROW_NUMBER() OVER(PARTITION BY productid ORDER BY sales DESC) salesrank
FROM orders
)t WHERE salesrank = 1;

SELECT 
	* 
FROM(
	SELECT 
		customerid,
		SUM(sales) totalsales,
		ROW_NUMBER() OVER(ORDER BY SUM(sales)) rowrank
	FROM orders GROUP BY customerid
)t WHERE rowrank <= 2;


SELECT 
	ROW_NUMBER() OVER(ORDER BY orderid) uniqueid,
	* 
FROM ordersarchive;

--removing duplicates
SELECT 
* FROM(
	SELECT 
		orderid,
		ROW_NUMBER() OVER (PARTITION BY orderid ORDER BY creationtime DESC) rn
	FROM ordersarchive
)t WHERE rn = 1;

--ntile(value)
-- bucket size = total rows/ bucket size
--10/2=5
SELECT 
	orderid,
	sales,
	NTILE(1) OVER (ORDER BY sales DESC) onebucket,
	NTILE(2) OVER (ORDER BY sales DESC) twobucket,
	NTILE(3) OVER (ORDER BY sales DESC) threebucket,
	NTILE(4) OVER (ORDER BY sales DESC) fourbucket
FROM orders;


SELECT 
	orderid,
	sales,
	CASE 
		WHEN Buckets = 1 THEN 'HIGH'
		WHEN Buckets = 2 THEN 'MEDIUM'
		ELSE 'LOW'
	END categories

FROM(
	SELECT
		*,
		NTILE(3) OVER(ORDER BY sales) Buckets 
	FROM orders
)t;


--PERCENTAGE BASED RAMKING

--CUME_DIST
-- cume_dist = position no/no of rows
--if dup last occurence position value for all occcurence also


--percent_rank
--PERCENT_RANK = position no -1/ no of rows -1
--if dup first occurece value position value for all even for the next occurence

SELECT 
	*
FROM(
	SELECT 
		product,
		price,
		CUME_DIST() OVER(ORDER BY price) * 100 percentage
	FROM products
)t WHERE percentage <= 40;

-------------------------------------------------------------------------
--WINDOW VALUE FUNCTIONS

--LAG() - access a value of the previous row
--LEAD() - access a value of the next row

-- LEAD{col,offset[no of rows to skip],default value if no rows are found} OVER(ORDER BY)


--time data analysis
SELECT 
	*,
	LAG(monthlysales) OVER (ORDER BY months),
	ROUND((monthlysales - LAG(monthlysales) OVER (ORDER BY months))::numeric / LAG(monthlysales) OVER (ORDER BY months) *100,2)  mom_percentagechange
FROM
(SELECT 
	DATE_TRUNC('month',orderdate) months,
	SUM(sales) monthlysales
FROM orders 
GROUP BY 1
)t;

SELECT
customerid,
AVG(daysuntilnextorder) avgdays,
RANK() OVER (ORDER BY AVG(daysuntilnextorder)) RANKING
FROM (
SELECT
	orderid,
	customerid,
	orderdate currentorder,
	LEAD(orderdate) OVER(PARTITION BY customerid ORDER BY orderdate) nextorder,
	LEAD(orderdate) OVER(PARTITION BY customerid ORDER BY orderdate) -  orderdate daysuntilnextorder
FROM orders
)
GROUP BY customerid;


SELECT
	productid,
	sales,
	FIRST_VALUE(sales) OVER (PARTITION BY productid ORDER BY sales) minvalue,
	LAST_VALUE(sales) OVER (PARTITION BY productid ORDER BY sales ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) maxvalue
FROM orders;

--------------------END OF WINDOW FUNCTIONS---------------------------------------









