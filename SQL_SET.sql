SET search_path TO sales;
--SET OPERATOR
/* 

RULES:
1)the order by should be at the end of the last select statement
2)the number of col in both the statement should be same.
3)the data type of the columns selected should be same
4)the aliases and the datatyes are prioratized for the first select only
5)dont change the order of of col selection
6)if the dtype of col is same beware of the incorrect output

*/

--UNION (all distict rows)

SELECT firstname,lastname 
	FROM customers 
UNION 
SELECT firstname,lastname 
	FROM employees;

--UNION ALL(include all duplicates also. better performance then union)
SELECT firstname,lastname 
	FROM customers 
UNION ALL
SELECT firstname,lastname 
	FROM employees;

--EXCEPT(MINUS)(returns unique rows in 1st table that are not in 2nd)
SELECT firstname,lastname 
	FROM employees
EXCEPT
SELECT firstname,lastname 
	FROM customers;
	
--INTERSECT(common rows)
SELECT firstname,lastname 
	FROM employees
INTERSECT
SELECT firstname,lastname 
	FROM customers;	


SELECT 
'orders' AS sourcetable,
	orderid, 
	productid, 
	customerid, 
	salespersonid, 
	orderdate, 
	shipdate, 
	orderstatus, 
	shipaddress, 
	billaddress, 
	quantity, 
	sales, 
	creationtime 
FROM orders
UNION
SELECT 'ordersarchive' AS sourcetable,
	orderid,
	productid, 
	customerid, 
	salespersonid, 
	orderdate, 
	shipdate, 
	orderstatus, 
	shipaddress, 
	billaddress, 
	quantity, 
	sales, 
	creationtime
FROM ordersarchive;







