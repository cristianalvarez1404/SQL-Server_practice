--Step 1:Write a Query
--For US Customers find the total number of customers and the average score

SELECT
	COUNT(*) AS TotalCustomers,
	AVG(Score) AS AvgSocore
FROM Sales.Customers
WHERE Country = 'USA';

-- Step 2: Turning the Query Into a Stored Procedure
CREATE PROCEDURE GetCustomerSummary AS
BEGIN
	SELECT
		COUNT(*) AS TotalCustomers,
		AVG(Score) AS AvgSocore
	FROM Sales.Customers
	WHERE Country = 'USA';
END

-- Step 3: Execute the Stored Procedure

EXEC GetCustomerSummary;

-- For German find the total number of customers and average score

CREATE PROCEDURE GetCustomerSummaryGermany AS
BEGIN
	SELECT
		COUNT(*) TotalCustomers,
		AVG(Score) AvgScore
	FROM Sales.Customers
	WHERE Country = 'Germany';
END

EXEC GetCustomerSummaryGermany;

-- Don't repeat yourself

ALTER PROCEDURE GetCustomerSummary2 @Country NVARCHAR(50) = 'USA'
AS
BEGIN
	SELECT
		COUNT(*) AS TotalCustomers,
		AVG(Score) AS AvgSocore
	FROM Sales.Customers
	WHERE Country = @Country;
END

-- Step 3: Execute the Stored Procedure

EXEC GetCustomerSummary2 @Country = 'Germany';

EXEC GetCustomerSummary2 @Country = 'USA';

EXEC GetCustomerSummary2;

DROP PROCEDURE GetCustomerSummaryGermany;

-- Find the total Nr. of Orders and Total Sales

CREATE PROCEDURE GetCustomerSummary3 @Country NVARCHAR(50) = 'USA' 
AS  
BEGIN
	SELECT
		COUNT(*) AS TotalCustomers,
		AVG(Score) AS AvgSocore
	FROM Sales.Customers
	WHERE Country = @Country;

	SELECT
		COUNT(OrderID) AS TotalOrders,
		SUM(Sales) AS TotalSales
	FROM Sales.Orders AS o
		JOIN Sales.Customers AS c
	ON o.CustomerID = c.CustomerID
	WHERE c.Country = @Country;
END

EXEC GetCustomerSummary3;