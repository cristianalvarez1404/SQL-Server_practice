/*---------------------------------------------------------------------------------*/
-- Multiple queries
SELECT * FROM customers;
SELECT * FROM orders;

--Static query
SELECT 123 AS static_number;
SELECT 'Hello' AS static_string;
SELECT id,first_name,'New Customer' AS customer_type FROM customers;

	