-- CASE STUDY 10: FINAL PORTFOLIO OUTPUT

-- KPI
SELECT COUNT(DISTINCT o.order_id) total_orders,
 COUNT(DISTINCT o.customer_id) active_customers,
 SUM(oi.qty) units_sold,
 ROUND(SUM(oi.qty*oi.price)::numeric,2) revenue,
 ROUND((SUM(oi.qty*oi.price)/NULLIF(COUNT(DISTINCT o.order_id),0))::numeric,2) average_order_value
FROM orders o JOIN order_items oi ON oi.order_id=o.order_id;

-- Monthly trend

SELECT
    DATE_TRUNC('month', o.order_date::date)::date AS sales_month,
    ROUND(SUM(oi.qty * oi.price)::numeric, 2) AS revenue
FROM orders o
JOIN order_items oi
    ON oi.order_id = o.order_id
GROUP BY 1
ORDER BY 1;

-- Top customers
SELECT o.customer_id,COUNT(DISTINCT o.order_id) orders,
 ROUND(SUM(oi.qty*oi.price)::numeric,2) revenue
FROM orders o JOIN order_items oi ON oi.order_id=o.order_id
GROUP BY o.customer_id ORDER BY revenue DESC LIMIT 10;

-- Top products
SELECT product_id,SUM(qty) units_sold,
 ROUND(SUM(qty*price)::numeric,2) revenue
FROM order_items GROUP BY product_id ORDER BY revenue DESC LIMIT 10;

-- Top categories
SELECT c.category_name,ROUND(SUM(oi.qty*oi.price)::numeric,2) revenue
FROM categories c JOIN products p ON p.category_id=c.category_id
JOIN order_items oi ON oi.product_id=p.product_id
GROUP BY c.category_name ORDER BY revenue DESC;

-- Store leaderboard
SELECT o.store_id,COUNT(DISTINCT o.order_id) orders,
 ROUND(SUM(oi.qty*oi.price)::numeric,2) revenue
FROM orders o JOIN order_items oi ON oi.order_id=o.order_id
GROUP BY o.store_id ORDER BY revenue DESC;

