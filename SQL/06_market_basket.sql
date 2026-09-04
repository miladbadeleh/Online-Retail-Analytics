USE OnlineRetail;
GO

WITH ProductPairs AS (
    SELECT 
        a.InvoiceNo,
        p1.Description AS Product1,
        p2.Description AS Product2
    FROM Fact_Sales a
    JOIN Fact_Sales b ON a.InvoiceNo = b.InvoiceNo 
        AND a.ProductKey < b.ProductKey
    JOIN Dim_Product p1 ON a.ProductKey = p1.ProductKey
    JOIN Dim_Product p2 ON b.ProductKey = p2.ProductKey
)
SELECT 
    Product1,
    Product2,
    COUNT(*) AS PairFrequency,
    COUNT(DISTINCT InvoiceNo) AS UniqueOrders,
    COUNT(*) * 100.0 / (SELECT COUNT(DISTINCT InvoiceNo) FROM Fact_Sales) AS Support
FROM ProductPairs
GROUP BY Product1, Product2
HAVING COUNT(*) > 10
ORDER BY PairFrequency DESC;