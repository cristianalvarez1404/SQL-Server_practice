CREATE TABLE Sales.EmployeeLogs (
	LogID INT IDENTITY(1,1) PRIMARY KEY,
	EmployeeID INT,
	LogMessage VARCHAR(255),
	LogDate DATE
);

CREATE TRIGGER trg_AfterInsertEmployee ON Sales.Employees
AFTER INSERT
AS
BEGIN
	INSERT INTO Sales.EmployeeLogs(EmployeeID,LogMessage,LogDate)
	SELECT
		EmployeeID,
		'New Employee Added =' + CAST(EmployeeID AS VARCHAR),
		GETDATE()
	FROM INSERTED
END

SELECT * FROM Sales.EmployeeLogs;

INSERT INTO Sales.Employees
VALUES
(7, 'Maria', 'Doe', 'HR', '1998-01-12', 'F', 80000, 3);