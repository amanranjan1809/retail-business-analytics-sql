- CASE STUDY 06: PRODUCT & CATEGORY ANALYTICS

-- Q1. Top products by revenue
SELECT product_id,SUM(qty) units_sold,COUNT(DISTINCT order_id) orders,
 SUM(qty*price) revenue
FROM order_items GROUP BY product_id ORDER BY revenue DESC LIMIT 20;

-- Q2. Top products by volume
SELECT product_id,SUM(qty) units_sold
FROM order_items GROUP BY product_id ORDER BY units_sold DESC LIMIT 20;

-- Q3. Category performance
SELECT c.category_id,c.category_name,
 COUNT(DISTINCT p.product_id) products,SUM(oi.qty) units_sold,
 SUM(oi.qty*oi.price) revenue
FROM categories c
LEFT JOIN products p ON p.category_id=c.category_id
LEFT JOIN order_items oi ON oi.product_id=p.product_id
GROUP BY c.category_id,c.category_name ORDER BY revenue DESC NULLS LAST;

-- Q4. Top 3 products per category
WITH product_sales AS(
 SELECT p.category_id,p.product_id,SUM(oi.qty*oi.price) revenue
 FROM products p JOIN order_items oi ON oi.product_id=p.product_id
 GROUP BY p.category_id,p.product_id
),
ranked AS(
 SELECT *,DENSE_RANK() OVER(PARTITION BY category_id ORDER BY revenue DESC) category_rank
 FROM product_sales
)
SELECT * FROM ranked WHERE category_rank<=3
ORDER BY category_id,category_rank;


-- Q5. Top-10 product revenue concentration
WITH product_sales AS(
 SELECT product_id,SUM(qty*price) revenue FROM order_items GROUP BY product_id
),ranked AS(
 SELECT *,DENSE_RANK() OVER(ORDER BY revenue DESC) rnk FROM product_sales
)
SELECT SUM(CASE WHEN rnk<=10 THEN revenue ELSE 0 END) top_10_revenue,
 SUM(revenue) total_revenue,
 ROUND((100*SUM(CASE WHEN rnk<=10 THEN revenue ELSE 0 END)/NULLIF(SUM(revenue),0))::numeric,2)
 top_10_share_pct
FROM ranked;
