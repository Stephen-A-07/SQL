--VIEW - Virtual table based on the result of a query withoit storing the data in database.


WITH CTE_Monthly_Sales AS(
SELECT 
	DATE_TRUNC('month',orderdate) ordermonth,
	SUM(sales) Totalsales,
	COUNT(Orderid) Totalorders,
	SUM(quantity) Totalquantity
FROM sales.orders
GROUP BY DATE_TRUNC('month',orderdate)
)
SELECT 
	ordermonth,
	Totalsales,
	SUM(Totalsales) OVER(ORDER BY ordermonth) RunningTotal
FROM CTE_Monthly_Sales;



-- CREATE VIEW 

CREATE OR REPLACE VIEW sales.V_Monthly_Summary AS
SELECT 
	DATE_TRUNC('month',orderdate) ordermonth,
	SUM(sales) Totalsales,
	COUNT(Orderid) Totalorders,
	SUM(quantity) Totalquantity
FROM sales.orders
GROUP BY DATE_TRUNC('month',orderdate);

SELECT * FROM sales.V_Monthly_Summary;


SELECT 
	ordermonth,
	Totalsales,
	SUM(Totalsales) OVER(ORDER BY ordermonth) RunningTotal
FROM sales.V_Monthly_Summary;




CREATE OR REPLACE VIEW sales.V_OrderDetails AS
	SELECT 
		o.orderdate,
		o.orderid,
		e.department,
		p.product,
		p.category,
		c.country,
		COALESCE(c.firstname,' ') || ' ' || COALESCE(c.lastname,' ') Customername,
		COALESCE(e.firstname,' ') || ' ' || COALESCE(e.lastname,' ') Emplyeename,
		o.sales,
		o.quantity
	FROM sales.orders o
	LEFT JOIN sales.products p
	ON o.productid=p.productid
	LEFT JOIN sales.customers c
	ON c.customerid=o.customerid
	LEFT JOIN sales.employees e
	ON e.employeeid=o.salespersonid
	WHERE c.country <> 'USA';






