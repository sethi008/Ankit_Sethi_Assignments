-- MySQL Assignment 1

CREATE DATABASE training;

USE training;

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10,2),
    stock INT,
    rating DECIMAL(3,2),
    created_at DATE
);

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    country VARCHAR(50)
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    order_date DATE,
    quantity INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


INSERT INTO products (product_name, category, price, stock, rating, created_at) VALUES
('Wireless Mouse', 'Electronics', 25.99, 150, 4.5, '2025-08-10'),
('Bluetooth Speaker', 'Electronics', 45.00, 80, 4.7, '2025-08-01'),
('Running Shoes', 'Footwear', 60.00, 200, 4.3, '2025-07-15'),
('Leather Wallet', 'Accessories', 30.00, 300, 4.2, '2025-06-20'),
('Laptop Stand', 'Electronics', 20.50, 50, 4.6, '2025-08-20'),
('Smart Watch', 'Electronics', 120.00, 40, 4.8, '2025-08-25'),
('Casual Shirt', 'Clothing', 25.00, 180, 4.1, '2025-07-30'),
('Backpack', 'Accessories', 40.00, 90, 4.4, '2025-06-10'),
('Sunglasses', 'Accessories', 15.00, 250, 4.0, '2025-08-05'),
('Formal Shoes', 'Footwear', 80.00, 60, 4.6, '2025-08-18');


INSERT INTO customers (customer_name, email, country) VALUES
('Alice Johnson', 'alice.j@example.com', 'USA'),
('Bob Smith', 'bob.smith@example.com', 'Canada'),
('Carlos Diaz', 'carlos.d@example.com', 'Mexico'),
('Diana Patel', 'diana.p@example.com', 'India'),
('Elena Rossi', 'elena.r@example.com', 'Italy'),
('Frank Zhang', 'frank.z@example.com', 'China'),
('Grace Kim', 'grace.k@example.com', 'South Korea'),
('Hassan Ali', 'hassan.a@example.com', 'UAE'),
('Isabelle Laurent', 'isabelle.l@example.com', 'France'),
('Jack Lee', 'jack.lee@example.com', 'USA');


INSERT INTO orders (customer_id, product_id, order_date, quantity) VALUES
(1, 1, '2025-08-05', 2),
(2, 2, '2025-08-06', 1),
(3, 3, '2025-08-07', 3),
(1, 4, '2025-08-10', 1),
(4, 5, '2025-08-10', 2),
(5, 6, '2025-08-12', 1),
(6, 1, '2025-08-15', 4),
(7, 3, '2025-08-16', 2),
(8, 2, '2025-08-17', 1),
(9, 8, '2025-08-18', 1),
(10, 10, '2025-08-19', 2),
(2, 9, '2025-08-20', 1),
(3, 7, '2025-08-21', 3),
(4, 1, '2025-08-21', 1),
(5, 5, '2025-08-22', 2);

-- 1
SELECT * FROM products WHERE category="Accessories";

-- 2
SELECT * FROM products ORDER BY price DESC LIMIT 3;

-- 3
SELECT* FROM products WHERE stock<100;

--4 
ALTER TABLE products 
ADD COLUMN Brand VARCHAR(20);

-- 5
UPDATE products 
SET Brand = "TechZone"
WHERE category="Electronics";

-- 6
ALTER TABLE products
ADD COLUMN discount DECIMAL(5,2);

-- 7
SELECT Category, AVG(price)
FROM products
GROUP BY category;

-- 8
SELECT * FROM products
WHERE created_at LIKE "2025-08%";

-- 9
SELECT category, COUNT(*)
FROM products
WHERE rating > 4.5
GROUP BY category;

-- 10
SELECT * FROM products
ORDER BY rating DESC;

-- 11
DELETE FROM products
WHERE stock=0;

--12 
SELECT p.product_name, SUM(o.quantity)
FROM products AS p 
INNER JOIN
orders AS o
ON p.product_id = o.product_id
GROUP BY p.product_name;

-- 13
SELECT c.customer_name, c.email, c.country, temp.product_name
FROM customers AS c
JOIN
(SELECT o.customer_id, p.product_name
FROM products AS p
INNER JOIN 
orders AS o
ON o.product_id = p.product_id) AS temp
ON c.customer_id = temp.customer_id;

SELECT c.customer_name, c.email, c.country, p.product_name
FROM customers c, orders o, products p
WHERE o.product_id = p.product_id AND c.customer_id = o.customer_id;
