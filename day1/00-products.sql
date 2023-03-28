-- create table in postgres database

-- add TABLE products
CREATE TABLE products ( 
    product_code CHAR(4) PRIMARY KEY, 
    product_name VARCHAR(50) NOT NULL, 
    product_price INT NOT NULL, 
    product_amount INT NOT NULL );

-- view products
SELECT  * FROM products;

-- input product
INSERT INTO products(
	product_code,
	product_name,
	product_price,
	product_amount
) VALUES (
	'z001',
	'monitor',
	1000000000,
	5
),
(
	'z002',
	'keyboard',
	50000000,
	4
),
(
	'z003',
	'speaker',
	3000000,
	3
);

-- sorting A - Z
SELECT * FROM products
    ORDER BY product_name ASC;

-- sorting Z - A
SELECT  * FROM products
    ORDER BY product_name DESC;
    
-- update product UPDATE products
UPDATE products 
    SET product_amount = 3
    WHERE product_code = 'z003';

-- rename field TABLE 
ALTER TABLE products 
    RENAME COLUMN product_amount 
        TO product_stock;

-- rename TABLE
ALTER TABLE products 
    RENAME TO computer_products;

