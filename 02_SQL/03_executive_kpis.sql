-- CASE STUDY 03: EXECUTIVE KPIs

-- Q1. Headline KPIs
SELECT COUNT(DISTINCT o.order_id) total_orders,
 COUNT(DISTINCT o.customer_id) active_customers,
 SUM(oi.qty) units_sold,
 ROUND(SUM(oi.qty*oi.price)::numeric,2) total_revenue,
 ROUND((SUM(oi.qty*oi.price)/NULLIF(COUNT(DISTINCT o.order_id),0))::numeric,2) average_order_value
FROM orders o JOIN order_items oi ON oi.order_id=o.order_id;

-- Q2. Monthly performance

SELECT
    DATE_TRUNC('month', o.order_date::date)::date AS month,
    COUNT(DISTINCT o.order_id) AS orders,
    COUNT(DISTINCT o.customer_id) AS customers,
    SUM(oi.qty) AS units_sold,
    ROUND(SUM(oi.qty * oi.price)::numeric, 2) AS revenue
FROM orders o
JOIN order_items oi
    ON oi.order_id = o.order_id
GROUP BY 1
ORDER BY 1;

-- Q3. Yearly performance

SELECT
    EXTRACT(YEAR FROM o.order_date::date)::int AS sales_year,
    COUNT(DISTINCT o.order_id) AS orders,
    COUNT(DISTINCT o.customer_id) AS customers,
    ROUND(SUM(oi.qty * oi.price)::numeric, 2) AS revenue
FROM orders o
JOIN order_items oi
    ON oi.order_id = o.order_id
GROUP BY 1
ORDER BY 1;