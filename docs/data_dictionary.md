# Online Retail - Data Dictionary

## Source Data

**Dataset:** Online Retail Transaction Data
**Source:** UCI Machine Learning Repository
**Time Period:** December 2010 - December 2011
**Total Records:** 541,909 transactions

## Column Definitions

| Column Name | Data Type | Description | Constraints | Example |
|-------------|-----------|-------------|-------------|---------|
| InvoiceNo | String | Unique invoice number per transaction | No nulls, 'C' prefix = cancellation | 536365 |
| StockCode | String | Unique product identifier | No nulls | 85123A |
| Description | String | Product name/description | May have nulls | WHITE HANGING HEART T-LIGHT HOLDER |
| Quantity | Integer | Number of units purchased | Negative = returns | 6 |
| InvoiceDate | DateTime | Transaction date and time | No nulls | 2010-12-01 08:26 |
| UnitPrice | Decimal | Price per unit (GBP) | No nulls | 2.55 |
| CustomerID | Integer | Unique customer identifier | Has nulls (~25%) | 17850 |
| Country | String | Customer's country | No nulls | United Kingdom |

## Calculated Fields

| Field Name | Formula | Purpose |
|------------|---------|---------|
| SalesAmount | Quantity * UnitPrice | Total transaction value |
| DateKey | YYYYMMDD | Date dimension key |
| Year | Year(InvoiceDate) | Calendar year |
| Month | Month(InvoiceDate) | Calendar month |
| Quarter | Quarter(InvoiceDate) | Calendar quarter |

## Data Quality Notes

- Approximately 25% of records have null CustomerID
- Cancellations start with 'C' in InvoiceNo
- Some StockCodes are non-product entries (POST, DOT, M)
- Negative quantities indicate returns
- UnitPrice of 0 may indicate free items or adjustments
- ~90% of transactions are from United Kingdom