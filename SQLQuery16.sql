--CTE
--Step1: Find the total Sales Per Customer
WITH CTE_Total_Sales AS
(
SELECT
	CustomerID,
	SUM(Sales) AS TotalSales
FROM Sales.Orders
GROUP BY CustomerID
)
--Step2: Find the last order date for each customer
,CTE_Last_Order AS
(
SELECT
CustomerID,
MAX(OrderDate) AS last_order
FROM Sales.Orders
GROUP BY CustomerID
)
--Step3:Rank customers based on total sales per customer - nested CTE
,CTE_Customer_Rank AS
(
SELECT
CustomerID,
TotalSales,
RANK() OVER(ORDER BY TotalSales DESC) AS CustomerRank
FROM CTE_Total_Sales
)
--Step4 segment customers based on their total sales
,CTE_Customer_Segments AS
(
SELECT
	CustomerID,
	CASE WHEN TotalSales > 100 THEN 'High'
		WHEN	TotalSales > 50 THEN 'Medium'
		ELSE 'Low'
	END AS CustomerSegments
	FROM CTE_Total_Sales
)

--SELECT * FROM CTE_Customer_Segments


--MainQuery
SELECT
c.CustomerID,
c.FirstName,
c.LastName,
cts.TotalSales,
clo.last_order,
ccr.CustomerRank,
ccs.CustomerSegments
FROM Sales.Customers AS c
LEFT JOIN CTE_Total_Sales AS cts
on c.CustomerID = cts.CustomerID
LEFT JOIN CTE_Last_Order AS clo
on c.CustomerID = clo.CustomerID
LEFT JOIN CTE_Customer_Rank AS ccr
on c.CustomerID = ccr.CustomerID
LEFT JOIN CTE_Customer_Segments AS ccs
on c.CustomerID = ccs.CustomerID
;


