--Functions

--Show a list of customer's first names together with their country in one column.
SELECT
 first_name,
 country,
TRIM(CONCAT(first_name,' from ',country)) AS nombre
FROM customers;

--Transform the customer's first name to lowercase
SELECT
first_name,
country,
CONCAT(first_name,'-',country) AS name_country, 
TRIM(LOWER(first_name)) AS low_name
FROM customers;

--Transform the customer's first name to uppercase
SELECT
first_name,
country,
CONCAT(first_name,'-',country) AS name_country, 
TRIM(LOWER(first_name)) AS low_name,
TRIM(UPPER(first_name)) AS upper_name
FROM customers;

-- Find customers whose first name contains leading or triailing spaces
SELECT 
	first_name,
	LEN(first_name) AS len_name,
	LEN(TRIM(first_name)) AS len_trim_name,
	LEN(first_name) - LEN(TRIM(first_name)) AS flag
FROM customers
WHERE first_name <> TRIM(first_name)
;

--Remove dashes (-) from a phone number
SELECT REPLACE('123-456-7890','-','') AS result

SELECT 'report.txt',REPLACE('report.txt','.txt','.svg');

--Calculate the length of each customer's first name
SELECT 
first_name,
LEN(first_name) AS first_name_length
FROM customers;

--Retrive the first two characters of each first name.
SELECT 
	first_name,
	LEFT(TRIM(first_name),2) AS two_chars
FROM customers;

--Retrive the last two characters of each first name.
SELECT 
	first_name,
	RIGHT(TRIM(first_name),2) AS two_chars
FROM customers;
	
-- Retrive a list of customers's first names after removing the first character.
SELECT
	first_name,
	SUBSTRING(TRIM(first_name),2,LEN(first_name)) AS new_first_name
FROM customers;

--NUMBER FUNCTIONS

SELECT 
3.516,
ROUND(3.516,2) AS new_number,
ROUND(3.516,1) AS new_number_2,
ROUND(3.516,0) AS new_number_3
;

SELECT
-10,
ABS(-10) AS absolute_value;

--DATE AND TIME FUNCTIONS









