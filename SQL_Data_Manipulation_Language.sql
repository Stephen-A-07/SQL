--Data Manipulation Language (DML)

--Insert command

INSERT INTO sales.customers 
	(customerid,firstname,lastname,country,score)
	VALUES (6,'Jhon','Doe','UK',NULL),
	(7,'Alan','Doe',NULL,600)


INSERT INTO sales.customers 
	(customerid,firstname,lastname,country,score)
VALUES (8,'Max','Doe','Canada',999);

--Update command

UPDATE sales.customers
	SET score=600
WHERE customerid = 2

--Delete command

DELETE From sales.customers WHERE customerid > 6;

SELECT * FROM sales.customers;