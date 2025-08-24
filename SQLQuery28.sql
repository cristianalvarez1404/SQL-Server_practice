ALTER PROCEDURE GetCustomerSummary5 @Country NVARCHAR(50) = 'USA' 
AS 
BEGIN
	BEGIN TRY
		DECLARE @TotalCustomers INT, @AvgScore FLOAT;
		
		--==========================================
		-- Step 1 : Prepare & Cleanup data
		--==========================================
			IF EXISTS (SELECT 1 FROM Sales.Customers WHERE Score IS NULL AND Country = @Country)
			BEGIN
				PRINT('Updating NULL Scores to 0');
				UPDATE Sales.Customers
				SET Score = 0
				WHERE Score IS NULL AND Country = @Country;
			END
		
			ELSE
			BEGIN
				PRINT('NO NULL Score found');
			END
		--==========================================
		-- Step 2 : Generating summary Reports
		--==========================================
		--Calculate total customers and average score for specific country
		SELECT
			@TotalCustomers = COUNT(*),
			@AvgScore = AVG(Score)
		FROM Sales.Customers
		WHERE Country = @Country;

		PRINT 'Total Customers from ' + @Country + ':' + CAST(@TotalCustomers AS NVARCHAR);
		PRINT 'Average Score from ' + @Country + ':' + CAST(@AvgScore AS NVARCHAR);

		--Calculate total number of orders and total sales from specific country
		SELECT
			COUNT(OrderID) AS TotalOrders,
			SUM(Sales) AS TotalSales
		FROM Sales.Orders AS o
		JOIN Sales.Customers AS c
		ON c.CustomerID = o.CustomerID
		WHERE c.Country = @Country;
	END TRY
	BEGIN CATCH
		--==========================================
		--Error handling
		--==========================================
		PRINT('An error accourred.');
		PRINT('Error message: ' + ERROR_MESSAGE());
		PRINT('Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR));
		PRINT('Error Line: ' + CAST(ERROR_LINE() AS NVARCHAR));
		PRINT('Error Procedure ' + ERROR_PROCEDURE());
	END CATCH
	END
GO

EXEC GetCustomerSummary5;
EXEC GetCustomerSummary5 @Country = 'Germany';