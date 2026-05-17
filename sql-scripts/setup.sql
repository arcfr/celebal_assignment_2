CREATE DATABASE IF NOT EXISTS shopease_db;

USE shopease_db;


-- RAW TABLE
CREATE TABLE superstore_raw (
    row_id INT,
    order_id VARCHAR(50),
    order_date DATE,
    ship_date DATE,
    ship_mode VARCHAR(50),

    customer_id VARCHAR(50),
    customer_name VARCHAR(100),
    segment VARCHAR(50),

    country VARCHAR(100),
    city VARCHAR(100),
    state VARCHAR(100),
    postal_code VARCHAR(20),
    region VARCHAR(50),

    product_id VARCHAR(50),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name VARCHAR(255),

    sales DECIMAL(10,2),
    quantity INT,
    discount DECIMAL(5,2),
    profit DECIMAL(10,2)
);

CREATE TABLE customers (
    customer_id VARCHAR(50) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    join_date DATE NOT NULL,
    is_premium BOOLEAN DEFAULT FALSE
);

CREATE TABLE products (
    product_id VARCHAR(50) PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    category VARCHAR(50) NOT NULL,
    brand VARCHAR(50) NOT NULL,
    unit_price DECIMAL(10,2)
        CHECK(unit_price > 0),
    stock_qty INT DEFAULT 0
        CHECK(stock_qty >= 0)
);

CREATE TABLE orders (
    order_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50),
    order_date DATE NOT NULL,
    status VARCHAR(20)
        DEFAULT 'Delivered',

    total_amount DECIMAL(12,2),

    FOREIGN KEY(customer_id)
    REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    item_id INT PRIMARY KEY,
    order_id VARCHAR(50),
    product_id VARCHAR(50),
    quantity INT
        CHECK(quantity > 0),

    unit_price DECIMAL(10,2),

    discount_pct DECIMAL(5,2)
        DEFAULT 0,

    FOREIGN KEY(order_id)
    REFERENCES orders(order_id),

    FOREIGN KEY(product_id)
    REFERENCES products(product_id)
);