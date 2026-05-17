USE shopease_db;
-- 2.) inspect table
DESCRIBE customers;
DESCRIBE products;
DESCRIBE orders;
DESCRIBE order_items;
-- 2.) display head 
SELECT * FROM customers LIMIT 10;
SELECT * FROM products LIMIT 10;
SELECT * FROM orders LIMIT 10;
SELECT * FROM order_items LIMIT 10;
 
-- 3.)Sales by Region 
SELECT region, SUM(sales) AS total_sales
FROM superstore_raw
GROUP BY region
ORDER BY total_sales DESC;

-- 3.)Sales by Category 
SELECT category, SUM(sales) AS total_sales
FROM superstore_raw
GROUP BY category
ORDER BY total_sales DESC;

-- 3.) High sales orders (>10000)
SELECT *
FROM superstore_raw
WHERE sales > 10000
ORDER BY sales DESC;
-- 3.) Sales by date
SELECT *
FROM superstore_raw
WHERE order_date BETWEEN '2017-01-01' AND '2017-01-03'
ORDER BY order_date;
-- 4.) Sales, quantity, avg order value per category
SELECT 
    category,
    SUM(sales) AS total_sales,
    SUM(quantity) AS total_quantity,
    AVG(sales) AS avg_sales
FROM superstore_raw
GROUP BY category
ORDER BY total_sales DESC;


-- 5.)Top 10 products by sales
SELECT 
    product_name,
    SUM(sales) AS total_sales
FROM superstore_raw
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 10;

-- 5.)Top 10 categories
SELECT 
    category,
    SUM(sales) AS total_sales
FROM superstore_raw
GROUP BY category
ORDER BY total_sales DESC
LIMIT 10;

-- 6.)Monthly sales trend
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(sales) AS monthly_sales
FROM superstore_raw
GROUP BY month
ORDER BY month;

-- 6.) Top  customers 
SELECT 
    customer_id,
    SUM(sales) AS total_spent
FROM superstore_raw
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 10;

-- 7.) FINAL VALIDATION SUMMARY

SELECT 
    'TOTAL ROWS' AS metric,
    COUNT(*) AS value
FROM superstore_raw

UNION ALL

SELECT 
    'TOTAL SALES',
    ROUND(SUM(sales),2)
FROM superstore_raw

UNION ALL

SELECT 
    'TOTAL PROFIT',
    ROUND(SUM(profit),2)
FROM superstore_raw;