SELECT
Category,
SUM(Sales) AS TotalSales
FROM(
	SELECT 
	OrderID,
	Sales,
	CASE
		WHEN Sales > 50 THEN 'High'
		WHEN Sales > 20 THEN 'Medium'
		ELSE 'Low'
	END AS Category
	FROM Sales.Orders
) AS t
GROUP BY Category
ORDER BY TotalSales DESC;

-- Retrive employee details with gender displayed as full text

SELECT
EmployeeID,
FirstName,
LastName,
Gender,
	CASE
		WHEN Gender = 'F' THEN 'Female'
		WHEN Gender = 'M' THEN 'Male'
		ELSE 'Not Available'
	END AS GenderFullText
FROM Sales.Employees;

-- Retrive customers details with abbreviated country code
SELECT
CustomerID,
FirstName,
LastName,
Country,
	CASE
		WHEN Country = 'Germany' THEN 'DE'
		WHEN Country = 'USA' THEN 'US'
		ELSE 'N/A'
	END AS CountryAbbr
FROM Sales.Customers;

SELECT
CustomerID,
FirstName,
LastName,
Country,
	CASE
		WHEN Country = 'Germany' THEN 'DE'
		WHEN Country = 'USA' THEN 'US'
		ELSE 'N/A'
	END AS CountryAbbr,

	CASE  Country
		WHEN 'Germany' THEN 'DE'
		WHEN 'USA' THEN 'US'
		ELSE 'N/A'
	END AS CountryAbbr2
FROM Sales.Customers;

-- Find the average scores of customers and treat Nulls as 0
-- Additionally provide details such CustomerID and LastName

SELECT
CustomerID,
LastName,
Score,
	CASE
		WHEN Score IS NULL THEN 0
		ELSE Score
	END AS ScoreClean,
AVG(
	CASE
		WHEN Score IS NULL THEN 0
		ELSE Score
	END
) OVER() AvgCustomerClean,
AVG(Score) OVER() AS AvgCustomer
FROM Sales.Customers;

SELECT
OrderID,
CustomerID,
Sales,
 CASE 
	WHEN Sales > 30 THEN 1
	ELSE 0
 END AS SalesFlag
FROM Sales.Orders
ORDER BY CustomerID;

SELECT
CustomerID,
 SUM(CASE 
	WHEN Sales > 30 THEN 1
	ELSE 0
 END) AS TotalOrdersHighSales,
 COUNT(*) TotalOrders
FROM Sales.Orders
GROUP BY CustomerID;






























