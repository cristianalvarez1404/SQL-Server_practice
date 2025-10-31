SELECT c.FirstName, o.OrderID, o.OrderStatus
FROM Sales.Customers AS c
LEFT JOIN Sales.Orders AS o
ON c.CustomerID = o.CustomerID
WHERE o.OrderStatus = 'Delivered';

SELECT c.FirstName, o.OrderID, o.OrderStatus
FROM Sales.Customers AS c
INNER JOIN Sales.Orders AS o
ON c.CustomerID = o.CustomerID
AND o.OrderStatus = 'Delivered'
;

SELECT c.FirstName, o.OrderID, o.OrderStatus
FROM Sales.Customers AS c
INNER JOIN (SELECT OrderID,CustomerID,OrderStatus FROM Sales.Orders WHERE OrderStatus = 'Delivered') AS o
ON c.CustomerID = o.CustomerID;


-- ===========================================
-- Tip Aggregate Before Joining ( Big Tables )
-- ===========================================

SELECT c.CustomerID, c.FirstName, COUNT(o.OrderID) AS OrderCount
FROM Sales.Customers AS c
INNER JOIN Sales.Orders AS o
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName;

SELECT c.CustomerID, c.FirstName, o.OrderCount
FROM Sales.Customers AS c
INNER JOIN (
	SELECT CustomerID, COUNT(OrderID) AS OrderCount FROM Sales.Orders GROUP BY CustomerID
) AS o
ON c.CustomerID = o.CustomerID;

SELECT 
	c.CustomerID, 
	c.FirstName, 
	(SELECT COUNT(o.OrderID) FROM Sales.Orders AS o WHERE o.CustomerID = c.CustomerID) AS OrderCount
FROM Sales.Customers AS c



