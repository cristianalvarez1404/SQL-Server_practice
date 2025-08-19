/*----------------------JOINS------------------- 
	--Recombine data - Big pictur => INNER JOIN,LEFT JOIN,FULL JOIN
	--Data enrichment - Extra info => LEFT JOIN
	--Check existence - Filtering => INNER JOIN, LEFT JOIN + WHERE, FULL JOIN + WHERE
*/
--No joins
--Retrive all data from customers and orders as separate results
SELECT * FROM customers;
SELECT * FROM orders;

-- Inner joins => Returns only matching rows from both tables
-- Get all customers along with their orders, but only for customers who have placed an order

SELECT c.id, c.first_name, o.order_id, o.sales 
FROM customers AS c
INNER JOIN orders AS o
ON c.id = o.customer_id;

/* Get all customers along with their orders, including those without orders.*/
SELECT c.id,c.first_name,o.order_id, o.sales FROM customers AS c 
LEFT JOIN orders AS o
ON c.id = o.customer_id;


--RIGHT JOIN
-- Get all customers along with their orders, including orders without matching customers
SELECT c.id, c.first_name,o.order_id,o.sales FROM customers AS c
RIGHT JOIN orders AS o
ON c.id = o.customer_id;

-- FULL JOIN
-- Get all customers and all orders, even if there's no match
SELECT c.id,c.first_name,o.order_id,o.sales 
FROM customers AS C
FULL JOIN orders AS o
ON c.id = o.customer_id;

--ANTI JOIN - LEFT JOIN
--Get all customers who haven't placed any order
SELECT * FROM customers AS c
LEFT JOIN orders AS o
ON c.id = o.customer_id
WHERE o.customer_id IS NULL;

--ANTI JOIN - RIGHT JOIN
--Get all orders without matching customers
SELECT * FROM customers AS c
RIGHT JOIN orders AS o
ON c.id = o.customer_id
WHERE c.id IS NULL;
;

--ANTI JOIN - FULL JOIN
--Find customers without orders and orders without customers
SELECT * FROM customers AS c
FULL JOIN orders AS o
ON c.id = o.customer_id
WHERE c.id IS NULL OR o.customer_id IS NULL;

/*
	Get all customers along with their orders, but only for customers who have placed an order
*/

SELECT * FROM  customers AS c
LEFT JOIN orders AS o
ON c.id = o.customer_id
WHERE o.order_id IS NOT NULL;
;

--CROSS JOIN
--Generate all posible combinations of customers and orders.
SELECT * FROM customers
CROSS JOIN orders;



	




