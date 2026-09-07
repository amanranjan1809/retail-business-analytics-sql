-- CASE STUDY 09: ADVANCED SQL

-- Q1. Month-over-month growth
WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', o.order_date::date)::date AS sales_month,
        SUM(oi.qty * oi.price) AS revenue
    FROM orders o
    JOIN order_items oi
        ON oi.order_id = o.order_id
    GROUP BY 1
),
comparison AS (
    SELECT
        sales_month,
        revenue,
        LAG(revenue) OVER (
            ORDER BY sales_month
        ) AS previous_revenue
    FROM monthly_sales
)
SELECT
    sales_month,
    ROUND(revenue::numeric, 2) AS revenue,
    ROUND(previous_revenue::numeric, 2) AS previous_revenue,
    ROUND(
        (
            100.0 * (revenue - previous_revenue)
            / NULLIF(previous_revenue, 0)
        )::numeric,
        2
    ) AS mom_growth_pct
FROM comparison
ORDER BY sales_month;

-- Q2. Running revenue

WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', o.order_date::date)::date AS sales_month,
        SUM(oi.qty * oi.price) AS revenue
    FROM orders o
    JOIN order_items oi
        ON oi.order_id = o.order_id
    GROUP BY 1
)

SELECT
    sales_month,
    ROUND(revenue::numeric, 2) AS revenue,
    ROUND(
        SUM(revenue) OVER (
            ORDER BY sales_month
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        )::numeric,
        2
    ) AS cumulative_revenue
FROM monthly_sales
ORDER BY sales_month;

-- Q3. Customers above average revenue
WITH customer_sales AS(
 SELECT o.customer_id,SUM(oi.qty*oi.price) revenue
 FROM orders o JOIN order_items oi ON oi.order_id=o.order_id
 GROUP BY o.customer_id
)
SELECT customer_id,revenue
FROM customer_sales
WHERE revenue>(SELECT AVG(revenue) FROM customer_sales)
ORDER BY revenue DESC;

-- Q4. Product rank within category
WITH product_sales AS(
 SELECT p.category_id,p.product_id,SUM(oi.qty*oi.price) revenue
 FROM products p JOIN order_items oi ON oi.product_id=p.product_id
 GROUP BY p.category_id,p.product_id
)
SELECT category_id,product_id,revenue,
 ROW_NUMBER() OVER(PARTITION BY category_id ORDER BY revenue DESC) product_rank
FROM product_sales ORDER BY category_id,product_rank;

-- Q5. Pareto-style customer concentration
WITH customer_sales AS(
 SELECT o.customer_id,SUM(oi.qty*oi.price) revenue
 FROM orders o JOIN order_items oi ON oi.order_id=o.order_id
 GROUP BY o.customer_id
),ranked AS(
 SELECT customer_id,revenue,
 SUM(revenue) OVER(ORDER BY revenue DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) cumulative_revenue,
 SUM(revenue) OVER() total_revenue
 FROM customer_sales
)
SELECT customer_id,revenue,
 ROUND((100*cumulative_revenue/NULLIF(total_revenue,0))::numeric,2) cumulative_revenue_pct
FROM ranked ORDER BY revenue DESC;

-- Q6. Customer frequency segmentation
WITH customer_orders AS(
 SELECT customer_id,COUNT(DISTINCT order_id) order_count
 FROM orders GROUP BY customer_id
)
SELECT customer_id,order_count,
 CASE WHEN order_count=1 THEN 'One-Time'
 WHEN order_count BETWEEN 2 AND 5 THEN 'Repeat'
 ELSE 'Loyal' END segment
FROM customer_orders ORDER BY order_count DESC;

-- Q7. Signup-to-first-order activation gap
WITH first_orders AS(
 SELECT customer_id,MIN(order_date)::date first_order_date
 FROM orders GROUP BY customer_id
)
SELECT c.customer_id,c.signup_date::date signup_date,
 f.first_order_date,f.first_order_date-c.signup_date::date days_to_first_order
FROM customers c JOIN first_orders f ON f.customer_id=c.customer_id
ORDER BY days_to_first_order;
