
let
    
    Source = Excel.Workbook(File.Contents("C:\Data\Online_Retail.xlsx"), null, true),
    RawData = Source{[Item="Online Retail",Kind="Table"]}[Data],
    
    
    
    RemoveNulls = Table.SelectRows(RawData, each [CustomerID] <> null),
    RemoveCancellations = Table.SelectRows(RemoveNulls, each not Text.StartsWith([InvoiceNo], "C")),
    FilterQuantity = Table.SelectRows(RemoveCancellations, each [Quantity] > 0),
    FilterPrice = Table.SelectRows(FilterQuantity, each [UnitPrice] > 0),
    
    
    AddSalesAmount = Table.AddColumn(FilterPrice, "SalesAmount", each [Quantity] * [UnitPrice]),
    AddDateKey = Table.AddColumn(AddSalesAmount, "DateKey", each Date.Year([InvoiceDate]) * 10000 + Date.Month([InvoiceDate]) * 100 + Date.Day([InvoiceDate])),
    
    FinalTable = Table.SelectColumns(AddDateKey, {
        "InvoiceNo", 
        "StockCode", 
        "Description", 
        "Quantity", 
        "InvoiceDate", 
        "UnitPrice", 
        "CustomerID", 
        "Country", 
        "SalesAmount", 
        "DateKey"
    }),
    
    
    SetTypes = Table.TransformColumnTypes(FinalTable, {
        {"InvoiceNo", type text},
        {"StockCode", type text},
        {"Description", type text},
        {"Quantity", Int64.Type},
        {"InvoiceDate", type datetime},
        {"UnitPrice", type number},
        {"CustomerID", Int64.Type},
        {"Country", type text},
        {"SalesAmount", type number},
        {"DateKey", Int64.Type}
    })
in
    SetTypes