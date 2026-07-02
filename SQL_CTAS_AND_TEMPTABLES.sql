--Ctas and Temp Table

CREATE TABLE sales.MonthlyOrders  AS(
SELECT 
	TO_CHAR(orderdate,'month') ordermonth,
	COUNT(orderid) Totalorders
FROM sales.orders
GROUP BY TO_CHAR(orderdate,'month')
);

SELECT * FROM sales.MonthlyOrders;

DROP TABLE sales.MonthlyOrders;

--Temporary tables

CREATE TEMPORARY TABLE orders AS (
SELECT * FROM sales.orders
);
-- SELECT schemaname,tablename 
-- FROM pg_tables WHERE tablename = 'orders'
DROP TABLE orders;