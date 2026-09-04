USE OnlineRetail;
GO

CREATE TABLE Fact_Sales (
    SalesKey BIGINT IDENTITY(1,1) PRIMARY KEY,
    CustomerKey INT,
    ProductKey INT,
    DateKey INT,
    InvoiceNo NVARCHAR(50),
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    Discount DECIMAL(5,2) DEFAULT 0,
    SalesAmount DECIMAL(12,2),
    FOREIGN KEY (CustomerKey) REFERENCES Dim_Customer(CustomerKey),
    FOREIGN KEY (ProductKey) REFERENCES Dim_Product(ProductKey),
    FOREIGN KEY (DateKey) REFERENCES Dim_Date(DateKey)
);