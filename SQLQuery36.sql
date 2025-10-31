-- Bad Practice
SELECT o.OrderID, c.FirstName
FROM Sales.Customers AS c
INNER JOIN Sales.Orders AS o
ON c.CustomerID = o.CustomerID
OR c.CustomerID = o.SalesPersonID;

-- Best Practice
SELECT o.OrderID, c.FirstName
FROM Sales.Customers AS c
INNER JOIN Sales.Orders AS o
ON c.CustomerID = o.CustomerID
UNION
SELECT o.OrderID, c.FirstName
FROM Sales.Customers AS c
INNER JOIN Sales.Orders AS o
ON c.CustomerID = o.SalesPersonID

-- Bad Practice
SELECT CustomerID FROM Sales.Orders
UNION
SELECT CustomerID FROM Sales.OrdersArchive;

-- Best Practice
SELECT CustomerID FROM Sales.Orders
UNION ALL
SELECT CustomerID FROM Sales.OrdersArchive;


-- Bad practice
SELECT CustomerID FROM Sales.Orders
UNION
SELECT CustomerID FROM Sales.OrdersArchive;

-- Best Practice
SELECT DISTINCT CustomerID
FROM (
	SELECT CustomerID FROM Sales.Orders
	UNION ALL
	SELECT CustomerID FROM Sales.OrdersArchive
) AS CombineData

SELECT MONTH(OrderDate) OrderYear, SUM(Sales) AS TotalSales
INTO Sales.SelectSummary
FROM Sales.Orders
GROUP BY MONTH(OrderDate);

SELECT * FROM Sales.SelectSummary;

-- ------------------------------
-- ------------------------------

-- JOIN
SELECT o.OrderID, o.Sales
FROM Sales.Orders AS o
INNER JOIN Sales.Customers AS c
ON o.CustomerID = c.CustomerID
WHERE c.Country = 'USA';

-- EXISTS
SELECT o.OrderID, o.Sales
FROM Sales.Orders AS o
WHERE EXISTS (
	SELECT 1
	FROM Sales.Customers AS c
	WHERE c.CustomerID = o.CustomerID
	AND c.Country = 'USA'
);

-- IN(Bad practice)
SELECT o.OrderID, o.Sales
FROM Sales.Orders AS o
WHERE o.CustomerID IN (
	SELECT CustomerID
	FROM Sales.Customers
	WHERE Country = 'USA'
);

































