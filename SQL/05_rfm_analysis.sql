USE OnlineRetail;
GO

WITH CustomerRFM AS (
    SELECT 
        c.CustomerID,
        c.Country,
        
        DATEDIFF(DAY, MAX(s.InvoiceDate), '2023-12-31') AS Recency,
        
        COUNT(DISTINCT s.InvoiceNo) AS Frequency,
        
        SUM(s.SalesAmount) AS Monetary
    FROM Fact_Sales s
    JOIN Dim_Customer c ON s.CustomerKey = c.CustomerKey
    JOIN Dim_Date d ON s.DateKey = d.DateKey
    WHERE d.Year = 2023
    GROUP BY c.CustomerID, c.Country
),
RFMScores AS (
    SELECT 
        *,
        NTILE(4) OVER (ORDER BY Recency DESC) AS R_Score,
        NTILE(4) OVER (ORDER BY Frequency) AS F_Score,
        NTILE(4) OVER (ORDER BY Monetary) AS M_Score
    FROM CustomerRFM
)
SELECT 
    CustomerID,
    Country,
    Recency,
    Frequency,
    Monetary,
    CASE 
        WHEN R_Score = 4 AND F_Score = 4 AND M_Score = 4 THEN 'Champions'
        WHEN R_Score >= 3 AND F_Score >= 3 AND M_Score >= 3 THEN 'Loyal Customers'
        WHEN R_Score >= 3 AND F_Score >= 1 AND M_Score >= 2 THEN 'Potential Loyalists'
        WHEN R_Score = 4 AND F_Score <= 1 AND M_Score <= 1 THEN 'New Customers'
        WHEN R_Score = 3 AND F_Score <= 2 AND M_Score <= 2 THEN 'Promising'
        WHEN R_Score <= 2 AND F_Score <= 1 AND M_Score <= 1 THEN 'Lost Customers'
        ELSE 'Needs Attention'
    END AS CustomerSegment
FROM RFMScores
ORDER BY Monetary DESC;