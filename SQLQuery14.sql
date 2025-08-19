/* Aggregate functions */

-- Find the total number of orders

SELECT
CustomerID,
COUNT(*) AS total_orders,
SUM(Sales) AS total_sales,
AVG(Sales) AS total_avg,
MAX(Sales) AS max_sale,
MIN(Sales) AS min_sale
FROM Sales.Orders
GROUP BY CustomerID;

SELECT * FROM Sales.Orders;

/* Window functions */

--Find the total sales across all orders
SELECT
SUM(Sales) AS total_sales
FROM Sales.Orders;

--Find the total sales for each product
SELECT
ProductID,
SUM(Sales) AS total_sales 
FROM Sales.Orders
GROUP BY ProductID;

--Find the total sales for each product, additionally provide details such order id & order date
SELECT
ProductID,
OrderID,
OrderDate,
SUM(Sales) AS total_sales
FROM Sales.Orders
GROUP BY ProductID,OrderID,OrderDate;

SELECT
ProductID,
OrderID,
OrderDate,
SUM(Sales) OVER(PARTITION BY ProductID) total_sales_by_product
FROM Sales.Orders;

SELECT
ProductID,
OrderID,
OrderDate,
SUM(Sales) OVER() total_sales_by_order
FROM Sales.Orders;

SELECT
ProductID,
OrderID,
OrderDate,
SUM(Sales) OVER(PARTITION BY ProductID) total_sales_by_order
FROM Sales.Orders;

SELECT
ProductID,
OrderID,
OrderDate,
SUM(Sales) OVER() total_sales,
SUM(Sales) OVER(PARTITION BY ProductID) total_sales_by_product,
SUM(Sales) OVER(PARTITION BY OrderID) total_sales_by_order
FROM Sales.Orders;

SELECT
ProductID,
OrderID,
OrderDate,
OrderStatus,
Sales,
SUM(Sales) OVER() total_sales,
SUM(Sales) OVER(PARTITION BY ProductID) total_sales_by_product,
SUM(Sales) OVER(PARTITION BY ProductID,OrderStatus) total_sales_by_orderStatus
FROM Sales.Orders;

--Rank each order based on their sales from highest to lowest
--Additionally provide details such order Id, order date

SELECT
	OrderID,
	OrderDate,
	Sales,
	RANK() OVER(ORDER BY Sales DESC) RankSales 
FROM Sales.Orders;

-- Find the total number of orders
-- Additionally provide details such order Id, order date

SELECT
OrderID,
OrderDate,
COUNT(*) AS total_orders
FROM Sales.Orders
GROUP BY OrderID, OrderDate; 

SELECT
*
FROM Sales.Orders

SELECT
	OrderID,
	OrderDate,
	CustomerID,
	COUNT(*) OVER() AS total_Orders,
	COUNT(*) OVER(PARTITION BY CustomerID) AS total_Orders_by_customer
FROM Sales.Orders


-- Find the total number of customers
-- Additionally provide all customers details

SELECT
*
FROM Sales.Customers;

SELECT
	*,
	COUNT(1) OVER() AS total_customers,
	COUNT(Score) OVER() AS total_scores,
	COUNT(FirstName) OVER() AS total_names
FROM Sales.Customers;

-- Check wheter the table 'orders' contains any duplicates rows
SELECT
	OrderID,
	COUNT(*) OVER(PARTITION BY OrderID) AS CheckPK
FROM Sales.Orders;

--Find the total sales across all orders
--And the total sales for each product
--Additionally provide details such order Id, order date

SELECT
*,
SUM(Sales) OVER() AS total_sales,
SUM(Sales) OVER(PARTITION BY ProductID) AS total_sales_by_product
FROM Sales.Orders;

SELECT
OrderID,
ProductID,
Sales,
SUM(Sales) OVER() TotalSales,
ROUND(CAST (Sales AS Float) / SUM(Sales) OVER() * 100, 2) PercentageOfTotal
FROM Sales.orders;

--Find the average sales across all orders
--And find the average sales for each product
--Additionally provide details such order Id, order date

SELECT
	*,
	AVG(Sales) OVER() average,
	AVG(Sales) OVER(PARTITION BY ProductID) AS average_by_product
FROM Sales.orders;

SELECT
	*,
	AVG(COALESCE(Score,0)) OVER() AS AvgScore
FROM Sales.Customers;

--Windows RULE=> Window functions cant be used in the WHERE clause, only subqueries
SELECT
*
FROM(
SELECT
	OrderID,
	ProductID,
	Sales,
	AVG(Sales) OVER() AvgSales
FROM Sales.Orders
)t WHERE Sales > AvgSales;


--Find the highest and lowest sales of all orders

SELECT
*,
MAX(Sales) OVER() AS max_sales,
MIN(Sales) OVER() AS min_sales
FROM Sales.Orders;

--Calculate moving average of sales for each product over time
SELECT
	*,
	AVG(Sales) OVER(PARTITION BY ProductID) AS avg_by_product,
	AVG(Sales) OVER(PARTITION BY ProductID ORDER BY OrderDate) AS avg_by_product_
