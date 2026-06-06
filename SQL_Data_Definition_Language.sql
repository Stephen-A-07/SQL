--Data Defination Language commands

--create command

CREATE TABLE sales.persons (
	id INT NOT NULL,
	person_name VARCHAR(50),
	birth_date DATE,
	CONSTRAINT pk_persons PRIMARY KEY (ID)
	);

--Alter comand
ALTER TABLE sales.persons 
ADD email VARCHAR(20) NOT NULL;

--Drop command
DROP TABLE sales.persons;
