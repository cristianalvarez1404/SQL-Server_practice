
-- Bad practice
SELECT EmployeeID, FirstName, 'Above Average' AS Status
FROM Sales.Employees
WHERE Salary > (SELECT AVG(Salary) FROM Sales.Employees)
UNION ALL
SELECT EmployeeID, FirstName, 'Bellow Average' AS Status
FROM Sales.Employees
WHERE Salary < (SELECT AVG(Salary) FROM Sales.Employees);

-- Good practice
SELECT 
	EmployeeID,
	FirstName,
	CASE 
		WHEN Salary > AVG(Salary) OVER() THEN 'Above Average' 
		WHEN Salary < AVG(Salary) OVER() THEN 'Bellow Average'
		ELSE 'Average'
	END AS STATUS
FROM Sales.Employees;

-- --------------------------------
-- Creating tables
-- --------------------------------

CREATE TABLE CustomersInfo (
	CustomerID INT PRIMARY KEY CLUSTERED,
	FirstName VARCHAR(50) NOT NULL,
	LastName VARCHAR(50) NOT NULL,
	Country VARCHAR(50)  NOT NULL,
	TotalPurchases FLOAT,
	Score INT,
	BirthDate DATE,
	EmployeeID INT,
	CONSTRAINT FK_CustomerInfo_EmploteeID FOREIGN KEY (EmployeeID)
		REFERENCES Sales.Employees(EmployeeID)
);

CREATE NONCLUSTERED INDEX IX_Good_Customers_EmploteeID
ON CustomersInfo(EmployeeID)


