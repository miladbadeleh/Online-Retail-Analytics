let
    
    Source = Excel.Workbook(File.Contents("C:\Data\Online_Retail.xlsx"), null, true),
    Sales_Table = Source{[Item="Online Retail",Kind="Table"]}[Data],
    
    
    RemoveDuplicates = Table.Distinct(Sales_Table),
    
    
    RemoveNullCustomers = Table.SelectRows(RemoveDuplicates, each [CustomerID] <> null),
    
    
    FilterCancelledOrders = Table.SelectRows(RemoveNullCustomers, each not Text.StartsWith([InvoiceNo], "C")),
    
    
    FilterQuantity = Table.SelectRows(FilterCancelledOrders, each [Quantity] > 0),
    
    
    FilterPrice = Table.SelectRows(FilterQuantity, each [UnitPrice] > 0),
    
    
    FilterInvalidStock = Table.SelectRows(FilterPrice, each not List.Contains({"POST", "DOT", "M", "BANK CHARGES", "AMAZONFEE"}, [StockCode])),
    
    
    TrimDescription = Table.TransformColumns(FilterInvalidStock, {{"Description", Text.Trim}}),
    ProperCountry = Table.TransformColumns(TrimDescription, {{"Country", Text.Proper}}),
    
    
    AddSalesAmount = Table.AddColumn(ProperCountry, "SalesAmount", each [Quantity] * [UnitPrice]),
    AddYear = Table.AddColumn(AddSalesAmount, "Year", each Date.Year([InvoiceDate])),
    AddMonth = Table.AddColumn(AddYear, "Month", each Date.Month([InvoiceDate])),
    AddQuarter = Table.AddColumn(AddMonth, "Quarter", each Date.QuarterOfYear([InvoiceDate])),
    
    
    SetTypes = Table.TransformColumnTypes(AddQuarter, {
        {"InvoiceNo", type text},
        {"StockCode", type text},
        {"Description", type text},
        {"Quantity", Int64.Type},
        {"InvoiceDate", type datetime},
        {"UnitPrice", type number},
        {"CustomerID", Int64.Type},
        {"Country", type text},
        {"SalesAmount", type number},
        {"Year", Int64.Type},
        {"Month", Int64.Type},
        {"Quarter", Int64.Type}
    })
in
    SetTypes