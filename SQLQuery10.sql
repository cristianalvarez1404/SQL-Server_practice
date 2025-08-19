/* SELECT FirstName AS name_,LastName AS last_name,'CUSTOMER' AS type_ FROM Sales.Customers
UNION
SELECT FirstName,LastName,'EMPLOYEE' FROM Sales.Employees;
*/

SELECT FirstName,LastName 
FROM Sales.Customers

UNION

SELECT FirstName,LastName 
FROM Sales.Employees;

--UNION => NOT INCLUDE DUPLICATES
-- Combine the data from employees and customers into one table
SELECT 
FirstName, 
LastName 
FROM Sales.Customers
UNION
SELECT 
FirstName, 
LastName 
FROM Sales.Employees;

-- UNION ALL => INCLUDES DUPLICATES
SELECT 
FirstName, 
LastName 
FROM Sales.Customers
UNION ALL
SELECT 
FirstName, 
LastName 
FROM Sales.Employees;

--Find employees who are not customers at the same time
SELECT FirstName,LastName FROM Sales.Customers
EXCEPT
SELECT FirstName,LastName FROM Sales.Employees;

--Find employees who are intersect customers at the same time
SELECT FirstName,LastName FROM Sales.Customers
INTERSECT
SELECT FirstName,LastName FROM Sales.Employees;

-- Orders data are stored in separate tables (Orders and OrdersArchive)
-- Combine all orders data into one report without duplicates.

SELECT 
      'Orders' AS SourceTable
	  ,[ProductID]
	  ,[OrderID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
FROM sales.Orders
UNION 
SELECT
'OrdersArchive' AS SourceTable,
[OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
FROM sales.OrdersArchive
ORDER BY OrderID
;

