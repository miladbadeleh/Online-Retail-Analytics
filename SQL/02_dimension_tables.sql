USE OnlineRetail;
GO


CREATE TABLE Dim_Product (
    ProductKey INT IDENTITY(1,1) PRIMARY KEY,
    StockCode NVARCHAR(50) NOT NULL,
    Description NVARCHAR(200),
    Category NVARCHAR(100),
    UnitPrice DECIMAL(10,2),
    IsActive BIT DEFAULT 1
);


CREATE TABLE Dim_Customer (
    CustomerKey INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    Country NVARCHAR(100),
    Segment NVARCHAR(50),
    JoinDate DATE
);


CREATE TABLE Dim_Date (
    DateKey INT PRIMARY KEY,
    Date DATE NOT NULL,
    Month INT,
    MonthName NVARCHAR(20),
    Quarter INT,
    Year INT,
    Weekday NVARCHAR(20),
    IsHoliday BIT DEFAULT 0
);