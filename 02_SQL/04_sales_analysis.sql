-- CASE STUDY 04: SALES PERFORMANCE

-- Q1. Highest-revenue months
SELECT
    DATE_TRUNC('month', o.order_date::timestamp)::date AS sales_month,
    ROUND(SUM(oi.qty * oi.price)::numeric, 2) AS revenue
FROM orders o
JOIN order_items oi
    ON oi.order_id = o.order_id
GROUP BY 1
ORDER BY revenue DESC;

-- Q2. Sales by customer city
SELECT c.city,COUNT(DISTINCT o.order_id) orders,
 SUM(oi.qty*oi.price) revenue
FROM orders o JOIN customers c ON c.customer_id=o.customer_id
JOIN order_items oi ON oi.order_id=o.order_id
GROUP BY c.city ORDER BY revenue DESC;

-- Q3. Average basket size
SELECT ROUND(AVG(order_units)::numeric,2) avg_units_per_order
FROM (SELECT order_id,SUM(qty) order_units FROM order_items GROUP BY order_id)x;

-- Q4. Highest-value orders
SELECT order_id,SUM(qty*price) order_value,SUM(qty) units
FROM order_items GROUP BY order_id ORDER BY order_value DESC LIMIT 20;

-- Q5. Orders by weekday

SELECT
    EXTRACT(ISODOW FROM order_date::date)::int AS weekday_number,
    TRIM(TO_CHAR(order_date::date, 'Day')) AS weekday,
    COUNT(*) AS orders
FROM orders
GROUP BY 1, 2
ORDER BY 1;