-- This is a comment
/*
	This is a comment
	in different lines
*/
SELECT * FROM customers;

-- Retrive all order data
SELECT * FROM orders;
SELECT * FROM orders WHERE order_id = 1003;
SELECT customer_id FROM orders WHERE order_id = 1003;

-- Retrive each customer's name, country and score.
SELECT first_name,country,score FROM customers;

-- Retrive customers with a score not equal to 0
SELECT * FROM customers WHERE score <> 0;
SELECT * FROM customers WHERE score != 0;
SELECT first_name,country FROM customers WHERE country = 'Germany';

-- Retrive all customers and sort the results by the highest score first.
SELECT * FROM customers ORDER BY score DESC;
SELECT * FROM customers ORDER BY score ASC;
SELECT * FROM customers ORDER BY country ASC, score DESC;

-- Find the total score for each country
SELECT country, sum(score) AS total_score FROM customers GROUP BY country ORDER BY total_score DESC;
-- Find the total score and total number of customers for each country
SELECT country, sum(score) AS total_score, count(id) AS total_customers FROM customers GROUP BY country;
/*
Find the average score for each country considering only customers with a score not equal to 0
and return only those countries with an average score greater than 430
*/

SELECT country, AVG(score) AS average
FROM customers WHERE score <> 0 
GROUP BY country 
HAVING AVG(score) > 430
ORDER BY average DESC;

-- Return Unique list of all countries
SELECT DISTINCT country FROM customers;

-- Retrive only 3 customers
SELECT TOP 3 * FROM customers;
-- Retrive the top 3 customers with the highest scores
SELECT TOP 3 * FROM customers ORDER BY score DESC;
SELECT TOP 2 * FROM customers ORDER BY score ASC;

-- Get the two most recent orders
SELECT TOP 2 * FROM orders ORDER BY order_date DESC;



