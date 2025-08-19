SELECT
OrderID,
OrderDate
FROM Sales.Orders;

--Find the products that have a price higher than the average price of all products.
--subquery

SELECT
*
FROM(
	SELECT 
		ProductID,
		Price,
		AVG(Price) OVER() AvgPrice
	FROM Sales.Products
) AS tableAvg WHERE Price > AvgPrice;

--Rank customers based on their total amount of sales

SELECT
	RANK() OVER(ORDER BY total_sales DESC) AS CustomerRank,
*
FROM
(	SELECT
	CustomerID,
	SUM(Sales) as total_sales
	FROM Sales.Orders
	GROUP BY CustomerID
) AS t ;

-- Show the product IDs, product names,prices and the total number of orders

SELECT
*,
(SELECT COUNT(*) FROM Sales.Orders) AS totalOrders
FROM 
Sales.Products;

--Show all customer details and find the total orders of each customer
SELECT
*
FROM 
Sales.Customers as cd
LEFT JOIN
	(SELECT CustomerID,COUNT(*) OVER(PARTITION BY CustomerID) AS totalOrdersByCustomer FROM Sales.Orders) as co
ON cd.CustomerID = co.CustomerID;

-- Find the product that have a price higher than the average price of all products

SELECT
*
FROM Sales.Products
WHERE Price > (SELECT AVG(Price) FROM Sales.Products)
;

-- Show the datails of orders made by customers in Germany

SELECT
*
FROM Sales.Orders
WHERE CustomerID NOT IN((SELECT CustomerID FROM Sales.Customers WHERE Country = 'Germany'))
;

-- Find famele employee whose salaries are greater than the salaries of any male employees

SELECT 
*
FROM Sales.Employees
WHERE Gender = 'F' AND Salary > ANY (SELECT Salary FROM Sales.Employees WHERE Gender = 'M')
;


SELECT 
*
FROM Sales.Employees
WHERE Gender = 'F' AND Salary > ALL(SELECT Salary FROM Sales.Employees WHERE Gender = 'M')
;

--Show all customer details and find the total orders of each customer

SELECT 
*
FROM Sales.Customers;

SELECT DISTINCT
	CustomerID,
	COUNT(OrderID) OVER(PARTITION BY CustomerID) as Total_orders
FROM Sales.Orders;

SELECT 
*
FROM Sales.Customers AS c
LEFT JOIN (
	SELECT DISTINCT
		CustomerID,
		COUNT(OrderID) OVER(PARTITION BY CustomerID) as Total_orders
FROM Sales.Orders) AS o
ON c.CustomerID = o.CustomerID;

SELECT
*
FROM Sales.Orders o
WHERE EXISTS (SELECT 1 FROM Sales.Customers c WHERE Country = 'Germany' AND o.CustomerID = c.CustomerID);


