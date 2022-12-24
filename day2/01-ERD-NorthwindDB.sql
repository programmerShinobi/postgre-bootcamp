-- supplier
CREATE TABLE supplier (
	supplier_id smallINT,
	company_name VARCHAR(40),
	contact_name VARCHAR(30),
	contact_title VARCHAR(30),
	address VARCHAR(60),
	city VARCHAR(15),
	region VARCHAR(15),
	postal_code VARCHAR(10),
	country VARCHAR(15),
	phone VARCHAR(24),
	fax VARCHAR(24),
	homepage TEXT,
	CONSTRAINT pk_supplier_id
		PRIMARY KEY (supplier_id)
);

-- categories
CREATE TABLE categories (
	category_id smallINT,
	category_name VARCHAR(15),
	description TEXT,
	picture INT,
	CONSTRAINT pk_category_id
		PRIMARY KEY (category_id)
);

-- shippers
CREATE TABLE shippers (
	shipper_id smallINT,
	company_name VARCHAR(40),
	phone VARCHAR(24),
	CONSTRAINT pk_shipper_id
		PRIMARY KEY (shipper_id)
);

-- employees
CREATE TABLE employees (
	employee_id smallINT,
	last_name VARCHAR(20),
	first_name VARCHAR(10),
	title VARCHAR(30),
	title_of_courtesy VARCHAR(25),
	birth_date DATE,
	hire_date DATE,
	address VARCHAR(60),
	city VARCHAR(15),
	region VARCHAR(15),
	postal_code VARCHAR(10),
	country VARCHAR(15),
	home_phone VARCHAR(24),
	extension VARCHAR(4),
	photo INT,
	notes TEXT,
	reports_to smallINT,
	photo_path VARCHAR(255),
	CONSTRAINT pk_employee_id PRIMARY KEY (employee_id)
);

-- customers
CREATE TABLE customers(
	customer_id VARCHAR(5),
	company_name VARCHAR(40),
	contact_name VARCHAR(30),
	contact_title VARCHAR(30),
	address VARCHAR(60),
	city VARCHAR(15),
	region VARCHAR(15),
	postal_code VARCHAR(10),
	country VARCHAR(15),
	phone VARCHAR(24),
	fax VARCHAR(24),
	CONSTRAINT pk_customer_id PRIMARY KEY (customer_id)
);
	
-- products
CREATE TABLE products (
	product_id smallINT,
	product_name VARCHAR(40),
	quantity_per_unit VARCHAR(20),
	unit_price REAL,
	unit_in_stock smallINT,
	unit_in_order smallINT,
	reorder_level smallINT,
	discontinued INT,
	supplier_id smallINT,
	category_id smallINT,
	CONSTRAINT pk_product_id
		PRIMARY KEY (product_id),
	CONSTRAINT fk_supplier_id
		FOREIGN KEY (supplier_id)
			REFERENCES supplier(supplier_id),
	CONSTRAINT fk_category_id
		FOREIGN KEY (category_id)
			REFERENCES categories(category_id)
);

-- orders
CREATE TABLE orders (
	order_id smallINT,
	order_date DATE,
	required_date DATE,
	shipped_date DATE,
	freight REAL,
	ship_name VARCHAR(40),
	ship_address VARCHAR(60),
	ship_city VARCHAR(15),
	ship_region VARCHAR(15),
	ship_postal_code VARCHAR(10),
	ship_country VARCHAR(15),
	employee_id smallINT,
	customer_id VARCHAR(5),
	ship_via smallINT,
	CONSTRAINT pk_order_id
		PRIMARY KEY (order_id),
	CONSTRAINT fk_employee_id
		FOREIGN KEY (employee_id)
			REFERENCES employees(employee_id),
	CONSTRAINT fk_customer_id 
		FOREIGN KEY (customer_id) 
			REFERENCES customers(customer_id),
	CONSTRAINT fk_ship_via
		FOREIGN KEY (ship_via)
			REFERENCES shippers(shipper_id)
);

-- order_detail
CREATE TABLE order_detail (
	order_id smallINT,
	product_id smallINT,
	unit_price REAL,
	quantity smallINT,
	discount REAL,
	CONSTRAINT pk_order_id_product_id
		PRIMARY KEY (order_id, product_id),
	CONSTRAINT fk_order_id
		FOREIGN KEY (order_id)
			REFERENCES orders (order_id),
	CONSTRAINT fk_product_id
		FOREIGN KEY (product_id)
			REFERENCES products (product_id)
);





