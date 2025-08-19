--Find the running total of sales for each month

WITH CTE_Monthly_Summary AS (
	SELECT
	DATETRUNC(month,OrderDate) AS OrderMonth,
	SUM(Sales) AS TotalSales,
	COUNT(OrderID) AS TotalOrders,
	SUM(Quantity) AS TotalQuantities
	FROM Sales.Orders
	GROUP BY DATETRUNC(month,OrderDate)
)
SELECT
OrderMonth,
TotalSales,
SUM(TotalSales) OVER(ORDER BY OrderMonth) AS Runningtotal
FROM CTE_Monthly_Summary;