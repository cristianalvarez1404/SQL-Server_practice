--FILTERING DATA

--Comparision operators => Compare things Expression-operator-Expression

--Retrive all customers from Germany.
SELECT * FROM customers WHERE country = 'Germany';

--Retrive all customers who are not from Germany
SELECT * FROM customers WHERE country <> 'Germany';

--Retrive all customers with a score greater than 500
SELECT * FROM customers WHERE score > 500;

--Retrive all customers with a score of 500 or more
SELECT * FROM customers WHERE score >= 500 ORDER BY score DESC;

--Retrive all customers with a score less than 500
SELECT * FROM customers WHERE score < 500;

--Retrive all customers with a score of 500 or less
SELECT * FROM customers WHERE score <= 500;

--Logical operators

/*
Retrive all customers who are from USA and have a score greater than 500.
*/
SELECT * FROM customers WHERE country = 'USA' AND score > 500;

/*
Retrive all customers who are either from USA or have a score greater than 500.
*/
SELECT * FROM customers WHERE country = 'USA' OR score > 500;

--Retrive all customers with a score not less than 500
SELECT * FROM customers WHERE NOT score < 500;

--Range operator
--Between - Check if a value is within a range
/*
	Retrive all customers whose score falls in the range between 100 and 500
*/
SELECT * FROM customers WHERE score BETWEEN 100 AND 500;

--Membership operator
--IN check if a value exists in a list

--Retrive all customers from either Germany or USA.
SELECT * FROM customers WHERE country IN('Germany','USA');

--Search operator => LIKE search for a pattern in text
-- Find all customers whose first name starts with 'M'
SELECT * FROM customers WHERE first_name LIKE 'M%';

-- Find all customers whose first name ends with 'n'
SELECT * FROM customers WHERE first_name LIKE '%n';

-- Find all customers whose first name contains 'r'
SELECT * FROM customers WHERE first_name LIKE '%r%';

-- Find all customers whose first name has 'r' in the 3rd position
SELECT * FROM customers WHERE first_name LIKE '__r%';



