SELECT *
INTO Sales.DBCustomers
FROM Sales.Customers;

SELECT 
* FROM Sales.DBCustomers
WHERE CustomerID = 1;

CREATE CLUSTERED INDEX idx_DBCustomers_CustomerID
ON Sales.DBCustomers(CustomerID);