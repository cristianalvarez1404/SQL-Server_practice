SELECT
OrderID,
OrderDate,
ShipDate,
CreationTime
FROM Sales.Orders

SELECT
OrderID,
CreationTime,
'2025-08-20' AS hard_coded,
GETDATE() AS time_now
FROM Sales.Orders;

SELECT
OrderID,
CreationTime,
YEAR(CreationTime) AS year_,
MONTH(CreationTime) AS month_,
DAY(CreationTime) AS day_,
DATEPART(WEEK,CreationTime) as date_part,
DATENAME(month,CreationTime) as date_name,
DATENAME(WEEKDAY,CreationTime) as date_name_2,
DATETRUNC(MONTH,CreationTime) as date_truncate
FROM Sales.Orders;

SELECT
OrderID,
CreationTime,
EOMONTH(CreationTime) AS endOfMonth,
CAST(DATETRUNC(MONTH,CreationTime) AS DATE) AS startOfMonth
FROM Sales.Orders;

-- How many orders were placed each year?
SELECT
YEAR(OrderDate),
COUNT(*) NrOfOrders
FROM Sales.Orders
GROUP BY YEAR(OrderDate)
;

SELECT
DATENAME(MONTH,OrderDate) as MonthOfOrder,
COUNT(*) NrOfOrders
FROM Sales.Orders
GROUP BY DATENAME(MONTH,OrderDate);

--Show all orders that were placed during the month of febrary
SELECT 
MONTH(OrderDate) AS monthOfOrder,
COUNT(*) AS NrOfOrders
FROM Sales.Orders
WHERE MONTH(OrderDate) = 2
GROUP BY MONTH(OrderDate)
;

SELECT 
MONTH(OrderDate) AS monthOfOrder,
COUNT(*) AS NrOfOrders
FROM Sales.Orders
GROUP BY MONTH(OrderDate)
HAVING MONTH(OrderDate) = 2
;

-- Formating in SQL
SELECT
OrderID,
CreationTime,
FORMAT(CreationTime,'yyyy-MM') AS date_formated,
FORMAT(CreationTime,'dddd') AS date_formated_2,
FORMAT(CreationTime,'MMMM') AS date_formated_3
FROM Sales.Orders;

SELECT 
FORMAT(OrderDate,'MMM yy'),
COUNT(*) AS totalOrders 
FROM Sales.Orders
GROUP BY FORMAT(OrderDate,'MMM yy');

--Casting in SQL

SELECT
CONVERT(INT,'123') AS [String to INT CONVERT],
CONVERT(DATE,'2025-08-20') AS [String to DATE CONVERT],
'HOLA MUNDO' + 'Mi nombre es : ' + 'Cristian';

SELECT
CAST('123' AS INT) AS [String to Int],
CAST(123 AS VARCHAR) AS [String to Varchar],
CAST('2025-08-20' AS DATE) AS [String to Date],
CAST('2025-08-20' AS DATETIME2) AS [String to Datetime2],
CreationTime,
CAST(CreationTime AS DATE) AS [Datetime to Date]
FROM Sales.Orders
;


SELECT 
OrderID,
OrderDate,
DATEADD(YEAR,2, OrderDate) AS newDate,
DATEADD(MONTH,2, OrderDate) AS newDate,
DATEADD(DAY,-2, OrderDate) AS newDate
FROM Sales.Orders;

-- Calculate the age of employees
SELECT
EmployeeID,
BirthDate,
DATEDIFF(YEAR,BirthDate,GETDATE()) AS diff
FROM Sales.Employees;

--Find the average shipping duration in days for each month
SELECT
MONTH(OrderDate) AS OrderDate,
AVG(DATEDIFF(DAY,OrderDate,ShipDate)) AS diff_day
FROM Sales.Orders
GROUP BY MONTH(OrderDate)
;

SELECT 
OrderID,
OrderDate AS currentOrderDate,
LAG(OrderDate) OVER(ORDER BY OrderDate) previousOrderDate,
DATEDIFF(DAY,LAG(OrderDate) OVER(ORDER BY OrderDate),OrderDate)
FROM Sales.Orders;

SELECT 
ISDATE('123') AS DateCheck1,
ISDATE('2025-08-20') AS DateCheck2,
ISDATE('20-08-2025') AS DateCheck3,
ISDATE('2025') AS DateCheck3
;

SELECT
	OrderDate,
	ISDATE(OrderDate),
	CASE WHEN ISDATE(OrderDate) = 1 THEN CAST(OrderDate AS DATE)
		ELSE '9999-01-01'
	END NewOrderDate
FROM
	(
		SELECT '2025-08-20' AS OrderDate UNION
		SELECT '2025-08-21' UNION
		SELECT '2025-08-23' UNION
		SELECT '2025-08'
)t
WHERE ISDATE(OrderDate) = 0;

--NULL FUNCTIONS

SELECT
CustomerID,
Score,
AVG(Score) OVER() AvgScores,
AVG(COALESCE(Score,0)) OVER() AvgScores2
FROM Sales.Customers;

SELECT
CustomerID,
FirstName,
LastName,
COALESCE(LastName,'') AS LastName2,
FirstName + ' ' + COALESCE(LastName,'') AS FullName,
Score,
Score + 10 AS ScoreWithBonus,
COALESCE(Score,0) + 10 AS ScoreWithBonus2
FROM Sales.Customers

-- Sort the customers from lowest to highest scores,
-- with nulls appearing last

SELECT
CustomerID,
Score,
COALESCE(Score,999999),
CASE WHEN Score IS NULL THEN 1 ELSE 0 END
FROM Sales.Customers
ORDER BY COALESCE(Score,999999)
;

SELECT
CustomerID,
Score,
COALESCE(Score,999999),
CASE WHEN Score IS NULL THEN 1 ELSE 0 END Flag
FROM Sales.Customers
ORDER BY CASE WHEN Score IS NULL THEN 1 ELSE 0 END ,Score;


SELECT
OrderID,
Sales,
Quantity,
Sales / NULLIF(Quantity,0) AS Price
FROM Sales.Orders;

--Identify the customers who have no scores
SELECT
*
FROM Sales.Customers
WHERE Score IS NULL
;	

SELECT
*
FROM Sales.Customers
WHERE Score IS NOT NULL
;

--List all details for customers who have not placed any orders
SELECT
c.*,
o.OrderID
FROM Sales.Customers AS c
LEFT JOIN Sales.Orders AS o
ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL
;






























