-- COMMON TABLE EXPRESSION


-- Temporary named result set(virtual table),
-- that can be used mutiple times within your 
-- query to simplify and organize complex query

--diff for subquery we can use the intermediate table can 
--be used once only but cte we can use muliple times.

-- STANDALONE CTE
--defined and used independently

-- query with cte from the top

WITH CTE_Total_sales AS (
SELECT 
	customerid,
	SUM(sales) Totalsales
FROM sales.orders
GROUP BY customerid
)
--Main query
SELECT 
	c.customerid,
	c.firstname,
	c.lastname,
	cts.Totalsales
FROM sales.customers c
LEFT JOIN CTE_Total_sales cts
ON cts.customerid = c.customerid
ORDER BY customerid




















