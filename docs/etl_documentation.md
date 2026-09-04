# Online Retail - ETL Documentation

## ETL Pipeline Overview


## Extract Phase

### Source Systems
- Excel file: Online_Retail.xlsx
- Format: XLSX
- Size: ~540,000 rows

### Extraction Method
- Power Query connection to local file
- Full refresh (no incremental load needed for demo)

## Transform Phase

### Cleaning Steps
1. Remove duplicate rows
2. Remove null CustomerID
3. Filter cancelled orders
4. Filter negative quantities
5. Filter zero/negative prices
6. Remove invalid stock codes
7. Trim text fields
8. Standardize country names
9. Add calculated columns

### Business Rules Applied
- SalesAmount = Quantity * UnitPrice
- Valid transaction requires: CustomerID, positive Quantity, positive UnitPrice
- Cancellations excluded from analysis

## Load Phase

### Target Schema
- SQL Server database: OnlineRetail
- Star Schema with 4 dimensions + 1 fact table

### Load Strategy
- Full load for initial setup
- Truncate and reload for demo purposes
- No incremental loading required

## Schedule

| Task | Frequency | Duration |
|------|-----------|----------|
| Data extraction | Daily | 5 min |
| Data cleaning | Daily | 10 min |
| Data load | Daily | 5 min |
| Dashboard refresh | Daily | 15 min |

## Error Handling

- Null CustomerID: Rows skipped with warning
- Invalid StockCode: Rows skipped with warning
- Duplicate InvoiceNo: First occurrence kept
- Data type errors: Converted with error handling

## Monitoring

- Row counts logged at each stage
- Error records saved to separate table
- Dashboard refresh status monitored