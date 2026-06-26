-- COMMON TABLE EXPRESSION

--2 types non recursive and recursive cte
--non rcte - standalone and nested

-- Temporary named result set(virtual table),
-- that can be used mutiple times within your 
-- query to simplify and organize complex query

--diff for subquery we can use the intermediate table can 
--be used once only but cte we can use muliple times.

-- STANDALONE CTE
--defined and used independently

-- query with cte from the top

--Step1: Find the total sales for customer(Standalone cte)
WITH CTE_Total_sales AS (
SELECT 
	customerid,
	SUM(sales) Totalsales
FROM sales.orders
GROUP BY customerid
)

--Find the last order date for each customers
,CTE_Last_Order AS
(
	SELECT 
		customerid,
		MAX(orderdate) AS last_order
	FROM sales.orders GROUP BY customerid
)
--Rank the customer based on the tota sales
,CTE_Customer_Rank AS
(
	SELECT 
		customerid,
		RANK() OVER(ORDER BY Totalsales DESC) Customer_Rank
	FROM CTE_Total_sales
)
--segment the customers based on totalsales
,CTE_Customer_Segment AS (
SELECT 
	customerid,
	CASE WHEN Totalsales > 100 THEN 'High'
	 	 WHEN Totalsales > 50 THEN 'Medium'
		 ELSE 'Low'
	END CustomerSegment
FROM CTE_Total_sales
)

--Main query
SELECT 
	c.customerid,
	c.firstname,
	c.lastname,
	cts.Totalsales,
	clo.last_order,
	ctr.Customer_Rank,
	ctg.CustomerSegment
FROM sales.customers c
LEFT JOIN CTE_Total_sales cts
ON cts.customerid = c.customerid
LEFT JOIN CTE_Last_Order clo
ON clo.customerid = c.customerid
LEFT JOIN CTE_Customer_Rank ctr
ON ctr.customerid = c.customerid
LEFT JOIN CTE_Customer_Segment ctg
ON ctg.customerid = c.customerid;

--Recursive cte

--generate a sequence of no from 1-20

WITH RECURSIVE Series AS (
--Anchor query
SELECT 
	1 AS MyNumber
	UNION ALL
	--Recursive Query
	SELECT 
	MyNumber + 1
	FROM Series
	WHERE MyNumber < 20
)
--Main Query
SELECT * FROM Series
LIMIT 10;


WITH RECURSIVE CTE_Employee_Hirarchy AS(
--Anchor Query
	SELECT 
		employeeid,
		firstname,
		managerid,
		1 AS level
	FROM sales.employees
	WHERE managerid IS NULL
	UNION ALL 
--Recursive Query
	SELECT 
		e.employeeid,
		e.firstname,
		e.managerid,
		level + 1
	FROM sales.employees e
	INNER JOIN CTE_Employee_Hirarchy ceh
	ON e.managerid = ceh.employeeid
)
SELECT * FROM CTE_Employee_Hirarchy;







