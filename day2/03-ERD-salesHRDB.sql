-- INSERT 1
-- locations
CREATE TABLE locations (
	location_id INT,
	CONSTRAINT pk_location_id
		PRIMARY KEY (location_id)
);

-- employees
CREATE TABLE employees (
	employee_id INT,
	CONSTRAINT pk_employee_id
		PRIMARY KEY (employee_id)
);

-- categories
CREATE TABLE shippers (
	ship_id INT,
	ship_name VARCHAR(40),
	ship_phone VARCHAR(24),
	CONSTRAINT pk_ship_id
		PRIMARY KEY (ship_id)
);

CREATE TABLE categories (
	cate_id INT,
	cate_name VARCHAR(15),
	cate_description TEXT,
	CONSTRAINT pk_cate_id
		PRIMARY KEY (cate_id)
);

-- suppliers
CREATE TABLE suppliers (
	supr_id INT,
	supr_name VARCHAR(40),
	supr_contact_name VARCHAR(30),
	supr_city VARCHAR(15),
	supr_location_id INT,
	CONSTRAINT pk_supr_id
		PRIMARY KEY (supr_id),
	CONSTRAINT fk_supr_location_id
		FOREIGN KEY (supr_location_id)
			REFERENCES locations(location_id)
);

-- customers
CREATE TABLE customers (
	cust_id INT,
	cust_name VARCHAR(40),
	cust_city VARCHAR(15),
	cust_location_id INT,
	CONSTRAINT pk_cust_id
		PRIMARY KEY (cust_id),
	CONSTRAINT fk_cust_location_id
		FOREIGN KEY (cust_location_id)
			REFERENCES locations(location_id)
);

-- products
CREATE TABLE products (
	prod_id INT,
	prod_name VARCHAR(40),
	prod_quantity VARCHAR(20),
	prod_price MONEY,
	prod_in_stock smallINT,
	prod_on_order smallINT,
	prod_reorder_level smallINT,
	prod_discontinued BIT,
	prod_cate_id INT,
	prod_supr_id INT,
	CONSTRAINT pk_prod_id
		PRIMARY KEY (prod_id),
	CONSTRAINT fk_prod_cate_id
		FOREIGN KEY (prod_cate_id)
			REFERENCES categories(cate_id),
	CONSTRAINT fk_supr_id
		FOREIGN KEY (prod_supr_id)
			REFERENCES suppliers(supr_id)	
);


-- INSERT 2
-- orders
CREATE TABLE orders (
	order_id INT,
	order_date DATE,
	order_required_date DATE,
	order_shipped_date DATE,
	order_freight MONEY,
	order_subtotal MONEY,
	order_total_qty smallINT,
	order_ship_city VARCHAR(15),
	order_ship_address VARCHAR(60),
	order_status VARCHAR(15),
	order_employee_id INT,
	order_cust_id INT,
	order_ship_id INT,
	CONSTRAINT pk_order_id
		PRIMARY KEY (order_id),
	CONSTRAINT fk_order_employee_id
		FOREIGN KEY (order_employee_id)
			REFERENCES employees(employee_id),
	CONSTRAINT fk_order_cust_id
		FOREIGN KEY (order_cust_id)
			REFERENCES customers(cust_id),
	CONSTRAINT fk_order_ship_id
		FOREIGN KEY (order_ship_id)
			REFERENCES shippers(ship_id)	
);

-- orders_detail
CREATE TABLE orders_detail (
	ordet_order_id INT,
	ordet_prod_id INT,
	ordet_price MONEY,
	ordet_quantity smallINT,
	ordet_discount REAL,
	CONSTRAINT pk_ordet_order_id_prod_id
		PRIMARY KEY (ordet_order_id, ordet_prod_id),
	CONSTRAINT fk_ordet_order_id
		FOREIGN KEY (ordet_order_id)
			REFERENCES orders(order_id),
	CONSTRAINT fk_ordet_prod_id
		FOREIGN KEY (ordet_prod_id)
			REFERENCES products(prod_id)
);

