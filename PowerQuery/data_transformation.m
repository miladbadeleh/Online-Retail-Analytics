let
    
    Source = Excel.Workbook(File.Contents("C:\Data\Cleaned_Online_Retail.xlsx"), null, true),
    CleanData = Source{[Item="CleanData",Kind="Table"]}[Data],
    
    
    CustomerSummary = Table.Group(
        CleanData,
        {"CustomerID", "Country"},
        {
            {"TotalSpend", each List.Sum([SalesAmount]), type number},
            {"TotalOrders", each List.Count(List.Distinct([InvoiceNo])), type number},
            {"TotalItems", each List.Sum([Quantity]), type number},
            {"FirstPurchase", each List.Min([InvoiceDate]), type datetime},
            {"LastPurchase", each List.Max([InvoiceDate]), type datetime},
            {"AvgOrderValue", each List.Sum([SalesAmount]) / List.Count(List.Distinct([InvoiceNo])), type number}
        }
    ),
    
    
    ProductSummary = Table.Group(
        CleanData,
        {"StockCode", "Description"},
        {
            {"TotalRevenue", each List.Sum([SalesAmount]), type number},
            {"TotalQuantity", each List.Sum([Quantity]), type number},
            {"OrderCount", each List.Count(List.Distinct([InvoiceNo])), type number},
            {"AvgUnitPrice", each List.Average([UnitPrice]), type number}
        }
    ),
    
    
    AddMonthYear = Table.AddColumn(CleanData, "MonthYear", each Date.ToText([InvoiceDate], "yyyy-MM")),
    MonthlySummary = Table.Group(
        AddMonthYear,
        {"MonthYear"},
        {
            {"TotalSales", each List.Sum([SalesAmount]), type number},
            {"TotalOrders", each List.Count(List.Distinct([InvoiceNo])), type number},
            {"ActiveCustomers", each List.Count(List.Distinct([CustomerID])), type number},
            {"TotalQuantity", each List.Sum([Quantity]), type number}
        }
    ),
    
    
    CountrySummary = Table.Group(
        CleanData,
        {"Country"},
        {
            {"TotalSales", each List.Sum([SalesAmount]), type number},
            {"CustomerCount", each List.Count(List.Distinct([CustomerID])), type number},
            {"OrderCount", each List.Count(List.Distinct([InvoiceNo])), type number}
        }
    )
in
    CountrySummary