--SQL SELECT Query

SET search_path To sales;

SELECT * FROM customers;

--to retrive perticular columns

SELECT firstname,lastname,score 
FROM customers;

--retrive customer score not equal to zero

SELECT * FROM customers
WHERE score != 0;

--retrive name and country of customers from Germany

SELECT firstname,country 
	FROM customers 
WHERE country = 'Germany';

/*Order By
sort the results by the highest scores first */

SELECT * FROM customers ORDER BY score DESC;

/* Group By
find the total score and total number of customers from each country */

SELECT country,sum(score),count(customerid) 
	FROM customers 
GROUP BY country;

/* Having
find the average score for each country and return only 
those countries with avg score greater then 430 */

SELECT country,AVG(score) 
	FROM customers 
	GROUP BY country 
HAVING AVG(score) > 430;

/*Distinct
return all unique list of countries */

SELECT DISTINCT country FROM customers;

--Limit
SELECT * FROM customers LIMIT 3;


--All together
/* Calculate the average score for each country 
   considering only customers with a score not equal to 0
   and return only those countries with an average score greater than 430
   and sort the results by the highest average score first. */

SELECT country,AVG(score) 
	FROM customers
	WHERE score !=0
	GROUP BY country
	HAVING AVG(score) > 430
	ORDER BY AVG(score) DESC;





