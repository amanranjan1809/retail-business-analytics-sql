# Retail Business Analytics - SQL Data Analyst Case Study

## 1. Project Overview

This project is an end-to-end SQL Data Analyst case study focused on analyzing retail business performance.

The analysis uses PostgreSQL to answer key business questions related to sales, customers, products, categories, stores, suppliers, employees, and payments.

The goal is to transform raw transactional data into meaningful business insights using SQL.

## 2. Business Objective

The main objectives of this project are:

- Measure overall business performance
- Analyze sales and revenue trends
- Identify top-performing customers and products
- Segment customers based on purchasing behavior
- Evaluate category and store performance
- Analyze supplier and employee-related metrics
- Reconcile order values with payment amounts
- Identify payment mismatches and unpaid orders
- Apply advanced SQL techniques for business analysis

## 3. Dataset

The project contains approximately 50,000 retail transaction records across 12 related tables.

### Tables Used

1. Categories
2. Customers
3. Employees
4. Order_Items
5. Orders
6. Payments
7. Products
8. Promotions
9. Returns
10. Shipments
11. Stores
12. Suppliers

## 4. Tools & Technologies

- PostgreSQL
- DBeaver
- SQL

### SQL Concepts Used

- SELECT
- WHERE
- GROUP BY
- HAVING
- ORDER BY
- Aggregate Functions
- JOINs
- LEFT JOIN
- Subqueries
- CTEs
- CASE WHEN
- Window Functions
- DENSE_RANK()
- ROW_NUMBER()
- LAG()
- DATE_TRUNC()
- EXTRACT()
- NULL Handling
- Conditional Aggregation

## 5. Case Studies

### Executive KPIs
- Headline business KPIs
- Monthly performance
- Yearly performance

### Sales Performance
- Highest-revenue months
- Sales by customer city
- Average basket size
- Highest-value orders
- Orders by weekday

### Customer Analytics
- Top customers
- Customer segmentation
- Customer revenue share and ranking
- Customers with no orders
- First and latest orders

### Product & Category Analytics
- Top products by revenue
- Top products by volume
- Category performance
- Top 3 products per category
- Top-10 product revenue concentration

### Store, Employee & Supplier Analysis
- Store leaderboard
- Store revenue contribution
- Employee salary benchmarking
- Supplier portfolio analysis

### Payment Reconciliation
- Order value vs paid amount
- Payment mismatches
- Unpaid orders

### Advanced SQL Analysis
- Month-over-month growth
- Running revenue
- Ranking and segmentation analysis
- Advanced CTE and window-function analysis

## 6. Key Business Outcomes

The analysis provides a structured view of:

- Revenue and sales performance
- Customer purchasing behavior
- Product and category contribution
- Store-level performance
- Supplier and employee metrics
- Payment reconciliation issues
- Monthly and yearly business trends

These results can help management identify high-performing areas, understand customer behavior, monitor revenue trends, and investigate payment discrepancies.

## 7. Business Recommendations

Based on the analysis, businesses can:

- Focus on high-value customers and repeat buyers
- Promote high-performing products and categories
- Investigate low-performing products and stores
- Monitor monthly revenue trends for planning
- Improve payment reconciliation processes
- Follow up on unpaid or mismatched orders
- Optimize supplier and store performance

## 8. Project Structure

Case_Study_Retail_Final/
│
├── 01_Business_Case/
│
├── 02_SQL/
│   ├── 01_data_profiling.sql
│   ├── 02_data_quality.sql
│   ├── 03_executive_kpis.sql
│   ├── 04_sales_analysis.sql
│   ├── 05_customer_analysis.sql
│   ├── 06_product_category_analysis.sql
│   ├── 07_store_employee_supplier_analysis.sql
│   ├── 08_payment_analysis.sql
│   ├── 09_advanced_sql_case_studies.sql
│   └── 10_final_executive_queries.sql
│
├── 03_Documentation/
│
├── 04_Results/
│
├── .gitignore
└── README.md
