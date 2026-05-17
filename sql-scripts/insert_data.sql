USE shopease_db;


-- populate tables 

INSERT INTO customers (
    customer_id,
    first_name,
    last_name,
    email,
    city,
    state,
    join_date,
    is_premium
)
SELECT
    customer_id,

    SUBSTRING_INDEX(MIN(customer_name), ' ', 1),

    CASE
        WHEN MIN(customer_name) LIKE '% %'
        THEN SUBSTRING_INDEX(MIN(customer_name), ' ', -1)
        ELSE 'Unknown'
    END,

    CONCAT(
        LOWER(REPLACE(MIN(customer_name), ' ', '_')),
        '@gmail.com'
    ),

    MIN(city),
    MIN(state),
    CURDATE(),
    FALSE

FROM superstore_raw
GROUP BY customer_id;


INSERT INTO products (
    product_id,
    product_name,
    category,
    brand,
    unit_price,
    stock_qty
)
SELECT
    product_id,
    MIN(product_name),
    MIN(category),
    'Unknown',

    ROUND(
        AVG(sales / NULLIF(quantity, 0)),
        2
    ),

    100
FROM superstore_raw
WHERE quantity > 0
GROUP BY product_id;



INSERT INTO orders (
    order_id,
    customer_id,
    order_date,
    status,
    total_amount
)
SELECT
    order_id,
    customer_id,
    MIN(order_date),
    'Delivered',
    ROUND(SUM(sales), 2)
FROM superstore_raw
GROUP BY order_id, customer_id;


INSERT INTO order_items (
    item_id,
    order_id,
    product_id,
    quantity,
    unit_price,
    discount_pct
)
SELECT
    row_id,
    order_id,
    product_id,
    quantity,

    ROUND(
        sales / NULLIF(quantity, 0),
        2
    ),

    discount * 100
FROM superstore_raw
WHERE quantity > 0;

-- query to check out  the tables
SELECT 'customers' AS table_name,
COUNT(*) AS total_rows
FROM customers

UNION ALL

SELECT 'products',
COUNT(*)
FROM products

UNION ALL

SELECT 'orders',
COUNT(*)
FROM orders

UNION ALL

SELECT 'order_items',
COUNT(*)
FROM order_items

UNION ALL

SELECT 'superstore_raw',
COUNT(*)
FROM superstore_raw;