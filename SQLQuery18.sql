--Show the employee hierarchy by displaying each employee's level within the 

WITH CTE_Emp_Hierarchy AS
(
--Anchor Query
	SELECT 
		EmployeeID,
		FirstName,
		ManagerID,
		1 AS Level
	FROM Sales.Employees
	WHERE ManagerID IS NULL
	UNION ALL
	--Recursive Query
	SELECT
		e.EmployeeID,
		e.FirstName,
		e.ManagerID,
		Level + 1
	FROM Sales.Employees AS e
	INNER JOIN CTE_Emp_Hierarchy ceh
	ON e.ManagerID = ceh.EmployeeID
)

--Main Query
SELECT
*
FROM CTE_Emp_Hierarchy;