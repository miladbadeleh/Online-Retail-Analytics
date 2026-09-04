CREATE DATABASE OnlineRetail;
GO

USE OnlineRetail;
GO


CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Country NVARCHAR(100),
    FirstPurchaseDate DATE
);


CREATE TABLE Products (
    StockCode NVARCHAR(50) PRIMARY KEY,
    Description NVARCHAR(200),
    UnitPrice DECIMAL(10,2)
);


CREATE TABLE Orders (
    InvoiceNo NVARCHAR(50),
    StockCode NVARCHAR(50),
    Quantity INT,
    InvoiceDate DATETIME,
    CustomerID INT,
    FOREIGN KEY (StockCode) REFERENCES Products(StockCode),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);