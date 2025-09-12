

-- 1. Create a function "total_stock_available " to return the total stock quantity for a particular supplier name

delimiter $$
CREATE FUNCTION total_stock_available (s_name VARCHAR(60))
RETURNS INT
DETERMINISTIC
BEGIN
RETURN (SELECT SUM(p.stock_quantity) AS total_stocks
FROM products AS p 
INNER JOIN 
suppliers AS s
ON p.supplier_id = s.supplier_id
GROUP BY s.supplier_name
HAVING s.supplier_name = s_name);
END $$
delimiter ;

SELECT total_stock_available('Best Supplier Inc.') as stocks;

-- 2. create a function to return the product name for a supplier email as "sales@globalgoods.com" and category  id as '1'

delimiter $$
CREATE FUNCTION fetchName()
RETURNS VARCHAR(60)
DETERMINISTIC
BEGIN
RETURN(
SELECT product_name 
FROM products
WHERE supplier_id = (
	SELECT supplier_id FROM suppliers WHERE contact_email = 'sales@globalgoods.com'
) AND category_id = '1');
END $$
delimiter ;

select fetchName() as name;

-- 3 Create a procedure to return all the products

delimiter $$
CREATE PROCEDURE returnProds ()
BEGIN
SELECT product_name 
FROM products;
END $$
delimiter ;

call returnProds();

-- 4  Create a procedure to return total stock quantity for a particular category id passed as input

delimiter $$
CREATE PROCEDURE returnStocks (in cid int, out stocks int)
BEGIN
SELECT sum(stock_quantity) INTO stocks
FROM products
WHERE category_id = cid;
end $$
delimiter ;

CALL returnStocks(3, @stocks);
SELECT @stocks as stocks;
