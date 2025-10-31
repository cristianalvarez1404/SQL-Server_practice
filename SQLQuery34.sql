
SELECT * 
FROM Sales.Orders
WHERE CustomerID = 1 OR CustomerID = 2;

SELECT *
FROM Sales.Orders
WHERE CustomerID IN (1,2);

SELECT 
	c.FirstName,
	o.OrderID
FROM 
	Sales.Customers AS c
INNER JOIN 
	Sales.Orders AS o
ON c.CustomerID = o.CustomerID

-- ======================================
-- Tips	
-- ======================================

SELECT *
FROM Sales.Customers AS c 
RIGHT JOIN Sales.Orders AS o
ON c.CustomerID = o.CustomerID;

SELECT *
FROM Sales.Customers AS c 
LEFT JOIN Sales.Orders AS o
ON c.CustomerID = o.CustomerID;



