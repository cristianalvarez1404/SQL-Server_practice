-- JOINS IN MULTIPLE TABLES
/*
	Using salesDB,retrive a list of all orders, along with the related customer, product, and employee datails.
	For each order, display:
	-Order ID
	-Customer's name
	-Product name
	-Sales amount
	-Product price
	Salesperson's name
*/

SELECT * FROM sales.Customers;
SELECT * FROM sales.products;
SELECT * FROM sales.Employees;
SELECT * FROM sales.orders;

SELECT 
	o.OrderID,c.FirstName AS customerFirstName ,c.LastName AS customerLastName,o.Sales,
	p.Product, p.Price,
	s.FirstName AS salesPersonFirstName,s.LastName AS salesPersonLastName 
FROM sales.orders AS o
LEFT JOIN sales.Customers AS c
	ON o.CustomerID = c.CustomerID
LEFT JOIN sales.Products AS p
	ON o.ProductID = p.ProductID
LEFT JOIN sales.Employees AS s
	ON o.SalesPersonID = s.EmployeeID
;

