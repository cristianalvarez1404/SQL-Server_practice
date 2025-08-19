--Task: Provide view that combines details from orders, products, customers, and employees
CREATE VIEW Sales.V_Order_Datails AS (
	SELECT
		o.OrderID,
		o.OrderDate,
		o.Sales,
		o.Quantity,
		p.Product,
		p.Category,
		CONCAT(COALESCE(c.FirstName,''),' ',COALESCE(c.LastName,'')) AS CustomerName,
		c.Country AS CustomerCountry,
		CONCAT(COALESCE(e.FirstName,''),' ',COALESCE(e.LastName,'')) AS EmployeeName,
		e.Department
	FROM Sales.Orders AS o
	LEFT JOIN Sales.Products AS p
	ON o.ProductID = p.ProductID
	LEFT JOIN Sales.Customers AS c
	ON o.CustomerID = c.CustomerID
	LEFT JOIN Sales.Employees AS e
	ON o.SalesPersonID = e.EmployeeID
);