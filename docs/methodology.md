# Online Retail - Analysis Methodology

## 1. Data Cleaning Approach

### Null Handling
- Removed rows with null CustomerID (cannot segment without customer data)
- Removed rows with null Description (incomplete product information)

### Outlier Treatment
- Removed transactions with Quantity > 10000 (data errors)
- Removed transactions with UnitPrice > 5000 (data errors)
- Filtered negative quantities (returns) for sales analysis

### Data Quality Rules
- InvoiceNo must not start with 'C' (cancellations)
- Quantity must be positive
- UnitPrice must be positive
- StockCode must be a valid product code

## 2. Data Warehouse Design

### Schema Type
- Star Schema with 1 fact table and 4 dimension tables

### Fact Table
- Fact_Sales: Transaction-level granularity

### Dimension Tables
- Dim_Product: Product information
- Dim_Customer: Customer information
- Dim_Date: Calendar dates
- Dim_Geography: Country/region details

### Key Design Decisions
- Surrogate keys for all dimensions
- Slowly Changing Dimension (SCD) Type 1 for customer attributes
- Date dimension pre-populated for 2010-2011 period

## 3. RFM Analysis

### Scoring Method
- Recency: Days since last purchase (lower = better)
- Frequency: Count of distinct orders (higher = better)
- Monetary: Total spend (higher = better)

### Segmentation Rules
- NTILE(4) used for each metric
- 8 customer segments identified
- Segments named for business clarity

## 4. Market Basket Analysis

### Approach
- Pairwise product association
- Support threshold: >10 occurrences
- Products analyzed within same invoice

### Metrics
- Support: Frequency of product pair
- Confidence: Conditional probability
- Lift: Correlation strength

## 5. Visualization Design

### Dashboard Pages
1. Executive Summary
2. Customer Analytics
3. Product Performance
4. Sales Trends

### Design Principles
- KPI cards at top for quick reference
- Drill-down capability
- Consistent color scheme
- Mobile-responsive layout