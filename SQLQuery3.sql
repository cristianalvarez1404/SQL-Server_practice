--DDL
/*
Create a new table called persons with columns: id,person_name,birth_date, and phone
*/

CREATE TABLE persons (
	id INT NOT NULL,
	person_name VARCHAR(50) NOT NULL,
	birth_date DATE,
	phone VARCHAR(15) NOT NULL,
	CONSTRAINT pk_persons PRIMARY KEY(id)
);

-- Add a new column called email to the persons table
ALTER TABLE persons 
ADD email VARCHAR(50) NOT NULL;

SELECT * FROM persons;

-- Remove the column phone from the persons table
ALTER TABLE persons
DROP COLUMN email;

ALTER TABLE persons ADD phone VARCHAR(15) NOT NULL;

-- Delete the table persons from the database
DROP TABLE persons;

--DML
--Insert 
SELECT * FROM customers;

INSERT INTO customers (id,first_name,country,score)
VALUES 
	(6,'Anna','USA',NULL),
	(7,'Sam',NULL, 100);

INSERT INTO customers (id,first_name)
VALUES
	(10,'Sahra');

INSERT INTO customers (id,first_name,country,score)
VALUES
	(8,'USA','Max',NULL),
	(9,'Andreas','Germany',NULL);

-- Insert data from 'customers' into 'persons'

INSERT INTO persons (id,person_name, birth_date,phone)
SELECT	
	id,first_name,NULL,'Unknown'
FROM customers;

SELECT * FROM persons;

--DML UPDATE
/*Change the score of customer 6 to 0 */

SELECT * FROM customers;

UPDATE customers 
SET score = 0 
WHERE id = 6; 

/*Change the score of customer 10 to 0 and update the country to UK */
UPDATE customers
SET score = 0,
	country = 'UK'
WHERE id = 10;

UPDATE customers
SET score = 0
WHERE score IS NULL;

-- Delete all customers with an ID greater than 5
SELECT * FROM customers;
DELETE FROM customers WHERE id > 5;

-- Delete all data from the persons table
SELECT * FROM persons;
TRUNCATE TABLE persons;



