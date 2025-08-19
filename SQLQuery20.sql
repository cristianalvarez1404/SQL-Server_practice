
IF OBJECT_ID('Sales.V_Monthly_Summary','V') IS NOT NULL
	DROP VIEW Sales.V_Monthly_Summary;
GO
CREATE VIEW Sales.V_Monthly_Summary AS
(
	SELECT
	DATETRUNC(month,OrderDate) AS OrderMonth,
	SUM(Sales) AS TotalSales,
	COUNT(OrderID) AS TotalOrders
	--SUM(Quantity) AS TotalQuantities
	FROM Sales.Orders
	GROUP BY DATETRUNC(month,OrderDate)
)