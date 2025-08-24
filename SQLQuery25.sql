IF OBJECT_ID('Sales.MonthlyOrders', 'U') IS NOT NULL DROP TABLE Sales.MonthlyOrders;
GO
SELECT
	DATENAME(month, OrderDate) AS OrderMonth,
	COUNT(OrderID) AS TotalOrders
INTO Sales.MonthlyOrders
FROM Sales.Orders
GROUP BY DATENAME(month, OrderDate);

SELECT * FROM Sales.MonthlyOrders;


