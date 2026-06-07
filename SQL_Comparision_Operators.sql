SET search_path To sales;

SELECT * 
FROM customers;
--Filtering Data

/*Compariion operator
1) = (check if two values are equal)
2) <> | != (check if two values are not equal)
3)  > (greater then)
$)>= (greter and equal to)
6)< (lesser then)
7) <= (lesser then  or eqal to)
*/

SELECT * 
	FROM customers 
WHERE country = 'Germany';

SELECT * 
	FROM customers
WHERE country <> 'Germany';

SELECT *
	FROM customers
WHERE score > 500;


SELECT *
	FROM customers
WHERE score >= 500;

SELECT *
	FROM customers
WHERE score <= 500;

/* Logical operator
1)AND (Both condition must be true)
2)OR (atleat one of the condition is true)
3)NOT (Reverse exclued values)
*/

SELECT *
	FROM customers
WHERE country = 'USA' AND score > 500;

SELECT *
	FROM customers
WHERE country = 'USA' OR score > 500;

SELECT *
	FROM customers
WHERE NOT score >= 500;


/* Range operator 
 BETWEEN 
*/
SELECT *
	FROM customers
WHERE score BETWEEN 100 AND 500;

/* Membership operator
1)IN
2)NOT IN
*/

SELECT * 
	FROM customers
WHERE country IN ('USA','Germany');

/* Search operator
 LIKE --|
 	% (any char)
 	_ (one char)
*/

SELECT * 
	FROM customers
WHERE firstname LIKE 'M%';

SELECT * 
	FROM customers
WHERE firstname like '%n';


SELECT * 
	FROM customers
WHERE firstname like '%r%';

SELECT * 
	FROM customers
WHERE firstname like '__r%';