FROM Sales.Orders;

--Rank the orders based on their sales from highest to lowest

SELECT
	*,
	ROW_NUMBER() OVER(ORDER BY Sales DESC) AS SalesRank_Row,
	RANK() OVER(ORDER BY Sales DESC) AS SalesRank_Rank,
	DENSE_RANK() OVER(ORDER BY Sales DESC) AS SalesRank_Dense_rank
FROM Sales.Orders;

--Find the top highest sales for each product

SELECT * 
FROM (
SELECT
	*,
	ROW_NUMBER() OVER(PARTITION BY ProductID ORDER BY Sales DESC) AS RankByProducts 
	--MAX(Sales) OVER(PARTITION BY ProductID) AS max_sales_by_product
FROM Sales.Orders) t WHERE RankByProducts = 1;

--Find the lowest 2 customers based on their total sales
SELECT *
FROM (
SELECT 
	CustomerID,
	SUM(Sales) AS total_sales,
	ROW_NUMBER() OVER(ORDER BY SUM(Sales)) RankCustomers
FROM 
Sales.Orders
GROUP BY CustomerID)t WHERE RankCustomers <= 2;

SELECT DISTINCT TOP 2
CustomerID,
SUM(Sales) OVER(PARTITION BY CustomerID) AS total_sales_by_customer
FROM 
Sales.Orders
ORDER BY total_sales_by_customer ASC;

-- Assign unique IDs to the rows of the Orders Archive

SELECT 
	ROW_NUMBER() OVER(ORDER BY OrderID,OrderDate) AS UniqueID,
	*
FROM Sales.OrdersArchive;

-- Identify duplicate rows in the table 'Orders Archive'
-- And return a clean result without any duplicates

SELECT * FROM (
SELECT 
ROW_NUMBER() OVER(PARTITION BY OrderID ORDER BY CreationTime DESC) AS rn,
* 
FROM Sales.OrdersArchive
)t WHERE rn =1;

--buckets division = row/backet
SELECT
OrderID,
Sales,
NTILE(4) OVER(ORDER BY Sales DESC) AS FourBucket,
NTILE(3) OVER(ORDER BY Sales DESC) AS ThreeBucket,
NTILE(2) OVER(ORDER BY Sales DESC) AS TwoBucket,
NTILE(1) OVER(ORDER BY Sales DESC) AS OneBucket
FROM Sales.Orders;

--segment all orders into 3 categories: high, medium and low sales.
SELECT
*,
CASE WHEN Buckets = 1 THEN 'High'
	WHEN Buckets = 2 THEN 'Medium'
	WHEN Buckets = 3 THEN 'low'
END SalesSegmentations
FROM (
SELECT
	OrderID,
	Sales,
	NTILE(3) OVER(ORDER BY Sales DESC) AS Buckets 
FROM Sales.Orders)t;

-- In order to export the data, divide the orders into 2 groups
SELECT
NTILE(4) OVER(ORDER BY OrderID) AS Buckets,
*
FROM Sales.Orders;

-- Find the products that fall within the highest 40% of the prices
SELECT
*,
CONCAT(DistRank * 100,'%') AS DistRankPerc
FROM ( 
	SELECT
		Product,
		Price,
		--CUME_DIST() OVER(ORDER BY Price DESC) DistRank
		PERCENT_RANK() OVER(ORDER BY Price DESC) DistRank
	FROM Sales.Products
)t WHERE DistRank <= 0.4;

-- Analyze the month-over-month performance by finding the percentage change
-- in sales between the current and previous months

SELECT
*,
ROUND(CAST((CurrentMonthSales - PreviousMonthSales) AS FLOAT)/PreviousMonthSales * 100,1) AS MoM_Perc
FROM (
SELECT
	MONTH(OrderDate) AS orderMonth,
	SUM(Sales) AS CurrentMonthSales,
	LAG(SUM(Sales)) OVER (ORDER BY MONTH(OrderDate)) AS PreviousMonthSales
FROM Sales.Orders
GROUP BY MONTH(OrderDate)
)t ;

-- In order to analyze customer loyalty,
-- rank customers based on the average days between their orders
SELECT
CustomerID,
AVG(DaysUntilNextOrder) AvgDays,
RANK() OVER(ORDER BY COALESCE(AVG(DaysUntilNextOrder),999999)) AS RankAvg
FROM
(
	SELECT
		OrderID,
		CustomerID,
		OrderDate AS CurrentOrder,
		LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate) AS NextOrder,
		DATEDIFF(DAY,OrderDate,LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderID)) AS DaysUntilNextOrder
	FROM Sales.Orders
	--ORDER BY CustomerID,OrderDate
)t GROUP BY CustomerID;

--Find the lowest and highest sales for each product
SELECT
	OrderID,
	ProductID,
	Sales,
	FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales) AS LowestSales,
	LAST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales 
	ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS HighestSales
FROM Sales.Orders;



































