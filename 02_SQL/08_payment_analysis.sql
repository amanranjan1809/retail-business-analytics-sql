-- CASE STUDY 08: PAYMENT RECONCILIATION

-- Q1. Order value vs paid amount
WITH order_values AS(
 SELECT order_id,SUM(qty*price) order_value
 FROM order_items GROUP BY order_id
),payments_by_order AS(
 SELECT order_id,SUM(amount) paid_amount
 FROM payments GROUP BY order_id
)
SELECT ov.order_id,ov.order_value,COALESCE(pbo.paid_amount,0) paid_amount,
 COALESCE(pbo.paid_amount,0)-ov.order_value variance
FROM order_values ov LEFT JOIN payments_by_order pbo ON pbo.order_id=ov.order_id
ORDER BY ABS(COALESCE(pbo.paid_amount,0)-ov.order_value) DESC;

-- Q2. Material mismatches
WITH reconciliation AS(
 SELECT ov.order_id,ov.order_value,COALESCE(pbo.paid_amount,0) paid_amount
 FROM (SELECT order_id,SUM(qty*price) order_value FROM order_items GROUP BY order_id) ov
 LEFT JOIN (SELECT order_id,SUM(amount) paid_amount FROM payments GROUP BY order_id) pbo
 ON pbo.order_id=ov.order_id
)
SELECT *,paid_amount-order_value variance
FROM reconciliation
WHERE ABS(paid_amount-order_value)>0.01
ORDER BY ABS(paid_amount-order_value) DESC;

-- Q3. Unpaid orders
SELECT COUNT(*) unpaid_orders
FROM orders o LEFT JOIN payments p ON p.order_id=o.order_id
WHERE p.order_id IS NULL;
