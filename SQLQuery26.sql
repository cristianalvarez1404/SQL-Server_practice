SELECT
*
INTO #Orders
FROM Sales.Orders;

SELECT
*
FROM #Orders;

DELETE FROM #Orders
WHERE OrderStatus = 'Delivered';

DROP TABLE #Orders;

SELECT
*
INTO Sales.OrdersTest
FROM #Orders;



