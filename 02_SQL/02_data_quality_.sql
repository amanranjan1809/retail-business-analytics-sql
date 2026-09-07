-- CASE STUDY 02: DATA QUALITY

-- Q1. Duplicate order IDs
SELECT order_id,COUNT(*) duplicate_count
FROM orders GROUP BY order_id HAVING COUNT(*)>1;

-- Q2. Duplicate customer IDs
SELECT customer_id,COUNT(*) duplicate_count
FROM customers GROUP BY customer_id HAVING COUNT(*)>1;

-- Q3. Duplicate product IDs
SELECT product_id,COUNT(*) duplicate_count
FROM products GROUP BY product_id HAVING COUNT(*)>1;

-- Q4. Critical NULLs
SELECT COUNT(*) total_orders,
 COUNT(*) FILTER(WHERE order_id IS NULL) null_order_id,
 COUNT(*) FILTER(WHERE customer_id IS NULL) null_customer_id,
 COUNT(*) FILTER(WHERE store_id IS NULL) null_store_id,
 COUNT(*) FILTER(WHERE order_date IS NULL) null_order_date
FROM orders;

SELECT COUNT(*) total_order_items,
 COUNT(*) FILTER(WHERE order_item_id IS NULL) null_order_item_id,
 COUNT(*) FILTER(WHERE order_id IS NULL) null_order_id,
 COUNT(*) FILTER(WHERE product_id IS NULL) null_product_id,
 COUNT(*) FILTER(WHERE qty IS NULL) null_qty,
 COUNT(*) FILTER(WHERE price IS NULL) null_price
FROM order_items;

-- Q5. Invalid quantity/price
SELECT * FROM order_items WHERE qty<=0 OR price<0;

-- Q6. Orphan order items
SELECT oi.* FROM order_items oi
LEFT JOIN orders o ON o.order_id=oi.order_id
WHERE o.order_id IS NULL;

-- Q7. Orphan product references
SELECT oi.* FROM order_items oi
LEFT JOIN products p ON p.product_id=oi.product_id
WHERE p.product_id IS NULL;

-- Q8. Orders without items
SELECT o.* FROM orders o
LEFT JOIN order_items oi ON oi.order_id=o.order_id
WHERE oi.order_id IS NULL;

-- Q9. Orders without payments
SELECT o.* FROM orders o
LEFT JOIN payments p ON p.order_id=o.order_id
WHERE p.order_id IS NULL;