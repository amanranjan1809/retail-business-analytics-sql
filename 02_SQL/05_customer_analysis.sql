- CASE STUDY 05: CUSTOMER ANALYTICS

-- Q1. Top customers
SELECT o.customer_id,COUNT(DISTINCT o.order_id) orders,
 SUM(oi.qty*oi.price) revenue
FROM orders o JOIN order_items oi ON oi.order_id=o.order_id
GROUP BY o.customer_id ORDER BY revenue DESC LIMIT 20;

-- Q2. Customer segmentation
WITH customer_orders AS (
    SELECT
        o.customer_id,
        COUNT(DISTINCT o.order_id) AS order_count,
        SUM(oi.qty * oi.price) AS revenue
    FROM orders o
    JOIN order_items oi
        ON oi.order_id = o.order_id
    GROUP BY o.customer_id
)
SELECT
    CASE
        WHEN order_count = 1 THEN 'One-Time'
        WHEN order_count BETWEEN 2 AND 5 THEN 'Repeat'
        ELSE 'Loyal'
    END AS customer_segment,

    COUNT(*) AS customers,
    ROUND(SUM(revenue)::numeric, 2) AS segment_revenue,
    ROUND(AVG(revenue)::numeric, 2) AS avg_customer_revenue

FROM customer_orders
GROUP BY
    CASE
        WHEN order_count = 1 THEN 'One-Time'
        WHEN order_count BETWEEN 2 AND 5 THEN 'Repeat'
        ELSE 'Loyal'
    END
ORDER BY segment_revenue DESC;

-- Q3. Customer revenue share/rank
WITH customer_sales AS(
 SELECT o.customer_id,SUM(oi.qty*oi.price) revenue
 FROM orders o JOIN order_items oi ON oi.order_id=o.order_id
 GROUP BY o.customer_id
)
SELECT customer_id,revenue,
 DENSE_RANK() OVER(ORDER BY revenue DESC) revenue_rank,
 ROUND((100*revenue/NULLIF(SUM(revenue) OVER(),0))::numeric,2) revenue_share_pct
FROM customer_sales ORDER BY revenue_rank;

-- Q4. Customers with no orders
SELECT c.customer_id,c.city,c.signup_date
FROM customers c LEFT JOIN orders o ON o.customer_id=c.customer_id
WHERE o.customer_id IS NULL;

-- Q5. First/latest order
SELECT customer_id,MIN(order_date)::date first_order,
 MAX(order_date)::date latest_order,COUNT(DISTINCT order_id) order_count
FROM orders GROUP BY customer_id ORDER BY order_count DESC;

