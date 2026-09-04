USE OnlineRetail;
GO

WITH MonthlySales AS (
    SELECT 
        d.Year,
        d.Month,
        d.MonthName,
        SUM(s.SalesAmount) AS TotalSales,
        COUNT(DISTINCT s.InvoiceNo) AS OrderCount,
        COUNT(DISTINCT s.CustomerKey) AS CustomerCount,
        SUM(s.Quantity) AS TotalQuantity
    FROM Fact_Sales s
    JOIN Dim_Date d ON s.DateKey = d.DateKey
    GROUP BY d.Year, d.Month, d.MonthName
)
SELECT 
    Year,
    MonthName,
    TotalSales,
    OrderCount,
    CustomerCount,
    TotalQuantity,
    ROUND(AVG(TotalSales) OVER (ORDER BY Year, Month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) AS Sales_3Month_MA,
    LAG(TotalSales) OVER (ORDER BY Year, Month) AS PreviousMonthSales,
    ROUND((TotalSales - LAG(TotalSales) OVER (ORDER BY Year, Month)) * 100.0 / 
        NULLIF(LAG(TotalSales) OVER (ORDER BY Year, Month), 0), 2) AS MoM_Growth
FROM MonthlySales
ORDER BY Year DESC, Month DESC;