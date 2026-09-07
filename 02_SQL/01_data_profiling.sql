-- CASE STUDY 01: DATA PROFILING

-- Q1. Number of tables
SELECT COUNT(*) AS total_tables
FROM information_schema.tables
WHERE table_schema='public' AND table_type='BASE TABLE';

-- Q2. Table inventory
SELECT table_name
FROM information_schema.tables
WHERE table_schema='public' AND table_type='BASE TABLE'
ORDER BY table_name;

-- Q3. Columns and data types
SELECT table_name, ordinal_position, column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_schema='public'
ORDER BY table_name, ordinal_position;

-- Q4. Primary keys
SELECT tc.table_name, kcu.column_name, tc.constraint_name
FROM information_schema.table_constraints tc
JOIN information_schema.key_column_usage kcu
 ON tc.constraint_name=kcu.constraint_name AND tc.table_schema=kcu.table_schema
WHERE tc.table_schema='public' AND tc.constraint_type='PRIMARY KEY'
ORDER BY tc.table_name,kcu.ordinal_position;

-- Q5. Foreign keys
SELECT tc.table_name,kcu.column_name,ccu.table_name AS referenced_table,
       ccu.column_name AS referenced_column
FROM information_schema.table_constraints tc
JOIN information_schema.key_column_usage kcu
 ON tc.constraint_name=kcu.constraint_name AND tc.table_schema=kcu.table_schema
JOIN information_schema.constraint_column_usage ccu
 ON ccu.constraint_name=tc.constraint_name AND ccu.table_schema=tc.table_schema
WHERE tc.table_schema='public' AND tc.constraint_type='FOREIGN KEY'
ORDER BY tc.table_name,kcu.column_name;

-- Q6. Core table row counts
SELECT 'customers' table_name,COUNT(*) row_count FROM customers
UNION ALL SELECT 'orders',COUNT(*) FROM orders
UNION ALL SELECT 'order_items',COUNT(*) FROM order_items
UNION ALL SELECT 'products',COUNT(*) FROM products
UNION ALL SELECT 'categories',COUNT(*) FROM categories
UNION ALL SELECT 'payments',COUNT(*) FROM payments
UNION ALL SELECT 'employees',COUNT(*) FROM employees
UNION ALL SELECT 'stores',COUNT(*) FROM stores
UNION ALL SELECT 'suppliers',COUNT(*) FROM suppliers
ORDER BY row_count DESC;

-- Q7. Order date coverage
SELECT MIN(order_date)::date first_order_date,MAX(order_date)::date last_order_date
FROM orders;