SELECT
OrderMonth,
TotalSales,
SUM(TotalSales) OVER(ORDER BY OrderMonth) AS Runningtotal
FROM V_Monthly_Summary;