USE OnlineRetail;
GO


SELECT TOP 10
    p.Description AS ProductName,
    SUM(s.SalesAmount) AS TotalRevenue,
    SUM(s.Quantity) AS TotalQuantity,
    COUNT(DISTINCT s.InvoiceNo) AS OrderCount
FROM Fact_Sales s
JOIN Dim_Product p ON s.ProductKey = p.ProductKey
GROUP BY p.Description
ORDER BY TotalRevenue DESC;


SELECT TOP 10
    c.CustomerID,
    c.Country,
    SUM(s.SalesAmount) AS TotalSpend,
    COUNT(DISTINCT s.InvoiceNo) AS TotalOrders,
    ROUND(SUM(s.SalesAmount) / NULLIF(COUNT(DISTINCT s.InvoiceNo), 0), 2) AS AvgOrderValue
FROM Fact_Sales s
JOIN Dim_Customer c ON s.CustomerKey = c.CustomerKey
GROUP BY c.CustomerID, c.Country
ORDER BY TotalSpend DESC;


SELECT 
    c.Country,
    SUM(s.SalesAmount) AS TotalSales,
    COUNT(DISTINCT c.CustomerID) AS CustomerCount,
    ROUND(SUM(s.SalesAmount) / NULLIF(COUNT(DISTINCT c.CustomerID), 0), 2) AS RevenuePerCustomer
FROM Fact_Sales s
JOIN Dim_Customer c ON s.CustomerKey = c.CustomerKey
GROUP BY c.Country
ORDER BY TotalSales DESC;


SELECT 
    d.Year,
    d.Month,
    d.MonthName,
    COUNT(DISTINCT s.CustomerKey) AS ActiveCustomers
FROM Fact_Sales s
JOIN Dim_Date d ON s.DateKey = d.DateKey
GROUP BY d.Year, d.Month, d.MonthName
ORDER BY d.Year, d.Month;


SELECT 
    d.Year,
    d.Quarter,
    ROUND(SUM(s.SalesAmount) / NULLIF(COUNT(DISTINCT s.InvoiceNo), 0), 2) AS AvgOrderValue
FROM Fact_Sales s
JOIN Dim_Date d ON s.DateKey = d.DateKey
GROUP BY d.Year, d.Quarter
ORDER BY d.Year, d.Quarter;