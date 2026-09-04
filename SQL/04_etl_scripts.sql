USE OnlineRetail;
GO


INSERT INTO Dim_Customer (CustomerID, Country, JoinDate)
SELECT 
    CustomerID,
    Country,
    MIN(InvoiceDate) AS JoinDate
FROM Orders
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID, Country;


INSERT INTO Dim_Product (StockCode, Description, UnitPrice)
SELECT 
    StockCode,
    Description,
    UnitPrice
FROM Products;


DECLARE @StartDate DATE = '2023-01-01';
DECLARE @EndDate DATE = '2023-12-31';

WHILE @StartDate <= @EndDate
BEGIN
    INSERT INTO Dim_Date (DateKey, Date, Month, MonthName, Quarter, Year, Weekday)
    VALUES (
        CONVERT(INT, CONVERT(VARCHAR(8), @StartDate, 112)),
        @StartDate,
        MONTH(@StartDate),
        DATENAME(MONTH, @StartDate),
        DATEPART(QUARTER, @StartDate),
        YEAR(@StartDate),
        DATENAME(WEEKDAY, @StartDate)
    );
    
    SET @StartDate = DATEADD(DAY, 1, @StartDate);
END;


INSERT INTO Fact_Sales (CustomerKey, ProductKey, DateKey, InvoiceNo, Quantity, UnitPrice, SalesAmount)
SELECT 
    dc.CustomerKey,
    dp.ProductKey,
    dd.DateKey,
    o.InvoiceNo,
    o.Quantity,
    o.UnitPrice,
    o.Quantity * o.UnitPrice AS SalesAmount
FROM Orders o
JOIN Dim_Customer dc ON o.CustomerID = dc.CustomerID
JOIN Dim_Product dp ON o.StockCode = dp.StockCode
JOIN Dim_Date dd ON CONVERT(DATE, o.InvoiceDate) = dd.Date;