-- CASE STUDY 07: STORE, EMPLOYEE & SUPPLIER ANALYSIS

-- Q1. Store leaderboard
SELECT o.store_id,COUNT(DISTINCT o.order_id) orders,
 COUNT(DISTINCT o.customer_id) customers,SUM(oi.qty) units_sold,
 SUM(oi.qty*oi.price) revenue
FROM orders o JOIN order_items oi ON oi.order_id=o.order_id
GROUP BY o.store_id ORDER BY revenue DESC;

-- Q2. Store revenue contribution
WITH store_sales AS(
 SELECT o.store_id,SUM(oi.qty*oi.price) revenue
 FROM orders o JOIN order_items oi ON oi.order_id=o.order_id
 GROUP BY o.store_id
)
SELECT store_id,revenue,
 DENSE_RANK() OVER(ORDER BY revenue DESC) store_rank,
 ROUND((100*revenue/NULLIF(SUM(revenue) OVER(),0))::numeric,2) revenue_share_pct
FROM store_sales ORDER BY store_rank;

-- Q3. Employee salary benchmarking
SELECT store_id,COUNT(*) employees,
 ROUND(AVG(salary)::numeric,2) avg_salary,
 MIN(salary) min_salary,MAX(salary) max_salary,SUM(salary) salary_cost
FROM employees GROUP BY store_id ORDER BY salary_cost DESC;

-- Q4. Supplier portfolio
SELECT s.supplier_id,s.country,COUNT(p.product_id) products_supplied
FROM suppliers s LEFT JOIN products p ON p.supplier_id=s.supplier_id
GROUP BY s.supplier_id,s.country ORDER BY products_supplied DESC;