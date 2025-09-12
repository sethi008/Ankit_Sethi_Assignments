-- MySql Solutions

CREATE DATABASE amdocs;

USE amdocs;

CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT
);

CREATE TABLE suppliers (
    supplier_id SERIAL PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL,
    contact_email VARCHAR(100),
    phone VARCHAR(20)
);

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category_id INT REFERENCES categories(category_id) ,
    supplier_id INT REFERENCES suppliers(supplier_id) ,
    price NUMERIC(10, 2) CHECK (price >= 0),
    stock_quantity INT CHECK (stock_quantity >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO categories (category_name, description) VALUES
('Electronics', 'Devices and gadgets'),
('Books', 'Printed and digital books'),
('Clothing', 'Apparel and accessories');

INSERT INTO suppliers (supplier_name, contact_email, phone) VALUES
('Best Supplier Inc.', 'contact@bestsupplier.com', '123-456-7890'),
('Global Goods', 'sales@globalgoods.com', '987-654-3210');

INSERT INTO products (product_name, category_id, supplier_id, price, stock_quantity) VALUES
('Smartphone Model X', 1, 1, 699.99, 50),
('Wireless Headphones', 1, 2, 199.99, 30),
('Mystery Novel', 2, 1, 14.99, 100),
('T-shirt Classic', 3, 2, 9.99, 200),
('E-reader', 1, 1, 129.99, 10);

-- Questions (DDL + DML)
-- Write SQL to create the three tables: categories, suppliers, and products.

-- (a) Retrieve a list of all products with their category name and supplier name.
SELECT p.product_name, c.category_name, s.supplier_name
FROM products AS p, categories AS c, suppliers AS s
WHERE p.category_id = c.category_id AND p.supplier_id = s.supplier_id;

-- (b) Find all products where stock quantity is below 5.
SELECT * FROM products
WHERE stock_quantity<5;

-- (c) Add a new column discount_percent to the products table with a default value of 0.
ALTER TABLE products 
ADD COLUMN discount_percent INT DEFAULT 0;

-- (d) Write a query to reduce the price of all products in the "Electronics" category by 15%.
UPDATE products AS p
INNER JOIN categories AS c
ON p.category_id = c.category_id
SET price = price*85/100
WHERE category_name="Electronics";

-- Questions (Aggregate, Filtering, Grouping, Sorting)
-- (e) Find the total number of products available in the products table.
SELECT COUNT(*) FROM products;

-- (f) Find the average price of all products.
SELECT AVG(price) FROM products;

-- (g) Find the maximum and minimum price of products in the "Electronics" category.
SELECT MIN(price), MAX(price) 
FROM products
WHERE category_id = (
SELECT category_id FROM categories WHERE category_name='Electronics');

-- (h) List categories along with the count of products in each category.
SELECT c.category_name, COUNT(*) AS products
FROM categories AS c
INNER JOIN
products AS p
ON c.category_id = p.category_id
GROUP BY c.category_name;

-- (i) List suppliers who supply products priced between $50 and $200.
SELECT s.supplier_name 
FROM suppliers AS s, products AS p
WHERE s.supplier_id = p.supplier_id AND p.price BETWEEN 50 AND 200;

-- (j) Find all products whose category_id is in the list of category IDs (1, 3).
SELECT * FROM products 
WHERE category_id IN (1,3);

-- (k) Find the total stock quantity per category but only for categories having more than 1 product.
SELECT c.category_name, SUM(p.stock_quantity) AS total_stocks
FROM products AS p, categories AS c
WHERE p.category_id = c.category_id
GROUP BY c.category_name
HAVING COUNT(*) > 1;

-- (l) List all products grouped by supplier and show the average price per supplier, but only for suppliers whose average product price is greater than $100.
SELECT s.supplier_name, AVG(p.price) AS Average_Price
FROM products AS p, suppliers AS s
WHERE p.supplier_id = s.supplier_id
GROUP BY s.supplier_name
HAVING AVG(p.price) > 100;

-- (m) List all products sorted by price in descending order.
SELECT * FROM products
ORDER BY price DESC;

-- (n) List the total value of stock (price * stock_quantity) for each category, ordered by total value from highest to lowest.
SELECT c.category_name, SUM(p.price * p.stock_quantity) AS Total_Stock_Value
FROM categories AS c, products AS p
WHERE c.category_id = p.category_id
GROUP BY c.category_name
ORDER BY Total_Stock_Value DESC;

-- ---------JOINS------------
-- (a) List all products with their corresponding category name using an INNER JOIN:
SELECT p.product_name, c.category_name
FROM products p
INNER JOIN categories c ON p.category_id = c.category_id;


-- (b) List all products with their category name, including products that do not belong to any category (LEFT JOIN):
SELECT p.product_name, c.category_name
FROM products p
LEFT JOIN categories c ON p.category_id = c.category_id;


-- (c) List all categories and the count of products in each category, including categories with no products (LEFT JOIN and GROUP BY):
SELECT c.category_name, COUNT(p.product_id) AS product_count
FROM categories c
LEFT JOIN products p ON c.category_id = p.category_id
GROUP BY c.category_name;


-- (d) List all products along with their supplier names, including products that have no supplier assigned (LEFT JOIN):
SELECT p.product_name, s.supplier_name
FROM products p
LEFT JOIN suppliers s ON p.supplier_id = s.supplier_id;


-- (e) List all suppliers and the products they supply, including suppliers who supply no products (RIGHT JOIN):
SELECT s.supplier_name, p.product_name
FROM suppliers s
RIGHT JOIN products p ON s.supplier_id = p.supplier_id;


-- (f) Find all products that do not have a supplier assigned:
SELECT * 
FROM products
WHERE supplier_id IS NULL;


-- (g) Get all products with their category name and supplier name using multiple JOINs (join products with both categories and suppliers):
SELECT p.product_name, c.category_name, s.supplier_name
FROM products p
INNER JOIN categories c ON p.category_id = c.category_id
INNER JOIN suppliers s ON p.supplier_id = s.supplier_id;


-- (h) Get a list of all suppliers and categories, even if there are no products linking them (FULL OUTER JOIN between suppliers and categories):
SELECT s.supplier_name, c.category_name
FROM suppliers s
FULL OUTER JOIN categories c ON s.supplier_id = c.category_id;


-- (i) Find products where the supplier's contact email is not null using a join:
SELECT p.product_name, s.contact_email
FROM products p
INNER JOIN suppliers s ON p.supplier_id = s.supplier_id
WHERE s.contact_email IS NOT NULL;


-- (j) Find categories that have products supplied by supplier named 'Global Goods':
SELECT DISTINCT c.category_name
FROM categories c
INNER JOIN products2 p ON c.category_id = p.category_id
INNER JOIN suppliers s ON p.supplier_id = s.supplier_id
WHERE s.supplier_name = 'Global Goods';
