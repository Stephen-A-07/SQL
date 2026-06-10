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





				  


